package com.guihang2.bbs_forum.controller;

import com.guihang2.bbs_forum.pojo.Comment;
import com.guihang2.bbs_forum.pojo.Post;
import com.guihang2.bbs_forum.pojo.Reply;
import com.guihang2.bbs_forum.pojo.User;
import com.guihang2.bbs_forum.service.CommentService;
import com.guihang2.bbs_forum.service.PostService;
import com.guihang2.bbs_forum.service.ReplyService;
import com.guihang2.bbs_forum.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.IOException;
import java.util.*;

@Controller
@RequestMapping("/post")
public class PostController {

    @Autowired
    private PostService postService;

    @Autowired
    private CommentService commentService;

    @Autowired
    private ReplyService replyService;
    @Autowired
    private UserService userService;

    @PostMapping("/addPost")
    public String addPost(@RequestParam("title") String title,
                          @RequestParam("content") String content,
                          @RequestParam("cover") MultipartFile cover,
                          HttpSession session,
                          RedirectAttributes redirectAttributes) {
        // 获取当前登录用户ID
        User user = (User) session.getAttribute("user");
        Integer userId = user.getUserId();

        // 创建帖子对象
        Post post = new Post();
        post.setTitle(title);
        post.setContent(content);
        post.setUserId(userId);

        // 处理封面图片
        if (!cover.isEmpty()) {
            try {
                byte[] bytes = cover.getBytes();
                //转换为 Base64
               post.setCoverImage(Base64.getEncoder().encodeToString(bytes));
            } catch (IOException e) {
                e.printStackTrace();
                redirectAttributes.addFlashAttribute("error", "图片上传失败，请稍后重试");
                System.out.println("图片上传失败，请稍后重试");
                return "redirect:/post/toAddPost";
            }
        }

        // 调用服务层发布帖子
        boolean result = postService.publishPost(post);
        if (result) {
            redirectAttributes.addFlashAttribute("success", "帖子发布成功");
        } else {
            redirectAttributes.addFlashAttribute("error", "帖子发布失败，请稍后重试");
        }
        return "redirect:home";
    }

    //跳转到发布帖子页面
    @RequestMapping("/toAddPost")
    public String toAddPost() {
        return "addPost";
    }


    /**
     * 获取文章列表并支持分页
     * @param model 模型对象
     * @param page 当前页码
     * @param pageSize 每页显示的文章数量
     * @return 文章列表页面
     */
    @RequestMapping("/home")
    public String getPostList(Model model,
                              @RequestParam(defaultValue = "1") int page,
                              @RequestParam(defaultValue = "6") int pageSize) {

        List<Post> postList = postService.getPostList(page, pageSize);
        if (postList == null || postList.isEmpty()) {
            System.out.println("No posts found in the database.");
        }

        // 确保数据正确传递到前端
        model.addAttribute("postList", postList); // 文章列表
        model.addAttribute("currentPage", page); // 当前页码
        model.addAttribute("pageSize", pageSize); // 每页显示的文章数量
        model.addAttribute("totalPages", postService.getTotalPages(pageSize)); // 总页数

        // 返回视图名称，确保视图解析器能够正确解析
        return "home";
    }


    /**
     * 获取文章详情
     * @param postId 文章ID
     * @param model 模型对象
     * @return 文章详情页面
     */
    @GetMapping("/detail/{postId}")
    public String getPostDetail(@PathVariable Integer postId, Model model) {
        // 获取文章详情
        Post post = postService.getPostById(postId);
        // 将封面图片转换为Base64编码，以便在前端显示
        if (post.getCoverImage() != null) {
            model.addAttribute("post", post);
        }

        // 获取评论列表
        List<Comment> comments = commentService.getCommentsByPostId(postId);
        model.addAttribute("comments", comments);
        //获取单个评论的回复列表
        Map<Integer, List<Reply>> replyMap = new HashMap<>();
        for (Comment comment : comments) {
            Integer commentId = comment.getCommentId();
            List<Reply> replies = replyService.getRepliesByCommentId(commentId);
            // 将回复列表添加到Map中     Collections.emptyList()创建一个空的列表，用于处理空指针异常
            replyMap.put(commentId, replies == null ? Collections.emptyList() : replies);
        }
        model.addAttribute("replyMap", replyMap);
        Map<Integer,User> userMap = new HashMap<>();
      // 打印
        for (Map.Entry<Integer, List<Reply>> entry : replyMap.entrySet()) {
            for (Reply reply : entry.getValue()) {
                //获取父级回复
                Integer parentReplyId = reply.getParentReplyId();
                //获取用户
                User user=userService.getUserByParentReplyId(parentReplyId);
                //添加到map中
                userMap.put(parentReplyId,user == null ? User.EMPTY : user);
                //打印
                System.out.println(userMap.get(parentReplyId).getUsername()+"用户名");
            }
        }
        model.addAttribute("userMap", userMap);
         return "postDetail";
    }





}
