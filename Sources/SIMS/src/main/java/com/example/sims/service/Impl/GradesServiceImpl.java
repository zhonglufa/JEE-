package com.example.sims.service.Impl;

import com.example.sims.dao.GradesDao;
import com.example.sims.pojo.Grades;
import com.example.sims.service.GradesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 成绩信息服务实现类
 * 提供成绩信息的业务逻辑处理
 * 
 * @author SIMS Team
 * @version 1.0
 */
@Service
@Transactional
public class GradesServiceImpl implements GradesService {

    @Autowired
    private GradesDao gradesDao;

    /**
     * 获取所有成绩详细信息
     * 
     * @return 包含详细信息的成绩记录列表
     */
    @Override
    public List<Map<String, Object>> getAllGradesWithDetails() {
        return gradesDao.selectWithDetails();
    }

    /**
     * 根据成绩ID获取成绩信息
     * 
     * @param id 成绩记录ID
     * @return 成绩信息对象
     */
    @Override
    public Grades getGradeById(long id) {
        return gradesDao.selectById(id);
    }

    /**
     * 根据学生ID获取成绩信息
     * 
     * @param studentId 学生ID
     * @return 该学生的所有成绩记录
     */
    @Override
    public List<Grades> getGradesByStudentId(String studentId) {
        return gradesDao.selectByStudentId(studentId);
    }

    /**
     * 根据课程ID获取成绩信息
     * 
     * @param courseId 课程ID
     * @return 该课程的所有成绩记录
     */
    @Override
    public List<Grades> getGradesByCourseId(String courseId) {
        return gradesDao.selectByCourseId(courseId);
    }

    /**
     * 根据学生姓名搜索成绩信息
     * 
     * @param studentName 学生姓名
     * @return 包含详细信息的成绩记录列表
     */
    @Override
    public List<Map<String, Object>> getGradesWithDetailsByStudentName(String studentName) {
        return gradesDao.selectWithDetailsByStudentName(studentName);
    }

    /**
     * 根据课程名称搜索成绩信息
     * 
     * @param courseName 课程名称
     * @return 包含详细信息的成绩记录列表
     */
    @Override
    public List<Map<String, Object>> getGradesWithDetailsByCourseName(String courseName) {
        return gradesDao.selectWithDetailsByCourseName(courseName);
    }

    /**
     * 分页获取成绩详细信息
     * 
     * @param page 页码（从1开始）
     * @param size 每页大小
     * @return 包含详细信息的成绩记录列表
     */
    @Override
    public List<Map<String, Object>> getGradesWithDetailsByPage(int page, int size) {
        int offset = (page - 1) * size;
        return gradesDao.selectWithDetailsByPage(offset, size);
    }

    /**
     * 获取成绩记录总数
     * 
     * @return 成绩记录总数
     */
    @Override
    public int getGradeCount() {
        return gradesDao.countAll();
    }

    /**
     * 根据条件获取成绩记录数量
     * 
     * @param studentId 学生ID（可选）
     * @param courseId 课程ID（可选）
     * @return 匹配的成绩记录数量
     */
    @Override
    public int getGradeCountByCondition(String studentId, String courseId) {
        return gradesDao.countByCondition(studentId, courseId);
    }

    /**
     * 添加成绩信息
     * 
     * @param grade 成绩信息对象
     * @return 影响的行数
     */
    @Override
    public int addGrade(Grades grade) {
        // 检查学生和课程的成绩记录是否已存在
        if (gradesDao.existsByStudentAndCourse(grade.getStudentId(), grade.getCourseId())) {
            throw new RuntimeException("该学生在此课程中已有成绩记录");
        }
        
        // 检查成绩范围
        if (grade.getScore() != null) {
            double score = grade.getScoreAsDouble();
            if (score < 0 || score > 100) {
                throw new RuntimeException("成绩必须在0-100之间");
            }
        }
        
        return gradesDao.insert(grade);
    }

