package com.guihang2.bbs_forum.dao;

import com.guihang2.bbs_forum.pojo.Comment;
import org.apache.ibatis.annotations.*;

import java.util.List;

public interface CommentDao {
    // 添加评论
    @Insert("INSERT INTO comment (postId, userId, content, createdAt,updatedAt,isDeleted,userName) " +
            "VALUES (#{postId}, #{userId}, #{content}, #{createdAt}, #{updatedAt}, #{isDeleted}, #{userName})")
    boolean addComment(Comment comment);

    // 删除评论
    @Delete("DELETE FROM comment WHERE commentId = #{commentId}")
    boolean deleteComment(Integer commentId);

    // 更新评论
    @Update("UPDATE comment SET content = #{content}, updatedAt = #{updatedAt} WHERE commentId = #{commentId}")
    boolean updateComment(Comment comment);

    // 获取某篇文章的所有评论   一对多
    @Select("SELECT c.*, u.username as userName " +
            "FROM comment c JOIN user u ON c.userId = u.userId " +
            "WHERE c.postId = #{postId}")
    List<Comment> getCommentsByPostId(Integer postId);

    // 分页查询某篇文章的评论
    @Select("SELECT c.*, u.username as userName " +
            "FROM comment c JOIN user u ON c.userId = u.userId " +
            "WHERE c.postId = #{postId} " +
            "ORDER BY c.createdAt DESC " +
            "LIMIT #{pageSize} OFFSET #{offset}")
    List<Comment> getCommentsByPostIdWithPagination(@Param("postId") Integer postId,
                                                    @Param("pageSize") int pageSize, 
                                                    @Param("offset") int offset);

    // 获取某个用户的所有评论
    @Select("SELECT c.*, u.username as userName " +
            "FROM comment c JOIN user u ON c.userId = u.userId " +
            "WHERE c.userId = #{userId}")
    List<Comment> getCommentsByUserId(Integer userId);


}