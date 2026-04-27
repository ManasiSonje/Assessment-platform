package com.assessment.coding.service;

import com.assessment.coding.dto.*;
import com.assessment.coding.entity.*;
import com.assessment.coding.enums.SubmissionStatus;
import com.assessment.coding.repository.QuestionRepository;
import com.assessment.coding.repository.SubmissionRepository;
import com.assessment.coding.repository.SubmissionResultRepository;
import com.assessment.coding.repository.TestCaseRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Slf4j
@Service
@RequiredArgsConstructor
public class SubmissionService {

    private final SubmissionRepository submissionRepository;
    private final SubmissionResultRepository submissionResultRepository;
    private final QuestionRepository questionRepository;
    private final TestCaseRepository testCaseRepository;
    private final CodeExecutionService executionService;

    @Transactional
    public SubmissionDetailResponseDTO createSubmission(SubmissionRequestDTO request, Long userId) {
        Question question = questionRepository.findById(request.getQuestionId())
                .orElseThrow(() -> new RuntimeException("Question not found with id: " + request.getQuestionId()));

        Submission submission = Submission.builder()
                .userId(userId)
                .question(question)
                .language(request.getLanguage())
                .sourceCode(request.getSourceCode())
                .status(SubmissionStatus.PROCESSING)
                .build();

        submission = submissionRepository.save(submission);
        log.info("Created submission for user {} question {}", userId, request.getQuestionId());

        Submission evaluated = evaluateSubmission(submission);
        
        return mapToDetailResponseDTO(evaluated);
    }

    @Transactional
    public Submission evaluateSubmission(Submission submission) {
        Question question = submission.getQuestion();
        List<TestCase> testCases = testCaseRepository.findByQuestionIdAndIsHiddenFalse(question.getId());

        if (testCases.isEmpty()) {
            testCases = testCaseRepository.findByQuestionId(question.getId());
        }

        int passedCount = 0;
        int totalCount = testCases.size();
        long totalExecutionTime = 0;
        StringBuilder errorMessage = new StringBuilder();
        
        List<SubmissionResult> results = new ArrayList<>();

        for (int i = 0; i < testCases.size(); i++) {
            TestCase testCase = testCases.get(i);
            String testInput = testCase.getInput() != null ? testCase.getInput() : "";
            
            // Prepend input reading to source code
            String modifiedCode = prependInputCode(submission.getLanguage().name(), testInput, submission.getSourceCode());
            
            CodeExecutionService.ExecutionResult execResult = executionService.executeCode(
                    modifiedCode,
                    submission.getLanguage().getValue(),
                    ""
            );

            String actualOutput = execResult.getOutput();
            String expectedOutput = testCase.getExpectedOutput();
            
            boolean isPassed = compareOutput(actualOutput, expectedOutput);
            
            SubmissionResult result = SubmissionResult.builder()
                    .submission(submission)
                    .testCase(testCase)
                    .testCaseIndex(i + 1)
                    .actualOutput(actualOutput)
                    .expectedOutput(expectedOutput)
                    .isPassed(isPassed)
                    .executionTime(execResult.getExecutionTime())
                    .errorOutput(execResult.getError())
                    .build();
            
            results.add(submissionResultRepository.save(result));

            if (isPassed) {
                passedCount++;
            } else if (execResult.getError() != null && !execResult.getError().isEmpty()) {
                errorMessage.append("Test case ").append(i + 1).append(": ").append(execResult.getError()).append("; ");
            }

            totalExecutionTime += execResult.getExecutionTime() != null ? execResult.getExecutionTime() : 0;
        }

        for (SubmissionResult result : results) {
            submission.addResult(result);
        }

        submission.setPassedCount(passedCount);
        submission.setTotalCount(totalCount);
        submission.setExecutionTime(totalExecutionTime);

        double score = totalCount > 0 ? (double) passedCount / totalCount * 100.0 : 0.0;
        submission.setScore(score);

        if (passedCount == totalCount) {
            submission.setStatus(SubmissionStatus.PASSED);
        } else if (passedCount == 0) {
            submission.setStatus(SubmissionStatus.FAILED);
        } else {
            submission.setStatus(SubmissionStatus.PARTIAL);
        }

        if (errorMessage.length() > 0) {
            submission.setErrorMessage(errorMessage.toString());
        }

        return submissionRepository.save(submission);
    }