    /**
     * 更新成绩信息
     * 
     * @param grade 成绩信息对象
     * @return 影响的行数
     */
    @Override
    public int updateGrade(Grades grade) {
        // 检查成绩记录是否存在
        Grades existingGrade = gradesDao.selectById(grade.getId());
        if (existingGrade == null) {
            throw new RuntimeException("成绩记录不存在：" + grade.getId());
        }
        
        // 检查成绩范围
        if (grade.getScore() != null) {
            double score = grade.getScoreAsDouble();
            if (score < 0 || score > 100) {
                throw new RuntimeException("成绩必须在0-100之间");
            }
        }
        
        return gradesDao.update(grade);
    }

    /**
     * 删除成绩信息
     * 
     * @param id 成绩记录ID
     * @return 影响的行数
     */
    @Override
    public int deleteGrade(long id) {
        // 检查成绩记录是否存在
        Grades grade = gradesDao.selectById(id);
        if (grade == null) {
            throw new RuntimeException("成绩记录不存在：" + id);
        }
        
        return gradesDao.delete(id);
    }

    /**
     * 检查学生和课程的成绩记录是否已存在
     * 
     * @param studentId 学生ID
     * @param courseId 课程ID
     * @return 是否存在
     */
    @Override
    public boolean existsByStudentAndCourse(String studentId, String courseId) {
        return gradesDao.existsByStudentAndCourse(studentId, courseId);
    }

    /**
     * 获取成绩统计信息
     * 
     * @return 统计信息Map
     */
    @Override
    public Map<String, Object> getGradeStatistics() {
        Map<String, Object> statistics = new HashMap<>();
        
        // 获取数据库统计信息
        Map<String, Object> dbStats = gradesDao.getStatistics();
        
        if (dbStats != null) {
            // 总记录数
            Object totalRecords = dbStats.get("total_records");
            statistics.put("totalRecords", totalRecords != null ? totalRecords : 0);
            
            // 平均分
            Object averageScore = dbStats.get("average_score");
            if (averageScore != null) {
                double avgScore = ((Number) averageScore).doubleValue();
                statistics.put("averageScore", Math.round(avgScore * 10.0) / 10.0);
            } else {
                statistics.put("averageScore", 0.0);
            }
            
            // 最高分
            Object maxScore = dbStats.get("max_score");
            statistics.put("maxScore", maxScore != null ? maxScore : 0);
            
            // 最低分
            Object minScore = dbStats.get("min_score");
            statistics.put("minScore", minScore != null ? minScore : 0);
            
            // 参与学生数
            Object uniqueStudents = dbStats.get("unique_students");
            statistics.put("uniqueStudents", uniqueStudents != null ? uniqueStudents : 0);
            
            // 参与课程数
            Object uniqueCourses = dbStats.get("unique_courses");
            statistics.put("uniqueCourses", uniqueCourses != null ? uniqueCourses : 0);
        } else {
            // 如果数据库统计失败，使用默认值
            statistics.put("totalRecords", 0);
            statistics.put("averageScore", 0.0);
            statistics.put("maxScore", 0);
            statistics.put("minScore", 0);
            statistics.put("uniqueStudents", 0);
            statistics.put("uniqueCourses", 0);
        }
        
        // 成绩分布统计（简化计算）
        List<Grades> allGrades = gradesDao.selectAll();
        int excellentCount = 0; // 优秀 (90-100)
        int goodCount = 0;      // 良好 (80-89)
        int passCount = 0;      // 及格 (60-79)
        int failCount = 0;      // 不及格 (0-59)
        
        if (allGrades != null) {
            for (Grades grade : allGrades) {
                if (grade.getScore() != null) {
                    double score = grade.getScoreAsDouble();
                    if (score >= 90) {
                        excellentCount++;
                    } else if (score >= 80) {
                        goodCount++;
                    } else if (score >= 60) {
                        passCount++;
                    } else {
                        failCount++;
                    }
                }
            }
        }
        
        statistics.put("excellentCount", excellentCount);
        statistics.put("goodCount", goodCount);
        statistics.put("passCount", passCount);
        statistics.put("failCount", failCount);
        
        return statistics;
    }
}