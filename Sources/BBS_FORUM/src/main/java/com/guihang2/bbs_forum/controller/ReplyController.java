package com.guihang2.bbs_forum.controller;

import com.guihang2.bbs_forum.pojo.Post;
import com.guihang2.bbs_forum.pojo.Reply;
import com.guihang2.bbs_forum.pojo.User;
import com.guihang2.bbs_forum.service.ReplyService;
import com.guihang2.bbs_forum.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/reply")
public class ReplyController {

    @Autowired
    private ReplyService replyService;
    @Autowired
    private UserService userService;

    // 添加回复
    @PostMapping("/add")
    public String addReply(@RequestParam("commentId") Integer commentId,
                           @RequestParam("content") String content,
                           @RequestParam("parentReplyId") Integer parentReplyId,
                           @RequestParam("postId") Integer postId,
                           HttpSession session) {
        // 获取当前登录用户ID
        Integer userId = ((User) session.getAttribute("user")).getUserId();
        // 获取当前用户
        User user = userService.getUserById(userId);

        // 创建回复对象
        Reply reply = new Reply();
        reply.setCommentId(commentId);
        reply.setUserId(userId);
        reply.setContent(content);
        reply.setCreatedAt(new Timestamp(System.currentTimeMillis()));
        reply.setUserName(user.getUsername());// 当前用户的用户名
        reply.setParentReplyId(parentReplyId); //父回复ID，表示这条回复是对哪条回复的再次回复
        reply.setPostId(postId);

        // 调用服务层添加回复
        boolean result = replyService.addReply(reply);
        if (!result) {
            return "redirect:/post/detail/" + postId+ "?error=回复失败，请稍后重试";
        }

        return "redirect:/post/detail/" + postId;
    }
    @RequestMapping ("/home")
    public String addReply(HttpSession session, Model model) {
          //获取用户id
          User user = (User) session.getAttribute("user");
          Integer userId = user.getUserId();
          //获取用户回复
        List<Reply> replies = replyService.getRepliesByUserId(userId);
         //一对一存储在hasMap中
        Map<Integer, Post> postMap = new HashMap<>();
        //遍历replies
        for (Reply reply : replies) {
            Post post= replyService.getPostByPostId(reply.getPostId());
            //添加在PostMap中
            postMap.put(reply.getPostId(), post);
            System.out.println(reply.getContent()+"评论内容");

        }
        model.addAttribute("messages", replies);
        model.addAttribute("postMap", postMap);
        return "myNewsPage";
    }


}