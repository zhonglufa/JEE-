package com.guihang2.bbs_forum.controller;

import com.guihang2.bbs_forum.pojo.Comment;
import com.guihang2.bbs_forum.pojo.User;
import com.guihang2.bbs_forum.service.CommentService;
import com.guihang2.bbs_forum.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.sql.Timestamp;
import java.util.List;

@Controller
@RequestMapping("/comment")
public class CommentController {

    @Autowired
    private CommentService commentService;
    @Autowired
    private UserService userService;

    // 添加评论
    @PostMapping("/add")
    public String addComment(@RequestParam("postId") Integer postId,
                             @RequestParam("content") String content,
                             HttpSession session) {
        // 获取当前登录用户ID
        Integer userId = ((User) session.getAttribute("user")).getUserId();
        //获取当前用户

        User user = userService.getUserById(userId);

        // 创建评论对象
        Comment comment = new Comment();
        comment.setPostId(postId);
        comment.setUserId(userId);
        comment.setContent(content);
        comment.setCreatedAt(new Timestamp(System.currentTimeMillis()));
        comment.setUpdatedAt(new Timestamp(System.currentTimeMillis()));
        comment.setIsDeleted(false);
        comment.setUserName(user.getUsername());

        // 调用服务层添加评论
        boolean result = commentService.addComment(comment);
        if (!result) {
            return "redirect:/post/detail/" + postId + "?error=评论失败，请稍后重试";
        }

        return "redirect:/post/detail/" + postId;
    }

    // 删除评论
    @DeleteMapping("/delete/{commentId}")
    public ResponseEntity<String> deleteComment(@PathVariable Integer commentId) {
        // 调用服务层删除评论
        boolean result = commentService.deleteComment(commentId);

        if (!result) {
            return ResponseEntity.badRequest().body("删除评论失败，请稍后重试");
        }

        return ResponseEntity.ok("删除成功");
/*        返回响应数据前后端分离写法
ResponseEntity<Map<String, Object>>
        Map<String, Object> response = new HashMap<>();
        if (success) {
            response.put("success", true);
        } else {
            response.put("success", false);
            response.put("message", "删除失败");
        }
        return ResponseEntity.ok(response);*/
    }

    // 获取评论列表（供API使用）
    @GetMapping("/list/{postId}")
    @ResponseBody
    public List<Comment> getCommentsByPostId(@PathVariable Integer postId) {
        return commentService.getCommentsByPostId(postId);
    }


}