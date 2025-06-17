package com.guihang2.bbs_forum.pojo;

import java.sql.Timestamp;

public class Reply {
    private Integer replyId; // 回复ID
    private Integer commentId; // 所属评论ID
    private Integer userId; // 用户ID

    private Integer postId; // 所属帖子ID

    private Integer parentReplyId; // 父回复ID
    private String content; // 回复内容
    private Timestamp createdAt; // 创建时间
    private String userName; // 用户名

    public Integer getReplyId() {
        return replyId;
    }

    public void setReplyId(Integer replyId) {
        this.replyId = replyId;
    }

    public Integer getCommentId() {
        return commentId;
    }

    public void setCommentId(Integer commentId) {
        this.commentId = commentId;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getPostId() {
        return postId;
    }

    public void setPostId(Integer postId) {
        this.postId = postId;
    }

    public Integer getParentReplyId() {
        return parentReplyId;
    }

    public void setParentReplyId(Integer parentReplyId) {
        this.parentReplyId = parentReplyId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    @Override
    public String toString() {
        return "Reply{" +
                "replyId=" + replyId +
                ", commentId=" + commentId +
                ", userId=" + userId +
                ", postId=" + postId +
                ", parentReplyId=" + parentReplyId +
                ", content='" + content + '\'' +
                ", createdAt=" + createdAt +
                ", userName='" + userName + '\'' +
                '}';
    }
}