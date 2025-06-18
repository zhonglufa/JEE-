package com.guihang2.bbs_forum.service;

import com.guihang2.bbs_forum.pojo.Post;

import java.util.List;

public interface PostService {
    /**
     * 发布新帖子
     *
     * @param post 帖子对象
     * @return 发布成功返回 true，否则返回 false
     */
    boolean publishPost(Post post);

    /**
     * 根据文章ID获取已经发布的文章详情
     * @param postId 文章ID
     * @return 文章对象和作者
     */
    Post getPostById(Integer postId,Integer status);

    /**
     * 获取搜索已经发布文章列表并支持分页
     * @param page 当前页码
     * @param pageSize 每页显示的文章数量
     * @return 文章列表
     */
    List<Post> getPostList(int page, int pageSize, String keyword,Integer status);
    /**
     * 获取已经发布文章列表并支持分页
     * @param page 当前页码
     * @param pageSize 每页显示的文章数量
     * @return 文章列表
     */
    List<Post> getPostList(int page, int pageSize,Integer status);
    /**
     * 已经发布获取总页数
     * @param pageSize 每页显示的文章数量
     * @return 总页数
     */
    int getTotalPages(int pageSize, String keyword,Integer status);

    /**
     * 已经发布获取总页数
     * @param pageSize 每页显示的文章数量
     * @return 总页数
     */
    int getTotalPages(int pageSize,Integer status);
}