package com.example.sims.service;

import com.example.sims.pojo.Grades;

import java.util.List;
import java.util.Map;

/**
 * 成绩信息服务接口
 * 定义成绩信息相关的业务方法
 * 
 * @author SIMS Team
 * @version 1.0
 */
public interface GradesService {

    /**
     * 获取所有成绩详细信息
     * 
     * @return 包含详细信息的成绩记录列表
     */
    List<Map<String, Object>> getAllGradesWithDetails();

    /**
     * 根据成绩ID获取成绩信息
     * 
     * @param id 成绩记录ID
     * @return 成绩信息对象
     */
    Grades getGradeById(long id);

    /**
     * 根据学生ID获取成绩信息
     * 
     * @param studentId 学生ID
     * @return 该学生的所有成绩记录
     */
    List<Grades> getGradesByStudentId(String studentId);

    /**
     * 根据课程ID获取成绩信息
     * 
     * @param courseId 课程ID
     * @return 该课程的所有成绩记录
     */
    List<Grades> getGradesByCourseId(String courseId);

    /**
     * 根据学生姓名搜索成绩信息
     * 
     * @param studentName 学生姓名
     * @return 包含详细信息的成绩记录列表
     */
    List<Map<String, Object>> getGradesWithDetailsByStudentName(String studentName);

    /**
     * 根据课程名称搜索成绩信息
     * 
     * @param courseName 课程名称
     * @return 包含详细信息的成绩记录列表
     */
    List<Map<String, Object>> getGradesWithDetailsByCourseName(String courseName);

    /**
     * 分页获取成绩详细信息
     * 
     * @param page 页码（从1开始）
     * @param size 每页大小
     * @return 包含详细信息的成绩记录列表
     */
    List<Map<String, Object>> getGradesWithDetailsByPage(int page, int size);

    /**
     * 获取成绩记录总数
     * 
     * @return 成绩记录总数
     */
    int getGradeCount();

    /**
     * 根据条件获取成绩记录数量
     * 
     * @param studentId 学生ID（可选）
     * @param courseId 课程ID（可选）
     * @return 匹配的成绩记录数量
     */
    int getGradeCountByCondition(String studentId, String courseId);

    /**
     * 添加成绩信息
     * 
     * @param grade 成绩信息对象
     * @return 影响的行数
     */
    int addGrade(Grades grade);

    /**
     * 更新成绩信息
     * 
     * @param grade 成绩信息对象
     * @return 影响的行数
     */
    int updateGrade(Grades grade);

    /**
     * 删除成绩信息
     * 
     * @param id 成绩记录ID
     * @return 影响的行数
     */
    int deleteGrade(long id);

    /**
     * 检查学生和课程的成绩记录是否已存在
     * 
     * @param studentId 学生ID
     * @param courseId 课程ID
     * @return 是否存在
     */
    boolean existsByStudentAndCourse(String studentId, String courseId);

    /**
     * 获取成绩统计信息
     * 
     * @return 统计信息Map
     */
    Map<String, Object> getGradeStatistics();
}
