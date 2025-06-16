package com.guihang2.bbs_forum.dao;

import com.guihang2.bbs_forum.pojo.User;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface UserDao {
    //注册用户
    @Select("insert into user (username, password, email, role, created_at) values (#{username}, #{password}, #{email}, #{role}, #{createdAt})")
    void insertUser(User user);
    
    //登录验证
    @Select("select * from user where email= #{email} and password = #{password}")
    User selectUserByUsernameAndPassword(User user);

    // 修改查询用户的方法，确保返回正确的用户对象
    @Select("SELECT * FROM user WHERE email = #{email}")
    User selectUserByEmail(@Param("email") String email);
    //根据id获取用户
    @Select("SELECT * FROM user WHERE userId = #{userId}")
    User selectUserById(@Param("userId") Integer userId);
}