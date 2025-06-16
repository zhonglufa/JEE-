package com.guihang2.bbs_forum.controller;

import com.guihang2.bbs_forum.service.PostService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @Author: zhonglufa
 * @CreateTime: 2025-06-13
 * @Description:
 * @Version: 2.0
 */


@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private PostService postService;

//    @GetMapping("/dashboard")
//    public String adminDashboard(Model model) {
//        if(!isAdmin()) return "redirect:/";
//        model.addAttribute("posts", postService.getAllPosts());
//        return "adminDashboard";
//    }
//
//    @PostMapping("/post/delete/{postId}")
//    public String deletePost(@PathVariable Integer postId) {
//        if(!isAdmin()) return "redirect:/";
//        postService.deletePost(postId);
//        return "redirect:/admin/dashboard";
//    }
//   //  检查当前用户是否是管理员
//    private boolean isAdmin() {
//        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
//        return auth.getAuthorities().stream()
//                .anyMatch(g -> g.getAuthority().equals("ADMIN"));
//    }
}