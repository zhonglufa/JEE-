package com.example.sims.dao;

import com.example.sims.pojo.Grades;
import org.apache.ibatis.annotations.*;

import java.util.List;
import java.util.Map;

/**
 * 成绩信息数据访问层接口
 * 提供成绩信息的CRUD操作
 * 
 * @author SIMS Team
 * @version 1.0
 */
public interface GradesDao {
    
    /**
     * 查询所有成绩信息
     * 
     * @return 成绩信息列表
     */
    @Select("SELECT * FROM grades ORDER BY id DESC")
    @Results(id = "grade", value = {
        @Result(property = "id", column = "id"),
        @Result(property = "studentId", column = "student_id"),
        @Result(property = "courseId", column = "course_id"),
        @Result(property = "score", column = "score"),
        @Result(property = "createdAt", column = "created_at"),
        @Result(property = "updatedAt", column = "updated_at")
    })
    List<Grades> selectAll();

    /**
     * 根据成绩ID查询成绩信息
     * 
     * @param id 成绩记录ID
     * @return 成绩信息对象
     */
    @Select("SELECT * FROM grades WHERE id = #{id}")
    @ResultMap("grade")
    Grades selectById(long id);

    /**
     * 根据学生ID查询成绩信息
     * 
     * @param studentId 学生ID
     * @return 该学生的所有成绩记录
     */
    @Select("SELECT * FROM grades WHERE student_id = #{studentId} ORDER BY id DESC")
    @ResultMap("grade")
    List<Grades> selectByStudentId(String studentId);

    /**
     * 根据课程ID查询成绩信息
     * 
     * @param courseId 课程ID
     * @return 该课程的所有成绩记录
     */
    @Select("SELECT * FROM grades WHERE course_id = #{courseId} ORDER BY id DESC")
    @ResultMap("grade")
    List<Grades> selectByCourseId(String courseId);

    /**
     * 根据学生ID和课程ID查询成绩信息
     * 
     * @param studentId 学生ID
     * @param courseId 课程ID
     * @return 成绩信息对象
     */
    @Select("SELECT * FROM grades WHERE student_id = #{studentId} AND course_id = #{courseId}")
    @ResultMap("grade")
    Grades selectByStudentAndCourse(@Param("studentId") String studentId, @Param("courseId") String courseId);

    /**
     * 分页查询成绩信息
     * 
     * @param offset 偏移量
     * @param limit 每页数量
     * @return 成绩信息列表
     */
    @Select("SELECT * FROM grades ORDER BY id DESC LIMIT #{offset}, #{limit}")
    @ResultMap("grade")
    List<Grades> selectByPage(@Param("offset") int offset, @Param("limit") int limit);

    /**
     * 统计成绩记录总数
     * 
     * @return 成绩记录总数
     */
    @Select("SELECT COUNT(*) FROM grades")
    int countAll();

    /**
     * 根据条件统计成绩记录数量
     * 
     * @param studentId 学生ID（可选）
     * @param courseId 课程ID（可选）
     * @return 匹配的成绩记录数量
     */
    @Select("<script>" +
            "SELECT COUNT(*) FROM grades WHERE 1=1" +
            "<if test='studentId != null and studentId != \"\"'>" +
            " AND student_id = #{studentId}" +
            "</if>" +
            "<if test='courseId != null and courseId != \"\"'>" +
            " AND course_id = #{courseId}" +
            "</if>" +
            "</script>")
    int countByCondition(@Param("studentId") String studentId, @Param("courseId") String courseId);

    /**
     * 插入新成绩信息
     * 
     * @param grade 成绩信息对象
     * @return 影响的行数
     */
    @Insert("INSERT INTO grades (student_id, course_id, score) " +
            "VALUES (#{studentId}, #{courseId}, #{score})")
    int insert(Grades grade);

