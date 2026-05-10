package com.assessment.coding.controller;

import com.assessment.coding.dto.*;
import com.assessment.coding.entity.*;
import com.assessment.coding.repository.*;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/v1/admin")
@RequiredArgsConstructor
public class AdminController {

    private final TestRepository testRepository;
    private final TestSessionRepository testSessionRepository;
    private final SubmissionRepository submissionRepository;
    private final QuestionRepository questionRepository;
    private final UserRepository userRepository;

    @GetMapping("/tests")
    public ResponseEntity<ApiResponse<List<TestResponseDTO>>> getAllTests() {
        List<TestResponseDTO> tests = testRepository.findAll().stream()
                .map(t -> TestResponseDTO.builder()
                        .id(t.getId())
                        .title(t.getTitle())
                        .description(t.getDescription())
                        .accessCode(t.getAccessCode())
                        .duration(t.getDuration())
                        .questionCount(t.getQuestions() != null ? t.getQuestions().size() : 0)
                        .isActive(t.getIsActive())
                        .build())
                .collect(Collectors.toList());
        return ResponseEntity.ok(ApiResponse.success(tests));
    }

    @GetMapping("/test/{id}/results")
    public ResponseEntity<ApiResponse<List<TestSessionDTO>>> getTestResults(@PathVariable Long id) {
        List<TestSession> sessions = testSessionRepository.findByTestId(id);
        List<TestSessionDTO> results = sessions.stream()
                .map(s -> TestSessionDTO.builder()
                        .id(s.getId())
                        .studentId(s.getStudentId())
                        .studentName(s.getStudentName())
                        .status(s.getStatus().name())
                        .startTime(s.getStartTime())
                        .endTime(s.getEndTime())
                        .score(s.getScore())
                        .build())
                .collect(Collectors.toList());
        return ResponseEntity.ok(ApiResponse.success(results));
    }

    @GetMapping("/submissions")
    public ResponseEntity<ApiResponse<List<SubmissionDetailAdminDTO>>> getAllSubmissions() {
        List<Submission> submissions = submissionRepository.findAll();
        List<SubmissionDetailAdminDTO> details = submissions.stream()
                .map(s -> {
                    String testTitle = s.getTestSession() != null && s.getTestSession().getTest() != null
                            ? s.getTestSession().getTest().getTitle() : "N/A";
                    String studentName = s.getTestSession() != null && s.getTestSession().getStudentName() != null
                            ? s.getTestSession().getStudentName() : "Unknown";
                    return SubmissionDetailAdminDTO.builder()
                            .submissionId(s.getId())
                            .sessionId(s.getTestSession() != null ? s.getTestSession().getId() : null)
                            .testId(s.getTestSession() != null && s.getTestSession().getTest() != null
                                    ? s.getTestSession().getTest().getId() : null)
                            .testTitle(testTitle)
                            .questionId(s.getQuestion() != null ? s.getQuestion().getId() : null)
                            .questionTitle(s.getQuestion() != null ? s.getQuestion().getTitle() : "N/A")
                            .studentId(s.getUserId())
                            .studentName(studentName)
                            .language(s.getLanguage() != null ? s.getLanguage().name() : "N/A")
                            .status(s.getStatus() != null ? s.getStatus().name() : "N/A")
                            .passedCount(s.getPassedCount())
                            .totalCount(s.getTotalCount())
                            .score(s.getScore())
                            .build();
                })
                .collect(Collectors.toList());
        return ResponseEntity.ok(ApiResponse.success(details));
    }

    @GetMapping("/dashboard")
    public ResponseEntity<ApiResponse<DashboardDTO>> getDashboard() {
        long totalTests = testRepository.count();
        long totalSessions = testSessionRepository.count();
        long totalSubmissions = submissionRepository.count();
        long totalQuestions = questionRepository.count();
        
        // Get score data from test sessions
        List<TestSession> sessions = testSessionRepository.findAll();
        List<DashboardDTO.ScoreData> scoreData = new ArrayList<>();
        
        // Track student activity for StudentData
        Map<Long, DashboardDTO.StudentData> studentMap = new HashMap<>();
        
        for (TestSession session : sessions) {
            // Build ScoreData
            if (session.getStudentName() != null) {
                List<Submission> sessionSubs = submissionRepository.findByTestSessionId(session.getId());
                if (!sessionSubs.isEmpty()) {
                    double avgScore = sessionSubs.stream()
                            .mapToInt(s -> s.getScore() != null ? s.getScore().intValue() : 0)
                            .average()
                            .orElse(0.0);
                    
                    scoreData.add(DashboardDTO.ScoreData.builder()
                            .studentName(session.getStudentName())
                            .score((int) avgScore)
                            .build());
                }
            }
            
            // Build StudentData
            if (session.getStudentId() != null) {
                Long userId = session.getStudentId();
                
                DashboardDTO.StudentData studentData = studentMap.computeIfAbsent(userId, id -> {
                    User user = userRepository.findById(id).orElse(null);
                    return DashboardDTO.StudentData.builder()
                            .id(id)
                            .username(user != null ? user.getUsername() : "Unknown")
                            .email(user != null ? user.getEmail() : "N/A")
                            .fullName(user != null ? user.getFullName() : session.getStudentName())
                            .attempts(0)
                            .avgScore(0)
                            .lastTest("")
                            .status(session.getStatus().name())
                            .build();
                });
                
                studentData.setAttempts(studentData.getAttempts() + 1);
                
                // Calculate average score for this student
                List<Submission> studentSubs = submissionRepository.findByUserId(userId);
                if (!studentSubs.isEmpty()) {
                    double avg = studentSubs.stream()
                            .mapToInt(s -> s.getScore() != null ? s.getScore().intValue() : 0)
                            .average()
                            .orElse(0.0);
                    studentData.setAvgScore((int) avg);
                }
                
                String testTitle = session.getTest() != null ? session.getTest().getTitle() : "Unknown";
                studentData.setLastTest(testTitle);
                studentData.setStatus(session.getStatus().name());
            }
        }
        
        DashboardDTO dashboard = DashboardDTO.builder()
                .totalTests(totalTests)
                .totalSessions(totalSessions)
                .totalSubmissions(totalSubmissions)
                .totalQuestions(totalQuestions)
                .scoreData(scoreData)
                .students(new ArrayList<>(studentMap.values()))
                .build();

        return ResponseEntity.ok(ApiResponse.success(dashboard));
    }
}