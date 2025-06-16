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
    @Insert("insert into post (title, content, user_id, created_at, updated_at, coverImage) values (#{title}, #{content}, #{userId}, #{createdAt}, #{updatedAt}, #{coverImage,jdbcType=LONGVARCHAR})")
    boolean insertPost(Post post);

    /**
     * 根据文章ID获取文章详情
     * @param postId 文章ID
     * @return 文章对象
     */
    @Select("SELECT * FROM post WHERE postId = #{postId}")
    Post selectPostById(Integer postId);

    /**
     * 获取文章列表并支持分页
     * @param offset 偏移量
     * @param pageSize 每页显示的文章数量
     * @return 文章列表
     */
    @Select("SELECT * FROM post ORDER BY created_at DESC LIMIT #{offset}, #{pageSize}")
    List<Post> selectPostList(@Param("offset") int offset, @Param("pageSize") int pageSize);

    /**
     * 获取文章总数
     * @return 文章总数
     */
    @Select("SELECT COUNT(*) FROM post")
    int countPosts();
}