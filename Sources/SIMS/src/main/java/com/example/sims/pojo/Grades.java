package com.example.sims.pojo;

/**
 * 成绩信息实体类
 * 对应数据库表：grades
 * 
 * @author SIMS Team
 * @version 1.0
 */
public class Grades {

    /** 成绩记录ID（主键，自增） */
    private long id;
    
    /** 关联学生ID（外键，关联students表） */
    private String studentId;
    
    /** 关联课程ID（外键，关联courses表） */
    private String courseId;
    
    /** 课程成绩（0-100分，可空） */
    private java.math.BigDecimal score;
    
    /** 记录创建时间（默认当前时间） */
    private java.sql.Timestamp createdAt;
    
    /** 记录更新时间（默认当前时间） */
    private java.sql.Timestamp updatedAt;

    // 构造函数
    public Grades() {}

    public Grades(String studentId, String courseId, java.math.BigDecimal score) {
        this.studentId = studentId;
        this.courseId = courseId;
        this.score = score;
    }

    public Grades(long id, String studentId, String courseId, java.math.BigDecimal score) {
        this.id = id;
        this.studentId = studentId;
        this.courseId = courseId;
        this.score = score;
    }

    public Grades(long id, String studentId, String courseId, java.math.BigDecimal score, java.sql.Timestamp createdAt, java.sql.Timestamp updatedAt) {
        this.id = id;
        this.studentId = studentId;
        this.courseId = courseId;
        this.score = score;
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

    public String getStudentId() {
        return studentId;
    }

    public void setStudentId(String studentId) {
        this.studentId = studentId;
    }

    public String getCourseId() {
        return courseId;
    }

    public void setCourseId(String courseId) {
        this.courseId = courseId;
    }

    public java.math.BigDecimal getScore() {
        return score;
    }

    public void setScore(java.math.BigDecimal score) {
        this.score = score;
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

    // 为了兼容现有代码，保留double类型的getter/setter
    public double getScoreAsDouble() {
        return score != null ? score.doubleValue() : 0.0;
    }

    public void setScoreAsDouble(double score) {
        this.score = java.math.BigDecimal.valueOf(score);
    }

    @Override
    public String toString() {
        return "Grades{" +
                "id=" + id +
                ", studentId='" + studentId + '\'' +
                ", courseId='" + courseId + '\'' +
                ", score=" + score +
                ", createdAt=" + createdAt +
                ", updatedAt=" + updatedAt +
                '}';
    }
}
