package com.example.sims.pojo;

/**
 * 用户信息实体类
 * 对应数据库表：user
 * 
 * @author SIMS Team
 * @version 1.0
 */
public class User {

    /** 用户唯一标识符（主键，自增） */
    private long id;
    
    /** 用户名（唯一且非空，最大50字符） */
    private String username;
    
    /** 用户邮箱（唯一且非空，最大100字符） */
    private String email;
    
    /** 加密后的密码（非空，建议使用bcrypt加密） */
    private String password;
    
    /** 用户真实姓名（非空，最大50字符） */
    private String realName;
    
    /** 用户创建时间（默认当前时间） */
    private java.sql.Timestamp createdAt;
    
    /** 用户更新时间（默认当前时间） */
    private java.sql.Timestamp updatedAt;

    // 构造函数
    public User() {}

    public User(String username, String email, String password, String realName) {
        this.username = username;
        this.email = email;
        this.password = password;
        this.realName = realName;
    }

    public User(long id, String username, String email, String password, String realName, java.sql.Timestamp createdAt) {
        this.id = id;
        this.username = username;
        this.email = email;
        this.password = password;
        this.realName = realName;
        this.createdAt = createdAt;
    }

    public User(long id, String username, String email, String password, String realName, java.sql.Timestamp createdAt, java.sql.Timestamp updatedAt) {
        this.id = id;
        this.username = username;
        this.email = email;
        this.password = password;
        this.realName = realName;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    // Getter和Setter方法
    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRealName() {
        return realName;
    }

    public void setRealName(String realName) {
        this.realName = realName;
    }

    public java.sql.Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(java.sql.Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public java.sql.Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(java.sql.Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", username='" + username + '\'' +
                ", email='" + email + '\'' +
                ", password='[PROTECTED]'" +
                ", realName='" + realName + '\'' +
                ", createdAt=" + createdAt +
                ", updatedAt=" + updatedAt +
                '}';
    }
}
