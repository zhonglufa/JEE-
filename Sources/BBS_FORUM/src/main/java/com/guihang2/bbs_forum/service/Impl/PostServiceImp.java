package com.guihang2.bbs_forum.service.Impl;

import com.guihang2.bbs_forum.dao.PostDao;
import com.guihang2.bbs_forum.pojo.Post;
import com.guihang2.bbs_forum.service.PostService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PostServiceImp implements PostService {

    private final PostDao postDao;

    public PostServiceImp(PostDao postDao) {
        this.postDao = postDao;
    }

    @Override
    public boolean publishPost(Post post) {
        // 设置创建时间和更新时间为当前时间
        post.setCreatedAt(new java.sql.Timestamp(System.currentTimeMillis()));
        post.setUpdatedAt(new java.sql.Timestamp(System.currentTimeMillis()));

        // 调用 DAO 层插入帖子
        return postDao.insertPost(post);
    }

    @Override
    public Post getPostById(Integer postId) {
        return postDao.selectPostById(postId);

    }


    @Override
    public List<Post> getPostList(int page, int pageSize) {
        int offset = (page - 1) * pageSize;
        return postDao.selectPostList(offset, pageSize);
    }

    @Override
    public int getTotalPages(int pageSize) {
        int totalPosts = postDao.countPosts();
        // 计算总页数 math.ceil向上取整数
        return (int) Math.ceil((double) totalPosts / pageSize);
        //    return (totalPosts + pageSize - 1) / pageSize;

    }
}