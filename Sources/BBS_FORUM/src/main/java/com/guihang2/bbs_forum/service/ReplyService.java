package com.guihang2.bbs_forum.service;

import com.guihang2.bbs_forum.pojo.Post;
import com.guihang2.bbs_forum.pojo.Reply;

import java.util.List;

public interface ReplyService {
    boolean addReply(Reply reply);
    List<Reply> getRepliesByCommentId(Integer commentId);

    List<Reply> getRepliesByUserId(Integer userId);

    Post getPostByPostId(Integer postId);

    Boolean deleteReply(Integer replyId);
}