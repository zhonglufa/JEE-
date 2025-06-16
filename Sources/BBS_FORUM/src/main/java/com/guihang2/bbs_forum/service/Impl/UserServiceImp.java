package com.guihang2.bbs_forum.service.Impl;

import com.guihang2.bbs_forum.dao.UserDao;
import com.guihang2.bbs_forum.pojo.User;
import com.guihang2.bbs_forum.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImp implements UserService {
    @Autowired
    private UserDao userDao;

    @Override
    public Boolean registerUser(User user) {
        System.out.println(user.getEmail());
        // 检查用户邮箱是否已存在
        User existingUser = userDao.selectUserByEmail(user.getEmail());
        if (existingUser != null) {
            // 如果用户已存在，返回false
            return false;
        }
        // 插入新用户
        userDao.insertUser(user);
        return true;
    }

    @Override
    public User loginUser(User user1) {

        User user = userDao.selectUserByUsernameAndPassword(user1);
        return user;
    }


    @Override
    public User getUserById(Integer userId) {
        User user = userDao.selectUserById(userId);
        return user;
    }
}