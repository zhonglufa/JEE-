package com.example.sims.service;

import com.example.sims.pojo.Courses;

import java.util.List;
import java.util.Map;

/**
 * 课程信息服务接口
 * 定义课程信息相关的业务方法
 * 
 * @author SIMS Team
 * @version 1.0
 */
public interface CoursesService {

    /**
     * 获取所有课程信息
     * 
     * @return 课程信息列表
     */
    List<Courses> getAllCourses();

    /**
     * 根据课程ID获取课程信息
     * 
     * @param id 课程ID
     * @return 课程信息对象
     */
    Courses getCourseById(String id);

    /**
     * 根据课程名称搜索课程信息
     * 
     * @param courseName 课程名称
     * @return 匹配的课程信息列表
     */
    List<Courses> getCoursesByName(String courseName);

    /**
     * 根据任课教师搜索课程信息
     * 
     * @param teacher 任课教师姓名
     * @return 匹配的课程信息列表
     */
    List<Courses> getCoursesByTeacher(String teacher);

    /**
     * 分页获取课程信息
     * 
     * @param page 页码（从1开始）
     * @param size 每页大小
     * @return 课程信息列表
     */
    List<Courses> getCoursesByPage(int page, int size);

    /**
     * 获取课程总数
     * 
     * @return 课程总数
     */
    int getCourseCount();

    /**
     * 根据条件获取课程数量
     * 
     * @param courseName 课程名称（可选）
     * @param teacher 任课教师（可选）
     * @return 匹配的课程数量
     */
    int getCourseCountByCondition(String courseName, String teacher);

    /**
     * 添加课程信息
     * 
     * @param course 课程信息对象
     * @return 影响的行数
     */
    int addCourse(Courses course);

    /**
     * 更新课程信息
     * 
     * @param course 课程信息对象
     * @return 影响的行数
     */
    int updateCourse(Courses course);

    /**
     * 删除课程信息
     * 
     * @param id 课程ID
     * @return 影响的行数
     */
    int deleteCourse(String id);

    /**
     * 检查课程ID是否存在
     * 
     * @param courseId 课程ID
     * @return 是否存在
     */
    boolean existsById(String courseId);

    /**
     * 获取所有任课教师列表
     * 
     * @return 教师姓名列表
     */
    List<String> getAllTeachers();

    /**
     * 获取课程统计信息
     * 
     * @return 统计信息Map
     */
    Map<String, Object> getCourseStatistics();
}