    /**
     * 更新成绩信息
     * 
     * @param grade 成绩信息对象
     * @return 影响的行数
     */
    @Update("UPDATE grades SET student_id=#{studentId}, course_id=#{courseId}, " +
            "score=#{score} WHERE id=#{id}")
    int update(Grades grade);

    /**
     * 根据成绩ID删除成绩信息
     * 
     * @param id 成绩记录ID
     * @return 影响的行数
     */
    @Delete("DELETE FROM grades WHERE id = #{id}")
    int delete(long id);

    /**
     * 查询成绩详细信息（包含学生姓名和课程名称）
     * 
     * @return 包含详细信息的成绩记录列表
     */
    @Select("SELECT g.id, g.student_id, s.name as student_name, g.course_id, " +
            "c.course_name, g.score " +
            "FROM grades g " +
            "JOIN students s ON g.student_id = s.student_id " +
            "JOIN courses c ON g.course_id = c.course_id " +
            "ORDER BY g.id DESC")
    List<Map<String, Object>> selectWithDetails();

    /**
     * 分页查询成绩详细信息
     * 
     * @param offset 偏移量
     * @param limit 每页数量
     * @return 包含详细信息的成绩记录列表
     */
    @Select("SELECT g.id, g.student_id, s.name as student_name, g.course_id, " +
            "c.course_name, g.score " +
            "FROM grades g " +
            "JOIN students s ON g.student_id = s.student_id " +
            "JOIN courses c ON g.course_id = c.course_id " +
            "ORDER BY g.id DESC LIMIT #{offset}, #{limit}")
    List<Map<String, Object>> selectWithDetailsByPage(@Param("offset") int offset, @Param("limit") int limit);

    /**
     * 根据学生姓名模糊查询成绩信息
     * 
     * @param studentName 学生姓名（支持模糊查询）
     * @return 包含详细信息的成绩记录列表
     */
    @Select("SELECT g.id, g.student_id, s.name as student_name, g.course_id, " +
            "c.course_name, g.score " +
            "FROM grades g " +
            "JOIN students s ON g.student_id = s.student_id " +
            "JOIN courses c ON g.course_id = c.course_id " +
            "WHERE s.name LIKE CONCAT('%', #{studentName}, '%') " +
            "ORDER BY g.id DESC")
    List<Map<String, Object>> selectWithDetailsByStudentName(String studentName);

    /**
     * 根据课程名称模糊查询成绩信息
     * 
     * @param courseName 课程名称（支持模糊查询）
     * @return 包含详细信息的成绩记录列表
     */
    @Select("SELECT g.id, g.student_id, s.name as student_name, g.course_id, " +
            "c.course_name, g.score " +
            "FROM grades g " +
            "JOIN students s ON g.student_id = s.student_id " +
            "JOIN courses c ON g.course_id = c.course_id " +
            "WHERE c.course_name LIKE CONCAT('%', #{courseName}, '%') " +
            "ORDER BY g.id DESC")
    List<Map<String, Object>> selectWithDetailsByCourseName(String courseName);

    /**
     * 检查学生和课程的成绩记录是否已存在
     * 
     * @param studentId 学生ID
     * @param courseId 课程ID
     * @return 是否存在
     */
    @Select("SELECT COUNT(*) > 0 FROM grades WHERE student_id = #{studentId} AND course_id = #{courseId}")
    boolean existsByStudentAndCourse(@Param("studentId") String studentId, @Param("courseId") String courseId);

    /**
     * 获取成绩统计信息
     * 
     * @return 包含统计信息的Map
     */
    @Select("SELECT " +
            "COUNT(*) as total_records, " +
            "AVG(score) as average_score, " +
            "MAX(score) as max_score, " +
            "MIN(score) as min_score, " +
            "COUNT(DISTINCT student_id) as unique_students, " +
            "COUNT(DISTINCT course_id) as unique_courses " +
            "FROM grades")
    Map<String, Object> getStatistics();
}