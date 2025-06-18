package com.guihang2.bbs_forum.controller;

import com.guihang2.bbs_forum.pojo.Post;
import com.guihang2.bbs_forum.pojo.User;
import com.guihang2.bbs_forum.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/user")
public class UserController {
    @Autowired
    private UserService userService;

    @GetMapping("/register")
    public String showRegisterForm() {
        return "register"; // 返回 register.jsp
    }

    @PostMapping("/register")
    public String registerUser(@ModelAttribute("user") User user, RedirectAttributes redirectAttributes) {
        if (!userService.registerUser(user)) {
            redirectAttributes.addFlashAttribute("msg", "注册失败");
            return "redirect:/user/register"; // 注册失败返回注册页面
        }
        redirectAttributes.addFlashAttribute("msg", "注册成功");
         return "redirect:/"; // 注册成功后跳转到登录页面

    }

    @GetMapping("/login")
    public String showLoginForm() {
        return "redirect:/"; // 返回 login.jsp
    }

    @PostMapping("/login")
    public String loginUser(User user1,
                            HttpSession session,
                            RedirectAttributes redirectAttributes) {
        User user = userService.loginUser(user1);
        if (user != null) {
            session.setAttribute("user", user);

            redirectAttributes.addAttribute("msg", "登录成功");
            return "redirect:/post/home"; // 登录成功后跳转到首页
        } else {
            redirectAttributes.addAttribute("msg", "用户名或密码错误");
            return "redirect:/";// 登录失败返回登录页面并显示错误信息
        }
    }
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();// 注销用户
        return "redirect:/post/home"; // 注销后跳转到首页
    }


    @RequestMapping("/post/{userId}")
    public  String getUserPostById(@PathVariable Integer userId, Model model) {
        List<Post> post  = userService.getUserPostById(userId);
        model.addAttribute("post",post);


        return "postPage";

    }
}