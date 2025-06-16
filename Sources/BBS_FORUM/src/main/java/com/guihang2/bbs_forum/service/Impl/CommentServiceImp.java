package com.guihang2.bbs_forum.service.Impl;

import com.guihang2.bbs_forum.dao.CommentDao;
import com.guihang2.bbs_forum.pojo.Comment;
import com.guihang2.bbs_forum.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CommentServiceImp implements CommentService {

    @Autowired
    private CommentDao commentDao;

    @Override
    public boolean addComment(Comment comment) {
        return commentDao.addComment(comment);
    }

    @Override
    public boolean deleteComment(Integer commentId) {
        return commentDao.deleteComment(commentId);
    }

    @Override
    public List<Comment> getCommentsByPostId(Integer postId) {
        return commentDao.getCommentsByPostId(postId);
    }
}