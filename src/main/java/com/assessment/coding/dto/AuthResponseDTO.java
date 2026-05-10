package com.assessment.coding.dto;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class AuthResponseDTO {
    private String token;
    private String username;
    private String email;
    private String fullName;
    private String role;
    private Long userId;
}