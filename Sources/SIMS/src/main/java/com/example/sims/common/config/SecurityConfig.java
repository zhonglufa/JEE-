package com.example.sims.common.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

/**
 * 配置Spring Security的安全设置
 */
@Configuration
@EnableWebSecurity
public class SecurityConfig {

    /**
     * 配置SecurityFilterChain bean，定义了网页的安全规则
     *
     * @param http 用于构建HTTP安全设置的对象
     * @return 构建的SecurityFilterChain对象
     * @throws Exception 如果构建过程中出现错误
     */
    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
                // 定义哪些请求需要认证，哪些不需要
                .authorizeHttpRequests(auth -> auth
                        .requestMatchers("/login", "/register", "/resources/**").permitAll() // 允许访问登录页面和注册页面
                        .anyRequest().authenticated()
                )
                // 配置登录和登出的规则
                .formLogin(form -> form
                        .loginPage("/login")
                        .defaultSuccessUrl("/home")
                        .failureUrl("/login?error=true")
                        .permitAll()
                )
                .logout(logout -> logout
                        .logoutUrl("/logout")
                        .logoutSuccessUrl("/login")
                        .invalidateHttpSession(true)
                        .deleteCookies("JSESSIONID")
                )
                // 管理会话，限制最大会话数
                .sessionManagement(session -> session
                        .maximumSessions(1)
                        .maxSessionsPreventsLogin(true)
                );
        return http.build();
    }

    /**
     * 创建PasswordEncoder bean，用于密码的编码和解码
     *
     * @return PasswordEncoder对象，这里使用BCrypt进行密码编码
     */
    @Bean
    public PasswordEncoder passwordEncoder() {
        System.out.println(" PasswordEncoder bean created!");
        return new BCryptPasswordEncoder();
    }
}
