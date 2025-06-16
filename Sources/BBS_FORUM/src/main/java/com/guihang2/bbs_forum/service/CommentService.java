package com.guihang2.bbs_forum.service;

import com.guihang2.bbs_forum.pojo.Comment;

import java.util.List;

public interface CommentService {
    // 添加评论
    boolean addComment(Comment comment);

    // 删除评论
    boolean deleteComment(Integer commentId);

    // 获取某篇文章的所有评论
    List<Comment> getCommentsByPostId(Integer postId);
}