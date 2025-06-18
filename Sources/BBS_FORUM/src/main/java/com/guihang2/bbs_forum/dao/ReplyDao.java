package com.guihang2.bbs_forum.dao;

import com.guihang2.bbs_forum.pojo.Post;
import com.guihang2.bbs_forum.pojo.Reply;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface ReplyDao {
    @Insert("INSERT INTO reply (commentId, userId, postId, parentReplyId, content, createdAt, userName) " +
            "VALUES (#{commentId}, #{userId}, #{postId}, #{parentReplyId}, #{content}, #{createdAt}, #{userName})")
    boolean addReply(Reply reply);

    //获取回复列表
    @Select("SELECT * FROM reply WHERE commentId = #{commentId}")
    List<Reply> getRepliesByCommentId(Integer commentId);


    //根据用户Id查询parentReplyId与userId相等的回复列表
    @Select("SELECT * FROM reply WHERE parentReplyId = #{userId}")
    List<Reply> getRepliesByUserId(Integer userId);


     //根据回复表中postId查询文章内容
    @Select("SELECT * FROM post WHERE postId = #{postId}")
    Post getPostByPostId(Integer postId);


    //删除回复
    @Delete("DELETE FROM reply WHERE replyId = #{replyId}")
    Boolean deleteReply(@Param("replyId") Integer replyId);

}
