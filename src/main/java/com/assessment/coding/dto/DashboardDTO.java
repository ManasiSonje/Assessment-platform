package com.assessment.coding.dto;

import lombok.Builder;
import lombok.Data;

import java.util.List;

@Data
@Builder
public class DashboardDTO {
    private Long totalTests;
    private Long totalSessions;
    private Long totalSubmissions;
    private Long totalQuestions;
    private List<ScoreData> scoreData;
    private List<StudentData> students;
    
    @Data
    @Builder
    public static class ScoreData {
        private String studentName;
        private Integer score;
    }
    
    @Data
    @Builder
    public static class StudentData {
        private Long id;
        private String username;
        private String email;
        private String fullName;
        private Integer attempts;
        private Integer avgScore;
        private String lastTest;
        private String status;
    }
}