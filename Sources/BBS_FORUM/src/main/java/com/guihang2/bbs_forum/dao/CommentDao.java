package com.guihang2.bbs_forum.dao;

import com.guihang2.bbs_forum.pojo.Comment;
import org.apache.ibatis.annotations.*;

import java.util.List;

public interface CommentDao {
    // 添加评论
    @Insert("INSERT INTO comment (post_id, user_id, content, created_at,updated_at,is_deleted,userName) " +
            "VALUES (#{postId}, #{userId}, #{content}, #{createdAt}, #{updatedAt}, #{isDeleted}, #{userName})")
    boolean addComment(Comment comment);

    // 删除评论
    @Delete("DELETE FROM comment WHERE comment_id = #{commentId}")
    boolean deleteComment(Integer commentId);

    // 更新评论
    @Update("UPDATE comment SET content = #{content}, updated_at = #{updatedAt} WHERE comment_id = #{commentId}")
    boolean updateComment(Comment comment);

    // 获取某篇文章的所有评论
    @Select("SELECT c.*, u.username as userName " +
            "FROM comment c JOIN user u ON c.userId = u.userId " +
            "WHERE c.postId = #{postId}")
    List<Comment> getCommentsByPostId(Integer postId);

    // 分页查询某篇文章的评论
    @Select("SELECT c.*, u.username as userName " +
            "FROM comment c JOIN user u ON c.user_id = u.user_id " +
            "WHERE c.post_id = #{postId} " +
            "ORDER BY c.created_at DESC " +
            "LIMIT #{pageSize} OFFSET #{offset}")
    List<Comment> getCommentsByPostIdWithPagination(@Param("postId") Integer postId,
                                                    @Param("pageSize") int pageSize, 
                                                    @Param("offset") int offset);

    // 获取某个用户的所有评论
    @Select("SELECT c.*, u.username as userName " +
            "FROM comment c JOIN user u ON c.user_id = u.user_id " +
            "WHERE c.user_id = #{userId}")
    List<Comment> getCommentsByUserId(Integer userId);
}