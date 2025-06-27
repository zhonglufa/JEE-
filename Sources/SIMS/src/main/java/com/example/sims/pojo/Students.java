package com.example.sims.pojo;

/**
 * 学生信息实体类
 * 对应数据库表：students
 * 
 * @author SIMS Team
 * @version 1.0
 */
public class Students {

    /** 学生唯一标识符（主键，自增） */
    private long id;
    
    /** 学生学号（唯一） */
    private String studentId;
    
    /** 学生姓名（非空） */
    private String name;
    
    /** 性别（M:男/F:女，非空） */
    private String gender;
    
    /** 出生日期 */
    private java.sql.Date birthDate;
    
    /** 联系电话 */
    private String phone;
    
    /** 联系地址 */
    private String address;
    
    /** 记录创建时间（默认当前时间） */
    private java.sql.Timestamp createdAt;
    
    /** 记录更新时间（默认当前时间） */
    private java.sql.Timestamp updatedAt;

    // 构造函数
    public Students() {}

    public Students(String studentId, String name, String gender, java.sql.Date birthDate, String phone, String address) {
        this.studentId = studentId;
        this.name = name;
        this.gender = gender;
        this.birthDate = birthDate;
        this.phone = phone;
        this.address = address;
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

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public java.sql.Date getBirthDate() {
        return birthDate;
    }

    public void setBirthDate(java.sql.Date birthDate) {
        this.birthDate = birthDate;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
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
        return "Students{" +
                "id=" + id +
                ", studentId='" + studentId + '\'' +
                ", name='" + name + '\'' +
                ", gender='" + gender + '\'' +
                ", birthDate=" + birthDate +
                ", phone='" + phone + '\'' +
                ", address='" + address + '\'' +
                ", createdAt=" + createdAt +
                ", updatedAt=" + updatedAt +
                '}';
    }
}
