package com.example.sims.controller;

import com.example.sims.pojo.User;
import com.example.sims.service.UserService;
import com.example.sims.service.StudentsService;
import com.example.sims.service.CoursesService;
import com.example.sims.service.GradesService;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Map;

/**
 * 用户认证控制器
 * 处理用户登录、注册、登出和会话管理
 * 
 * @author SIMS Team
 * @version 2.0
 */
@Controller
public class AuthController {

    private final UserService userService;
    private final StudentsService studentsService;
    private final CoursesService coursesService;
    private final GradesService gradesService;

    /**
     * 构造函数注入依赖
     *
     * @param userService 用户服务接口实例
     * @param studentsService 学生服务接口实例
     * @param coursesService 课程服务接口实例
     * @param gradesService 成绩服务接口实例
     */
    public AuthController(UserService userService, StudentsService studentsService, 
                         CoursesService coursesService, GradesService gradesService) {
        this.userService = userService;
        this.studentsService = studentsService;
        this.coursesService = coursesService;
        this.gradesService = gradesService;
    }

    /**
     * 处理用户登录请求
     * 验证用户名和密码，成功后创建用户会话
     *
     * @param username 用户名
     * @param password 密码
     * @param session  HTTP会话对象，用于存储当前用户信息
     * @param model    模型对象，用于传递错误信息到视图层
     * @return 登录成功则重定向到仪表盘页面，失败则返回登录页面并显示错误信息
     */
    @PostMapping("/login")
    public String login(
            @RequestParam String username,
            @RequestParam String password,
            HttpSession session,
            Model model) {

        // 参数验证
        if (username == null || username.trim().isEmpty()) {
            model.addAttribute("error", "用户名不能为空");
            return "login";
        }
        
        if (password == null || password.trim().isEmpty()) {
            model.addAttribute("error", "密码不能为空");
            return "login";
        }

        try {
            // 调用userService.authenticate方法验证用户名和密码
            User user = userService.authenticate(username.trim(), password);
            if (user == null) {
                // 如果认证失败，将错误信息添加到模型中并返回登录页面
                model.addAttribute("error", "用户名或密码错误");
                return "login";
            }

            // 认证成功，将用户信息存入会话
            session.setAttribute("currentUser", user);
            session.setAttribute("userId", user.getId());
            session.setAttribute("username", user.getUsername());
            session.setAttribute("realName", user.getRealName());

            // 设置会话超时时间（30分钟）
            session.setMaxInactiveInterval(1800);
            
            return "redirect:/home"; // 重定向到仪表盘页面
            
        } catch (Exception e) {
            model.addAttribute("error", "登录过程中发生错误：" + e.getMessage());
            return "login";
        }
    }

    /**
     * 处理用户注册请求
     * 验证注册信息，创建新用户账户
     *
     * @param username      用户名
     * @param email         邮箱地址
     * @param password      密码
     * @param confirmPassword 确认密码
     * @param realName      真实姓名
     * @param model         模型对象，用于传递错误或成功信息到视图层
     * @return 注册成功则返回登录页面并显示成功信息，失败则返回登录页面并显示错误信息
     */
    @PostMapping("/register")
    public String register(
            @RequestParam String username,
            @RequestParam String email,
            @RequestParam String password,
            @RequestParam String confirmPassword,
            @RequestParam String realName,
            Model model) {

        // 参数验证
        if (username == null || username.trim().isEmpty()) {
            model.addAttribute("registerError", "用户名不能为空");
            return "login";
        }
        
        if (email == null || email.trim().isEmpty()) {
            model.addAttribute("registerError", "邮箱不能为空");
            return "login";
        }
        
        if (password == null || password.trim().isEmpty()) {
            model.addAttribute("registerError", "密码不能为空");
            return "login";
        }
        
        if (realName == null || realName.trim().isEmpty()) {
            model.addAttribute("registerError", "真实姓名不能为空");
            return "login";
        }

        // 检查两次输入的密码是否一致
        if (!password.equals(confirmPassword)) {
            model.addAttribute("registerError", "两次输入的密码不一致");
            return "login";
        }

        // 检查密码长度
        if (password.length() < 6) {
            model.addAttribute("registerError", "密码长度不能少于6位");
            return "login";
        }

        // 检查邮箱格式
        if (!email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
            model.addAttribute("registerError", "邮箱格式不正确");
            return "login";
        }

        try {
            // 检查用户名是否已存在
            if (userService.usernameExists(username.trim())) {
                model.addAttribute("registerError", "用户名已存在");
                return "login";
            }

            // 检查邮箱是否已存在
            if (userService.emailExists(email.trim())) {
                model.addAttribute("registerError", "邮箱已被注册");
                return "login";
            }

            // 调用userService.registerUser方法完成用户注册
            userService.registerUser(username.trim(), email.trim(), password, realName.trim());
            model.addAttribute("registerSuccess", "注册成功，请登录");
            return "login";
            
        } catch (Exception e) {
            model.addAttribute("registerError", "注册过程中发生错误：" + e.getMessage());
            return "login";
        }
    }

