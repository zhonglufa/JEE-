package com.guihang2.bbs_forum.dao;

import com.guihang2.bbs_forum.pojo.Post;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface PostDao {
    /**
     * 插入新帖子
     *
     * @param post 帖子对象
     * @return 插入成功返回 true，否则返回 false
     */
    @Insert("insert into post (title, content, userId, createdIt, updatedIt, coverImage) values (#{title}, #{content}, #{userId}, #{createdAt}, #{updatedAt}, #{coverImage,jdbcType=LONGVARCHAR})")
    boolean insertPost(Post post);


    /**
     * 获取文章列表并支持分页
     * @param offset 偏移量
     * @param pageSize 每页显示的文章数量
     * @return 文章列表
     */
    @Select("SELECT * FROM post ORDER BY createdAt DESC LIMIT #{offset}, #{pageSize}")
    List<Post> selectPostList(@Param("offset") int offset, @Param("pageSize") int pageSize);

    /**
     * 获取文章总数
     * @return 文章总数
     */
    @Select("SELECT COUNT(*) FROM post")
    int countPosts();

    /**
     * 根据postID获取某个文章信息和作者名
     * @return 文章信息和作者名
     */
    @Select("SELECT p.*, u.username AS userName FROM post p JOIN user u ON p.userId = u.userId WHERE p.postId = #{postId}")
    Post selectPostWithUserNameByPostId(Integer postId);
}