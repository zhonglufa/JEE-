package com.guihang2.bbs_forum.pojo;


public class User {

  private Integer userId; //用户id
  private String username; //用户名
  private String password; //密码
  private String email; //邮箱
  private String role; //角色
  private String avatarUrl;//头像
  private java.sql.Timestamp createdAt; //创建时间

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
