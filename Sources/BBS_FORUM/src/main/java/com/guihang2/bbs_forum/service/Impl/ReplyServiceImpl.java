package com.guihang2.bbs_forum.service.Impl;

import com.guihang2.bbs_forum.dao.ReplyDao;
import com.guihang2.bbs_forum.pojo.Post;
import com.guihang2.bbs_forum.pojo.Reply;
import com.guihang2.bbs_forum.service.ReplyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ReplyServiceImpl implements ReplyService {

    @Autowired
    private ReplyDao replyDao;

    @Override
    public boolean addReply(Reply reply) {
        // 如果有父回复ID，则设置父回复ID
        if (reply.getParentReplyId() != null) {
            reply.setParentReplyId(reply.getParentReplyId());
        }
        if (reply.getContent() == null || reply.getContent().trim().isEmpty()) {
            throw new IllegalArgumentException("回复内容不能为空");
        }
        return replyDao.addReply(reply);
    }

    @Override
    public List<Reply> getRepliesByCommentId(Integer commentId) {
        return replyDao.getRepliesByCommentId(commentId);
    }

    @Override
    public List<Reply> getRepliesByUserId(Integer userId) {
        return replyDao.getRepliesByUserId(userId);
    }

    @Override
    public Post getPostByPostId(Integer postId) {
        return replyDao.getPostByPostId(postId);
    }
}