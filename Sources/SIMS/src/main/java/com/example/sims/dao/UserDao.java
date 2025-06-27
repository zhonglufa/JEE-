package com.example.sims.dao;

import com.example.sims.pojo.User;
import org.apache.ibatis.annotations.*;

import java.util.List;

/**
 * 用户信息数据访问层接口
 * 提供用户信息的CRUD操作和认证功能
 * 
 * @author SIMS Team
 * @version 1.0
 */
@Mapper
public interface UserDao {

    /**
     * 根据用户名查询用户信息
     * 
     * @param username 用户名
     * @return 用户信息对象
     */
    @Select("SELECT * FROM user WHERE username = #{username}")
    @Results(id = "user", value = {
        @Result(property = "id", column = "id"),
        @Result(property = "username", column = "username"),
        @Result(property = "email", column = "email"),
        @Result(property = "password", column = "password"),
        @Result(property = "realName", column = "real_name"),
        @Result(property = "createdAt", column = "created_at"),
        @Result(property = "updatedAt", column = "updated_at")
    })
    User findByUsername(String username);

    /**
     * 根据用户ID查询用户信息
     * 
     * @param id 用户ID
     * @return 用户信息对象
     */
    @Select("SELECT * FROM user WHERE id = #{id}")
    @ResultMap("user")
    User findById(long id);

    /**
     * 根据邮箱查询用户信息
     * 
     * @param email 用户邮箱
     * @return 用户信息对象
     */
    @Select("SELECT * FROM user WHERE email = #{email}")
    @ResultMap("user")
    User findByEmail(String email);

    /**
     * 插入新用户信息
     * 
     * @param user 用户信息对象
     * @return 影响的行数
     */
    @Insert("INSERT INTO user(username, email, password, real_name) " +
            "VALUES(#{username}, #{email}, #{password}, #{realName})")
    int insert(User user);

    /**
     * 验证用户名和密码
     * 
     * @param username 用户名
     * @param password 密码
     * @return 用户信息对象
     */
    @Select("SELECT * FROM user WHERE username = #{username} AND password = #{password}")
    @ResultMap("user")
    User authenticate(@Param("username") String username, @Param("password") String password);

    /**
     * 检查用户名是否已存在
     * 
     * @param username 用户名
     * @return 是否存在
     */
    @Select("SELECT COUNT(*) > 0 FROM user WHERE username = #{username}")
    boolean existsByUsername(String username);

    /**
     * 检查邮箱是否已存在
     * 
     * @param email 邮箱
     * @return 是否存在
     */
    @Select("SELECT COUNT(*) > 0 FROM user WHERE email = #{email}")
    boolean existsByEmail(String email);

    /**
     * 统计用户总数
     * 
     * @return 用户总数
     */
    @Select("SELECT COUNT(*) FROM user")
    int countAll();

    /**
     * 查询所有用户信息
     * 
     * @return 用户信息列表
     */
    @Select("SELECT id, username, email, real_name, created_at FROM user ORDER BY created_at DESC")
    @ResultMap("user")
    List<User> selectAll();
}