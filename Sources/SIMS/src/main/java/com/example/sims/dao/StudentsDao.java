package com.example.sims.dao;

import com.example.sims.pojo.Students;
import org.apache.ibatis.annotations.*;

import java.util.List;

/**
 * 学生信息数据访问层接口
 * 提供学生信息的CRUD操作
 * 
 * @author SIMS Team
 * @version 1.0
 */
public interface StudentsDao {
    
    /**
     * 查询所有学生信息
     * 
     * @return 学生信息列表
     */
    @Select("SELECT * FROM students ORDER BY created_at DESC")
    @Results(id = "student", value = {
        @Result(property = "id", column = "id"),
        @Result(property = "studentId", column = "student_id"),
        @Result(property = "name", column = "name"),
        @Result(property = "gender", column = "gender"),
        @Result(property = "birthDate", column = "birth_date"),
        @Result(property = "phone", column = "phone"),
        @Result(property = "address", column = "address"),
        @Result(property = "createdAt", column = "created_at"),
        @Result(property = "updatedAt", column = "updated_at")
    })
    List<Students> selectAll();

    /**
     * 根据学生ID查询学生信息
     * 
     * @param id 学生ID
     * @return 学生信息对象
     */
    @Select("SELECT * FROM students WHERE student_id = #{id}")
    @ResultMap("student")
    Students selectById(String id);

    /**
     * 根据姓名模糊查询学生信息
     * 
     * @param name 学生姓名（支持模糊查询）
     * @return 匹配的学生信息列表
     */
    @Select("SELECT * FROM students WHERE name LIKE CONCAT('%', #{name}, '%') ORDER BY created_at DESC")
    @ResultMap("student")
    List<Students> selectByName(String name);

    /**
     * 根据性别查询学生信息
     * 
     * @param gender 性别（M:男/F:女）
     * @return 匹配的学生信息列表
     */
    @Select("SELECT * FROM students WHERE gender = #{gender} ORDER BY created_at DESC")
    @ResultMap("student")
    List<Students> selectByGender(String gender);

    /**
     * 根据电话号码查询学生信息
     * 
     * @param phone 电话号码
     * @return 学生信息对象
     */
    @Select("SELECT * FROM students WHERE phone = #{phone}")
    @ResultMap("student")
    Students selectByPhone(String phone);

    /**
     * 分页查询学生信息
     * 
     * @param offset 偏移量
     * @param limit 每页数量
     * @return 学生信息列表
     */
    @Select("SELECT * FROM students ORDER BY created_at DESC LIMIT #{offset}, #{limit}")
    @ResultMap("student")
    List<Students> selectByPage(@Param("offset") int offset, @Param("limit") int limit);

    /**
     * 统计学生总数
     * 
     * @return 学生总数
     */
    @Select("SELECT COUNT(*) FROM students")
    int countAll();

    /**
     * 根据条件统计学生数量
     * 
     * @param name 姓名（可选）
     * @param gender 性别（可选）
     * @return 匹配的学生数量
     */
    @Select("<script>" +
            "SELECT COUNT(*) FROM students WHERE 1=1" +
            "<if test='name != null and name != \"\"'>" +
            " AND name LIKE CONCAT('%', #{name}, '%')" +
            "</if>" +
            "<if test='gender != null and gender != \"\"'>" +
            " AND gender = #{gender}" +
            "</if>" +
            "</script>")
    int countByCondition(@Param("name") String name, @Param("gender") String gender);

    /**
     * 插入新学生信息
     * 
     * @param student 学生信息对象
     * @return 影响的行数
     */
    @Insert("INSERT INTO students (student_id, name, gender, birth_date, phone, address) " +
            "VALUES (#{studentId}, #{name}, #{gender}, #{birthDate}, #{phone}, #{address})")
    int insert(Students student);

    /**
     * 更新学生信息
     * 
     * @param student 学生信息对象
     * @return 影响的行数
     */
    @Update("UPDATE students SET name=#{name}, gender=#{gender}, birth_date=#{birthDate}, " +
            "phone=#{phone}, address=#{address} WHERE student_id=#{studentId}")
    int update(Students student);

    /**
     * 根据学生ID删除学生信息
     * 
     * @param id 学生ID
     * @return 影响的行数
     */
    @Delete("DELETE FROM students WHERE student_id = #{id}")
    int delete(String id);

    /**
     * 检查学生ID是否已存在
     * 
     * @param studentId 学生ID
     * @return 是否存在
     */
    @Select("SELECT COUNT(*) > 0 FROM students WHERE student_id = #{studentId}")
    boolean existsById(String studentId);

    /**
     * 检查电话号码是否已存在
     * 
     * @param phone 电话号码
     * @return 是否存在
     */
    @Select("SELECT COUNT(*) > 0 FROM students WHERE phone = #{phone}")
    boolean existsByPhone(String phone);
}