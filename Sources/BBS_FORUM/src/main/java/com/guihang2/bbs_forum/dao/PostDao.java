package com.guihang2.bbs_forum.dao;

import com.guihang2.bbs_forum.pojo.Post;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Options;
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
    @Insert("insert into post (title, content, userId, createdAt, updatedAt, coverImage,status) values (#{title}, #{content}, #{userId}, #{createdAt}, #{updatedAt}, #{coverImage},#{status})")
    boolean insertPost(Post post);


    /**
     * 获取搜索文章列表并支持分页
     * @param offset 偏移量
     * @param pageSize 每页显示的文章数量
     * @return 文章列表
     */
    @Select("SELECT * FROM post WHERE status=#{status} AND title LIKE CONCAT('%', #{keyword}, '%') OR content LIKE CONCAT('%', #{keyword}, '%') ORDER BY createdAt DESC LIMIT #{offset}, #{pageSize}")
    List<Post> selectPostListByKeyword(@Param("offset") int offset, @Param("pageSize") int pageSize, @Param("keyword") String keyword, @Param("status")Integer status);

    @Select("SELECT COUNT(*) FROM post WHERE  status=#{status} AND title LIKE CONCAT('%', #{keyword}, '%') OR content LIKE CONCAT('%', #{keyword}, '%')")
    int countPostsByKeyword(@Param("keyword") String keyword,@Param("status")Integer status);


    /**
     * 获取文章列表并支持分页
     * @param offset 偏移量
     * @param pageSize 每页显示的文章数量
     * @return 文章列表
     */
    @Select("SELECT * FROM post WHERE status=#{status}  ORDER BY createdAt DESC LIMIT #{offset}, #{pageSize}")
    List<Post> selectPostList(@Param("offset") int offset, @Param("pageSize") int pageSize,@Param("status")Integer status);

    @Select("SELECT COUNT(*) FROM post WHERE status=#{status}")
    int countAllPosts(Integer status);

    /**
     * 根据postID获取某个文章信息和作者名
     * @return 文章信息和作者名
     */
    @Select("SELECT p.*, u.username AS userName FROM post p JOIN user u ON p.userId = u.userId WHERE p.postId = #{postId} AND p.status=#{status}")
    Post selectPostWithUserNameByPostId(@Param("postId")Integer postId,@Param("status")Integer status);



}