package com.example.sims.service.Impl;

import com.example.sims.dao.UserDao;
import com.example.sims.pojo.User;
import com.example.sims.service.UserService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

/**
 * 用户服务实现类
 * 提供用户认证、注册、用户名和邮箱检查功能
 * 
 * @author SIMS Team
 * @version 1.0
 */
@Service
public class UserServiceImpl implements UserService {
    
    @Autowired
    private UserDao userDao;
    
    @Autowired
    private PasswordEncoder passwordEncoder;

    /**
     * 用户认证方法，验证用户名和密码是否匹配
     *
     * @param username 用户名
     * @param password 明文密码
     * @return 如果用户名和密码匹配，则返回用户对象；否则返回null
     */
    @Override
    public User authenticate(String username, String password) {
        try {
            // 根据用户名查询用户信息
            User user = userDao.findByUsername(username);
            if (user != null && passwordEncoder.matches(password, user.getPassword())) {
                return user; // 密码匹配，返回用户对象
            }
            return null; // 密码不匹配或用户不存在，返回null
        } catch (Exception e) {
            // 记录错误日志
            System.err.println("用户认证失败: " + e.getMessage());
            return null;
        }
    }

    /**
     * 用户注册方法，创建新用户并保存到数据库
     *
     * @param username 用户名
     * @param email    邮箱地址
     * @param password 明文密码
     * @param realName 真实姓名
     */
    @Override
    public void registerUser(String username, String email, String password, String realName) {
        try {
            // 创建新用户对象
            User user = new User();
            user.setUsername(username);
            user.setEmail(email);

            // 使用PasswordEncoder加密密码
            user.setPassword(passwordEncoder.encode(password));
            user.setRealName(realName);

            // 将用户信息插入数据库
            int result = userDao.insert(user);
            if (result <= 0) {
                throw new RuntimeException("用户注册失败");
            }
        } catch (Exception e) {
            // 记录错误日志
            System.err.println("用户注册失败: " + e.getMessage());
            throw new RuntimeException("用户注册失败: " + e.getMessage());
        }
    }

    /**
     * 检查用户名是否已存在
     *
     * @param username 用户名
     * @return 如果用户名已存在，则返回true；否则返回false
     */
    @Override
    public boolean usernameExists(String username) {
        try {
            // 根据用户名查询用户信息
            return userDao.findByUsername(username) != null;
        } catch (Exception e) {
            // 记录错误日志
            System.err.println("检查用户名失败: " + e.getMessage());
            return false;
        }
    }

    /**
     * 检查邮箱是否已存在
     *
     * @param email 邮箱地址
     * @return 如果邮箱已存在，则返回true；否则返回false
     */
    @Override
    public boolean emailExists(String email) {
        try {
            // 根据邮箱查询用户信息
            return userDao.findByEmail(email) != null;
        } catch (Exception e) {
            // 记录错误日志
            System.err.println("检查邮箱失败: " + e.getMessage());
            return false;
        }
    }
}