    @Transactional(readOnly = true)
    public SubmissionDetailResponseDTO getSubmissionById(Long id) {
        Submission submission = submissionRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Submission not found with id: " + id));
        return mapToDetailResponseDTO(submission);
    }

    @Transactional(readOnly = true)
    public List<SubmissionResponseDTO> getSubmissionsByUserId(Long userId) {
        return submissionRepository.findByUserId(userId).stream()
                .map(this::mapToResponseDTO)
                .collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public List<SubmissionResponseDTO> getSubmissionsByQuestionId(Long questionId) {
        return submissionRepository.findByQuestionId(questionId).stream()
                .map(this::mapToResponseDTO)
                .collect(Collectors.toList());
    }

    private boolean compareOutput(String actual, String expected) {
        if (actual == null && expected == null) {
            return true;
        }
        if (actual == null || expected == null) {
            return false;
        }
        
        String actualTrimmed = actual.trim();
        String expectedTrimmed = expected.trim();
        
        return actualTrimmed.equals(expectedTrimmed);
    }
    
    private String prependInputCode(String language, String input, String userCode) {
        String escapedInput = input.replace("\\", "\\\\").replace("\"", "\\\"").replace("\n", " ").replace("\r", "");
        
        if ("PYTHON".equals(language)) {
            return "input_data = '''" + input.replace("'''", "\\'\\'\\'") + "'''\n" + userCode;
        }
        
        if ("JAVA".equals(language)) {
            // If user didn't provide full class, wrap their code
            if (!userCode.contains("class Main") && !userCode.contains("public class")) {
                String userCodeIndented = userCode.replace("\n", "\n        ");
                return "import java.util.*;\npublic class Main {\n    public static void main(String[] args) {\n        String input_data = \"" + escapedInput + "\";\n        " + userCodeIndented + "\n    }\n}";
            }
            // If user provided full class, inject input_data variable
            return userCode.replace("String input_data = \"\";", "String input_data = \"" + escapedInput + "\";");
        }
        
        if ("CPP".equals(language)) {
            // If user didn't provide main, wrap their code
            if (!userCode.contains("int main()")) {
                String userCodeIndented = userCode.replace("\n", "\n    ");
                return "#include <bits/stdc++.h>\nusing namespace std;\nint main() {\n    string input_data = \"" + escapedInput + "\";\n    " + userCodeIndented + "\n    return 0;\n}";
            }
            // If user provided main, inject input_data variable
            return userCode.replace("string input_data = \"\";", "string input_data = \"" + escapedInput + "\";");
        }
        
        return userCode;
    }

    private SubmissionResponseDTO mapToResponseDTO(Submission submission) {
        return SubmissionResponseDTO.builder()
                .id(submission.getId())
                .userId(submission.getUserId())
                .questionId(submission.getQuestion().getId())
                .language(submission.getLanguage())
                .status(submission.getStatus())
                .passedCount(submission.getPassedCount())
                .totalCount(submission.getTotalCount())
                .score(submission.getScore())
                .executionTime(submission.getExecutionTime())
                .errorMessage(submission.getErrorMessage())
                .createdAt(submission.getCreatedAt())
                .build();
    }

    private SubmissionDetailResponseDTO mapToDetailResponseDTO(Submission submission) {
        List<TestCaseResultResponseDTO> results = submission.getResults().stream()
                .map(r -> TestCaseResultResponseDTO.builder()
                        .id(r.getId())
                        .testCaseIndex(r.getTestCaseIndex())
                        .input(r.getTestCase() != null ? r.getTestCase().getInput() : null)
                        .expectedOutput(r.getExpectedOutput())
                        .actualOutput(r.getActualOutput())
                        .isPassed(r.getIsPassed())
                        .executionTime(r.getExecutionTime())
                        .errorOutput(r.getErrorOutput())
                        .build())
                .collect(Collectors.toList());

        return SubmissionDetailResponseDTO.builder()
                .id(submission.getId())
                .userId(submission.getUserId())
                .questionId(submission.getQuestion().getId())
                .questionTitle(submission.getQuestion().getTitle())
                .language(submission.getLanguage())
                .sourceCode(submission.getSourceCode())
                .status(submission.getStatus())
                .passedCount(submission.getPassedCount())
                .totalCount(submission.getTotalCount())
                .score(submission.getScore())
                .executionTime(submission.getExecutionTime())
                .errorMessage(submission.getErrorMessage())
                .createdAt(submission.getCreatedAt())
                .results(results)
                .build();
    }
}