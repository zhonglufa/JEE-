package com.guihang2.bbs_forum.service;

import com.guihang2.bbs_forum.pojo.User;

public interface UserService {
    Boolean registerUser(User user);
    User loginUser(User user1);

    User getUserById(Integer userId);
}
