package com.example.sims.service.Impl;

import com.example.sims.dao.CoursesDao;
import com.example.sims.pojo.Courses;
import com.example.sims.service.CoursesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 课程信息服务实现类
 * 提供课程信息的业务逻辑处理
 * 
 * @author SIMS Team
 * @version 1.0
 */
@Service
@Transactional
public class CoursesServiceImpl implements CoursesService {

    @Autowired
    private CoursesDao coursesDao;

    /**
     * 获取所有课程信息
     * 
     * @return 课程信息列表
     */
    @Override
    public List<Courses> getAllCourses() {
        return coursesDao.selectAll();
    }

    /**
     * 根据课程ID获取课程信息
     * 
     * @param id 课程ID
     * @return 课程信息对象
     */
    @Override
    public Courses getCourseById(String id) {
        return coursesDao.selectById(id);
    }

    /**
     * 根据课程名称搜索课程信息
     * 
     * @param courseName 课程名称
     * @return 匹配的课程信息列表
     */
    @Override
    public List<Courses> getCoursesByName(String courseName) {
        return coursesDao.selectByName(courseName);
    }

    /**
     * 根据任课教师搜索课程信息
     * 
     * @param teacher 任课教师姓名
     * @return 匹配的课程信息列表
     */
    @Override
    public List<Courses> getCoursesByTeacher(String teacher) {
        return coursesDao.selectByTeacher(teacher);
    }

    /**
     * 分页获取课程信息
     * 
     * @param page 页码（从1开始）
     * @param size 每页大小
     * @return 课程信息列表
     */
    @Override
    public List<Courses> getCoursesByPage(int page, int size) {
        int offset = (page - 1) * size;
        return coursesDao.selectByPage(offset, size);
    }

    /**
     * 获取课程总数
     * 
     * @return 课程总数
     */
    @Override
    public int getCourseCount() {
        return coursesDao.countAll();
    }

    /**
     * 根据条件获取课程数量
     * 
     * @param courseName 课程名称（可选）
     * @param teacher 任课教师（可选）
     * @return 匹配的课程数量
     */
    @Override
    public int getCourseCountByCondition(String courseName, String teacher) {
        return coursesDao.countByCondition(courseName, teacher);
    }

    /**
     * 添加课程信息
     * 
     * @param course 课程信息对象
     * @return 影响的行数
     */
    @Override
    public int addCourse(Courses course) {
        // 检查课程ID是否已存在
        if (coursesDao.existsById(course.getCourseId())) {
            throw new RuntimeException("课程ID已存在：" + course.getCourseId());
        }
        
        return coursesDao.insert(course);
    }

    /**
     * 更新课程信息
     * 
     * @param course 课程信息对象
     * @return 影响的行数
     */
    @Override
    public int updateCourse(Courses course) {
        // 检查课程是否存在
        Courses existingCourse = coursesDao.selectById(course.getCourseId());
        if (existingCourse == null) {
            throw new RuntimeException("课程不存在：" + course.getCourseId());
        }
        
        return coursesDao.update(course);
    }

    /**
     * 删除课程信息
     * 
     * @param id 课程ID
     * @return 影响的行数
     */
    @Override
    public int deleteCourse(String id) {
        // 检查课程是否存在
        Courses course = coursesDao.selectById(id);
        if (course == null) {
            throw new RuntimeException("课程不存在：" + id);
        }
        
        return coursesDao.delete(id);
    }

    /**
     * 检查课程ID是否存在
     * 
     * @param courseId 课程ID
     * @return 是否存在
     */
    @Override
    public boolean existsById(String courseId) {
        return coursesDao.existsById(courseId);
    }

    /**
     * 获取所有任课教师列表
     * 
     * @return 教师姓名列表
     */
    @Override
    public List<String> getAllTeachers() {
        return coursesDao.selectAllTeachers();
    }

    /**
     * 获取课程统计信息
     * 
     * @return 统计信息Map
     */
    @Override
    public Map<String, Object> getCourseStatistics() {
        Map<String, Object> statistics = new HashMap<>();
        
        // 总课程数
        int totalCourses = coursesDao.countAll();
        statistics.put("totalCourses", totalCourses);
        
        // 总教师数
        List<String> teachers = coursesDao.selectAllTeachers();
        int totalTeachers = teachers != null ? teachers.size() : 0;
        statistics.put("totalTeachers", totalTeachers);
        
        // 平均学分
        List<Courses> allCourses = coursesDao.selectAll();
        double totalCredits = 0.0;
        if (allCourses != null && !allCourses.isEmpty()) {
            for (Courses course : allCourses) {

                totalCredits += course.getCredit();
            }
            double averageCredits = totalCredits / allCourses.size();
            statistics.put("averageCredits", Math.round(averageCredits * 10.0) / 10.0);
        } else {
            statistics.put("averageCredits", 0.0);
        }
        
        // 本月新增课程数（简化计算，实际应该根据创建时间计算）
        int newCoursesThisMonth = totalCourses / 10; // 模拟数据
        statistics.put("newCoursesThisMonth", newCoursesThisMonth);
        
        return statistics;
    }
}