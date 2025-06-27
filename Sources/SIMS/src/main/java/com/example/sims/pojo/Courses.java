package com.example.sims.pojo;

/**
 * 课程信息实体类
 * 对应数据库表：courses
 * 
 * @author SIMS Team
 * @version 1.0
 */
public class Courses {

    /** 课程唯一标识符（主键，自增） */
    private long id;
    
    /** 课程编号（唯一） */
    private String courseId;
    
    /** 课程名称（非空） */
    private String courseName;
    
    /** 课程类型（如: 专业必修/选修） */
    private String courseType;
    
    /** 学分 */
    private double credit;
    
    /** 任课教师 */
    private String teacher;
    
    /** 开课学院 */
    private String college;
    
    /** 开课状态（如: 已开通/未开通） */
    private String status;
    
    /** 记录创建时间（默认当前时间） */
    private java.sql.Timestamp createdAt;
    
    /** 记录更新时间（默认当前时间） */
    private java.sql.Timestamp updatedAt;

    // 构造函数
    public Courses() {}

    public Courses(String courseId, String courseName, String courseType, double credit, String teacher, String college, String status) {
        this.courseId = courseId;
        this.courseName = courseName;
        this.courseType = courseType;
        this.credit = credit;
        this.teacher = teacher;
        this.college = college;
        this.status = status;
    }

    public Courses(long id, String courseId, String courseName, String courseType, double credit, String teacher, String college, String status, java.sql.Timestamp createdAt, java.sql.Timestamp updatedAt) {
        this.id = id;
        this.courseId = courseId;
        this.courseName = courseName;
        this.courseType = courseType;
        this.credit = credit;
        this.teacher = teacher;
        this.college = college;
        this.status = status;
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

    public String getCourseId() {
        return courseId;
    }

    public void setCourseId(String courseId) {
        this.courseId = courseId;
    }

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    public String getCourseType() {
        return courseType;
    }

    public void setCourseType(String courseType) {
        this.courseType = courseType;
    }

    public double getCredit() {
        return credit;
    }

    public void setCredit(double credit) {
        this.credit = credit;
    }

    public String getTeacher() {
        return teacher;
    }

    public void setTeacher(String teacher) {
        this.teacher = teacher;
    }

    public String getCollege() {
        return college;
    }

    public void setCollege(String college) {
        this.college = college;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
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
        return "Courses{" +
                "id=" + id +
                ", courseId='" + courseId + '\'' +
                ", courseName='" + courseName + '\'' +
                ", courseType='" + courseType + '\'' +
                ", credit=" + credit +
                ", teacher='" + teacher + '\'' +
                ", college='" + college + '\'' +
                ", status='" + status + '\'' +
                ", createdAt=" + createdAt +
                ", updatedAt=" + updatedAt +
                '}';
    }


}
