package com.guihang2.bbs_forum.pojo;


public class AdminLog {

  private Integer LogId; // 日志id
  private Integer adminId; // 管理员id
  private String operation; // 操作
  private Integer targetId; // 目标id
  private java.sql.Timestamp createdAt; // 创建时间

  public Integer getLogId() {
    return LogId;
  }

  public void setLogId(Integer logId) {
    LogId = logId;
  }

  public long getAdminId() {
    return adminId;
  }

  public void setAdminId(Integer adminId) {
    this.adminId = adminId;
  }


  public String getOperation() {
    return operation;
  }

  public void setOperation(String operation) {
    this.operation = operation;
  }


  public long getTargetId() {
    return targetId;
  }

  public void setTargetId(Integer targetId) {
    this.targetId = targetId;
  }


  public java.sql.Timestamp getCreatedAt() {
    return createdAt;
  }

  public void setCreatedAt(java.sql.Timestamp createdAt) {
    this.createdAt = createdAt;
  }


  @Override
  public String toString() {
    return "AdminLog{" +
            "LogId=" + LogId +
            ", adminId=" + adminId +
            ", operation='" + operation + '\'' +
            ", targetId=" + targetId +
            ", createdAt=" + createdAt +
            '}';
  }
}
