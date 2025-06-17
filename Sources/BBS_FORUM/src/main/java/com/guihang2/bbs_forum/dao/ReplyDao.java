package com.guihang2.bbs_forum.dao;

import com.guihang2.bbs_forum.pojo.Reply;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface ReplyDao {
    @Insert("INSERT INTO reply (comment_id, user_id, post_id, parent_reply_id, content, created_at, updated_at) " +
            "VALUES (#{commentId}, #{userId}, #{postId}, #{parentReplyId}, #{content}, #{createdAt}, #{updatedAt})")
    boolean addReply(Reply reply);

    //获取回复列表
    @Select("SELECT * FROM reply WHERE commentId = #{commentId}")
    List<Reply> getRepliesByCommentId(Integer commentId);

}