    /**
     * 处理用户登出请求
     * 销毁当前用户会话，清除所有会话数据
     *
     * @param session HTTP会话对象，用于销毁当前会话
     * @return 重定向到登录页面
     */
    @RequestMapping("/logout")
    public String logout(HttpSession session) {
        try {
            // 清除会话中的所有属性
            session.removeAttribute("currentUser");
            session.removeAttribute("userId");
            session.removeAttribute("username");
            session.removeAttribute("realName");
            
            // 销毁会话
            session.invalidate();
            
        } catch (Exception e) {
            // 忽略会话销毁过程中的异常
        }
        
        return "redirect:/";
    }

    /**
     * 跳转主页
     * 获取系统统计数据并显示在首页
     * 验证用户登录状态，未登录则重定向到登录页面
     *
     * @param session HTTP会话对象
     * @param model 模型对象
     * @return 首页视图或登录页面
     */
    @GetMapping("/home")
    public String home(HttpSession session, Model model) {
        // 验证用户登录状态
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            return "redirect:/login";
        }
        
        // 添加当前用户信息到模型
        model.addAttribute("currentUser", currentUser);
        
        // 获取系统统计数据
        try {
            // 获取学生统计信息
            Map<String, Object> studentStats = studentsService.getStudentStatistics();
            model.addAttribute("studentStats", studentStats);

            
            // 获取课程统计信息
            Map<String, Object> courseStats = coursesService.getCourseStatistics();
            model.addAttribute("courseStats", courseStats);
            
            // 获取成绩统计信息
            Map<String, Object> gradeStats = gradesService.getGradeStatistics();
            model.addAttribute("gradeStats", gradeStats);
            
            // 获取最新数据列表（用于首页展示）
            model.addAttribute("recentStudents", studentsService.getStudentsByPage(1, 5));
            model.addAttribute("recentCourses", coursesService.getCoursesByPage(1, 5));
            model.addAttribute("recentGrades", gradesService.getGradesWithDetailsByPage(1, 5));
            
        } catch (Exception e) {
            // 如果获取数据失败，使用默认值
            model.addAttribute("studentStats", Map.of("totalStudents", 0, "maleStudents", 0, "femaleStudents", 0));
            model.addAttribute("courseStats", Map.of("totalCourses", 0, "totalTeachers", 0));
            model.addAttribute("gradeStats", Map.of("totalRecords", 0, "averageScore", 0.0));
            model.addAttribute("recentStudents", java.util.Collections.emptyList());
            model.addAttribute("recentCourses", java.util.Collections.emptyList());
            model.addAttribute("recentGrades", java.util.Collections.emptyList());
        }
        
        return "adminHome";
    }

    /**
     * 显示登录页面
     * 如果用户已登录，则重定向到首页
     *
     * @param session HTTP会话对象
     * @return 登录页面或重定向到首页
     */
    @GetMapping("/")
    public String showLoginPage(HttpSession session) {
        // 检查用户是否已登录
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser != null) {
            return "redirect:/home";
        }
        
        return "login";
    }


}