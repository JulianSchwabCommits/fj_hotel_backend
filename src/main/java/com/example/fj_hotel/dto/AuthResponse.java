package com.example.fj_hotel.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class AuthResponse {
    
    private String message;
    private boolean success;
    private Integer userId;
    private String email;
    private String firstName;
    private String lastName;
    
    public AuthResponse(String message, boolean success) {
        this.message = message;
        this.success = success;
    }
}
