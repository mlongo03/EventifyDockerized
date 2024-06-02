package com.eventify.app.service;

import com.eventify.app.model.User;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.mail.MessagingException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import java.io.IOException;
import java.util.Collections;
import java.util.Optional;

import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class LoginSuccessHandler implements AuthenticationSuccessHandler {

    private final AuthService authService;
    private final EmailService emailService;
    private final UserService userService;

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {
        ObjectMapper mapper = new ObjectMapper();

        Optional<User> user = userService.findByEmail(authentication.getName());
        if (user.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
            response.getWriter().write(mapper.writeValueAsString(Collections.singletonMap("error", "Email not found")));
            return;
        }

        try {
            String secretKey = authService.generateSecretKey();
            int otp = authService.generateOtp(secretKey);
            emailService.sendSignInEmail(authentication.getName(), otp);
            user.get().setOtp(otp);
            userService.update(user.get().getId(), user.get());
            response.setContentType("application/json");
            response.getWriter().write(mapper.writeValueAsString(Collections.singletonMap("email", user.get().getEmail())));
        } catch (MessagingException e) {
            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
            response.getWriter().write(mapper.writeValueAsString(Collections.singletonMap("error", "Internal error please wait to continue")));
        }
    }

}
