package com.guihang2.bbs_forum.service;

import com.guihang2.bbs_forum.pojo.Post;
import com.guihang2.bbs_forum.pojo.User;

import java.util.List;

public interface UserService {
    Boolean registerUser(User user);
    User loginUser(User user1);

    User getUserById(Integer userId);

    User getUserByParentReplyId(Integer parentReplyId);
    List<Post> getUserPostById(Integer userId);
}
