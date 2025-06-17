package com.guihang2.bbs_forum.pojo;


import java.sql.Timestamp;

public class User {
  // 空用户实例，对外表现为“无效用户”
  public static final User EMPTY = new User(-1, "Unknown", "", "", false);
  private Integer userId; //用户id
  private String username; //用户名
  private String password; //密码
  private String email; //邮箱
  private String role; //角色
  private String avatarUrl;//头像
  private java.sql.Timestamp createdAt; //创建时间

  // 构造方法


  public User() {
  }

  public User(Integer userId, String username, String password, String email, String role, String avatarUrl, Timestamp createdAt) {
    this.userId = userId;
    this.username = username;
    this.password = password;
    this.email = email;
    this.role = role;
    this.avatarUrl = avatarUrl;
    this.createdAt = createdAt;
  }
  //空对象
  public User(int i, String unknown, String s, String s1, boolean b) {
    this.userId = i;
    this.username = unknown;
    this.password = s;
    this.email = s1;
    this.role = b ? "admin" : "user";
  }

  public Integer getUserId() {
    return userId;
  }

  public void setUserId(Integer userId) {
    this.userId = userId;
  }


  public String getAvatarUrl() {
    return avatarUrl;
  }

  public void setAvatarUrl(String avatarUrl) {
    this.avatarUrl = avatarUrl;
  }

  public long getId() {
    return userId;
  }

  public void setId(Integer userId) {
    this.userId = userId;
  }


  public String getUsername() {
    return username;
  }

  public void setUsername(String username) {
    this.username = username;
  }


  public String getPassword() {
    return password;
  }

  public void setPassword(String password) {
    this.password = password;
  }


  public String getEmail() {
    return email;
  }

  public void setEmail(String email) {
    this.email = email;
  }


  public String getRole() {
    return role;
  }

  public void setRole(String role) {
    this.role = role;
  }


  public java.sql.Timestamp getCreatedAt() {
    return createdAt;
  }

  public void setCreatedAt(java.sql.Timestamp createdAt) {
    this.createdAt = createdAt;
  }

  @Override
  public String toString() {
    return "User{" +
            "userId=" + userId +
            ", username='" + username + '\'' +
            ", password='" + password + '\'' +
            ", email='" + email + '\'' +
            ", role='" + role + '\'' +
            ", avatarUrl='" + avatarUrl + '\'' +
            ", createdAt=" + createdAt +
            '}';
  }
}
