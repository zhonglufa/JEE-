package com.example.sims.dao;

import com.example.sims.pojo.Courses;
import org.apache.ibatis.annotations.*;

import java.util.List;

/**
 * 课程信息数据访问层接口
 * 提供课程信息的CRUD操作
 * 
 * @author SIMS Team
 * @version 1.0
 */
public interface CoursesDao {
    
    /**
     * 查询所有课程信息
     * 
     * @return 课程信息列表
     */
    @Select("SELECT * FROM courses ORDER BY course_id")
    @Results(id = "course", value = {
        @Result(property = "id", column = "id"),
        @Result(property = "courseId", column = "course_id"),
        @Result(property = "courseName", column = "course_name"),
        @Result(property = "courseType", column = "course_type"),
        @Result(property = "credit", column = "credit"),
        @Result(property = "teacher", column = "teacher"),
        @Result(property = "college", column = "college"),
        @Result(property = "status", column = "status"),
        @Result(property = "createdAt", column = "created_at"),
        @Result(property = "updatedAt", column = "updated_at")
    })
    List<Courses> selectAll();

    /**
     * 根据课程ID查询课程信息
     * 
     * @param id 课程ID
     * @return 课程信息对象
     */
    @Select("SELECT * FROM courses WHERE course_id = #{id}")
    @ResultMap("course")
    Courses selectById(String id);

    /**
     * 根据课程名称模糊查询课程信息
     * 
     * @param courseName 课程名称（支持模糊查询）
     * @return 匹配的课程信息列表
     */
    @Select("SELECT * FROM courses WHERE course_name LIKE CONCAT('%', #{courseName}, '%') ORDER BY course_id")
    @ResultMap("course")
    List<Courses> selectByName(String courseName);

    /**
     * 根据任课教师查询课程信息
     * 
     * @param teacher 任课教师姓名
     * @return 匹配的课程信息列表
     */
    @Select("SELECT * FROM courses WHERE teacher LIKE CONCAT('%', #{teacher}, '%') ORDER BY course_id")
    @ResultMap("course")
    List<Courses> selectByTeacher(String teacher);

    /**
     * 分页查询课程信息
     * 
     * @param offset 偏移量
     * @param limit 每页数量
     * @return 课程信息列表
     */
    @Select("SELECT * FROM courses ORDER BY course_id LIMIT #{offset}, #{limit}")
    @ResultMap("course")
    List<Courses> selectByPage(@Param("offset") int offset, @Param("limit") int limit);

    /**
     * 统计课程总数
     * 
     * @return 课程总数
     */
    @Select("SELECT COUNT(*) FROM courses")
    int countAll();

    /**
     * 根据条件统计课程数量
     * 
     * @param courseName 课程名称（可选）
     * @param teacher 任课教师（可选）
     * @return 匹配的课程数量
     */
    @Select("<script>" +
            "SELECT COUNT(*) FROM courses WHERE 1=1" +
            "<if test='courseName != null and courseName != \"\"'>" +
            " AND course_name LIKE CONCAT('%', #{courseName}, '%')" +
            "</if>" +
            "<if test='teacher != null and teacher != \"\"'>" +
            " AND teacher LIKE CONCAT('%', #{teacher}, '%')" +
            "</if>" +
            "</script>")
    int countByCondition(@Param("courseName") String courseName, @Param("teacher") String teacher);

    /**
     * 插入新课程信息
     * 
     * @param course 课程信息对象
     * @return 影响的行数
     */
    @Insert("INSERT INTO courses (course_id, course_name, course_type, credit, teacher, college, status) " +
            "VALUES (#{courseId}, #{courseName}, #{courseType}, #{credit}, #{teacher}, #{college}, #{status})")
    int insert(Courses course);

    /**
     * 更新课程信息
     * 
     * @param course 课程信息对象
     * @return 影响的行数
     */
    @Update("UPDATE courses SET course_name=#{courseName}, course_type=#{courseType}, credit=#{credit}, " +
            "teacher=#{teacher}, college=#{college}, status=#{status} WHERE course_id=#{courseId}")
    int update(Courses course);

    /**
     * 根据课程ID删除课程信息
     * 
     * @param id 课程ID
     * @return 影响的行数
     */
    @Delete("DELETE FROM courses WHERE course_id = #{id}")
    int delete(String id);

    /**
     * 检查课程ID是否已存在
     * 
     * @param courseId 课程ID
     * @return 是否存在
     */
    @Select("SELECT COUNT(*) > 0 FROM courses WHERE course_id = #{courseId}")
    boolean existsById(String courseId);

    /**
     * 获取所有任课教师列表
     * 
     * @return 教师姓名列表
     */
    @Select("SELECT DISTINCT teacher FROM courses ORDER BY teacher")
    List<String> selectAllTeachers();
}