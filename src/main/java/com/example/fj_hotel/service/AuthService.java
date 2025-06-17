package com.example.fj_hotel.service;

import com.example.fj_hotel.dto.AuthResponse;
import com.example.fj_hotel.dto.ResetPasswordRequest;
import com.example.fj_hotel.dto.SigninRequest;
import com.example.fj_hotel.dto.SignupRequest;
import com.example.fj_hotel.entity.User;
import com.example.fj_hotel.repository.UserRepository;
import com.example.fj_hotel.util.PasswordUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
@RequiredArgsConstructor
public class AuthService {
    
    private final UserRepository userRepository;
    
    public AuthResponse signup(SignupRequest request) {
        try {
            // Check if user already exists
            if (userRepository.existsByEmail(request.getEmail())) {
                return new AuthResponse("User with this email already exists", false);
            }
            
            // Create new user
            User user = new User();
            user.setFirstName(request.getFirstName());
            user.setLastName(request.getLastName());
            user.setEmail(request.getEmail());
            user.setPassword(PasswordUtil.hashPassword(request.getPassword()));
            user.setPhoneNumber(request.getPhoneNumber());
            user.setBirthdate(request.getBirthdate());
            user.setAddress(request.getAddress());
            
            User savedUser = userRepository.save(user);
            
            return new AuthResponse(
                "User registered successfully", 
                true, 
                savedUser.getUserId(), 
                savedUser.getEmail(), 
                savedUser.getFirstName(), 
                savedUser.getLastName()
            );
            
        } catch (Exception e) {
            return new AuthResponse("Error during registration: " + e.getMessage(), false);
        }
    }
    
    public AuthResponse signin(SigninRequest request) {
        try {
            Optional<User> userOptional = userRepository.findByEmail(request.getEmail());
            
            if (userOptional.isEmpty()) {
                return new AuthResponse("Invalid email or password", false);
            }
            
            User user = userOptional.get();
            
            if (!PasswordUtil.verifyPassword(request.getPassword(), user.getPassword())) {
                return new AuthResponse("Invalid email or password", false);
            }
            
            return new AuthResponse(
                "Login successful", 
                true, 
                user.getUserId(), 
                user.getEmail(), 
                user.getFirstName(), 
                user.getLastName()
            );
            
        } catch (Exception e) {
            return new AuthResponse("Error during login: " + e.getMessage(), false);
        }
    }
    
    public AuthResponse resetPassword(ResetPasswordRequest request) {
        try {
            Optional<User> userOptional = userRepository.findByEmail(request.getEmail());
            
            if (userOptional.isEmpty()) {
                return new AuthResponse("User not found", false);
            }
            
            User user = userOptional.get();
            
            // Update the password with a new hash
            user.setPassword(PasswordUtil.hashPassword(request.getNewPassword()));
            userRepository.save(user);
            
            return new AuthResponse(
                "Password updated successfully", 
                true, 
                user.getUserId(), 
                user.getEmail(), 
                user.getFirstName(), 
                user.getLastName()
            );
            
        } catch (Exception e) {
            return new AuthResponse("Error updating password: " + e.getMessage(), false);
        }
    }
}
