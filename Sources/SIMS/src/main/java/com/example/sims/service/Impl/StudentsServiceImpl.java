package com.example.sims.service.Impl;

import com.example.sims.dao.StudentsDao;
import com.example.sims.pojo.Students;
import com.example.sims.service.StudentsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 学生信息服务实现类
 * 提供学生信息的业务逻辑处理
 * 
 * @author SIMS Team
 * @version 1.0
 */
@Service
@Transactional
public class StudentsServiceImpl implements StudentsService {

    @Autowired
    private StudentsDao studentsDao;

    /**
     * 获取所有学生信息
     * 
     * @return 学生信息列表
     */
    @Override
    public List<Students> getAllStudents() {
        return studentsDao.selectAll();
    }

    /**
     * 根据学生ID获取学生信息
     * 
     * @param id 学生ID
     * @return 学生信息对象
     */
    @Override
    public Students getStudentById(String id) {
        return studentsDao.selectById(id);
    }

    /**
     * 根据姓名搜索学生信息
     * 
     * @param name 学生姓名
     * @return 匹配的学生信息列表
     */
    @Override
    public List<Students> getStudentsByName(String name) {
        return studentsDao.selectByName(name);
    }

    /**
     * 根据性别获取学生信息
     * 
     * @param gender 性别（M:男/F:女）
     * @return 匹配的学生信息列表
     */
    @Override
    public List<Students> getStudentsByGender(String gender) {
        return studentsDao.selectByGender(gender);
    }

    /**
     * 根据电话号码获取学生信息
     * 
     * @param phone 电话号码
     * @return 学生信息对象
     */
    @Override
    public Students getStudentByPhone(String phone) {
        return studentsDao.selectByPhone(phone);
    }

    /**
     * 分页获取学生信息
     * 
     * @param page 页码（从1开始）
     * @param size 每页大小
     * @return 学生信息列表
     */
    @Override
    public List<Students> getStudentsByPage(int page, int size) {
        int offset = (page - 1) * size;
        return studentsDao.selectByPage(offset, size);
    }

    /**
     * 获取学生总数
     * 
     * @return 学生总数
     */
    @Override
    public int getStudentCount() {
        return studentsDao.countAll();
    }

    /**
     * 根据条件获取学生数量
     * 
     * @param name 姓名（可选）
     * @param gender 性别（可选）
     * @return 匹配的学生数量
     */
    @Override
    public int getStudentCountByCondition(String name, String gender) {
        return studentsDao.countByCondition(name, gender);
    }

    /**
     * 添加学生信息
     * 
     * @param student 学生信息对象
     * @return 影响的行数
     */
    @Override
    public int addStudent(Students student) {
        // 检查学生ID是否已存在
        if (studentsDao.existsById(student.getStudentId())) {
            throw new RuntimeException("学生ID已存在：" + student.getStudentId());
        }
        
        // 检查电话号码是否已存在
        if (student.getPhone() != null && !student.getPhone().trim().isEmpty() && 
            studentsDao.existsByPhone(student.getPhone())) {
            throw new RuntimeException("电话号码已存在：" + student.getPhone());
        }
        
        return studentsDao.insert(student);
    }

    /**
     * 更新学生信息
     * 
     * @param student 学生信息对象
     * @return 影响的行数
     */
    @Override
    public int updateStudent(Students student) {
        // 检查学生是否存在
        Students existingStudent = studentsDao.selectById(student.getStudentId());
        if (existingStudent == null) {
            throw new RuntimeException("学生不存在：" + student.getStudentId());
        }
        
        // 检查电话号码是否被其他学生使用
        if (student.getPhone() != null && !student.getPhone().trim().isEmpty()) {
            Students studentWithPhone = studentsDao.selectByPhone(student.getPhone());
            if (studentWithPhone != null && !studentWithPhone.getStudentId().equals(student.getStudentId())) {
                throw new RuntimeException("电话号码已被其他学生使用：" + student.getPhone());
            }
        }
        
        return studentsDao.update(student);
    }

    /**
     * 删除学生信息
     * 
     * @param id 学生ID
     * @return 影响的行数
     */
    @Override
    public int deleteStudent(String id) {
        // 检查学生是否存在
        Students student = studentsDao.selectById(id);
        if (student == null) {
            throw new RuntimeException("学生不存在：" + id);
        }
        
        return studentsDao.delete(id);
    }

    /**
     * 检查学生ID是否存在
     * 
     * @param studentId 学生ID
     * @return 是否存在
     */
    @Override
    public boolean existsById(String studentId) {
        return studentsDao.existsById(studentId);
    }

    /**
     * 检查电话号码是否存在
     * 
     * @param phone 电话号码
     * @return 是否存在
     */
    @Override
    public boolean existsByPhone(String phone) {
        return studentsDao.existsByPhone(phone);
    }

    /**
     * 获取学生统计信息
     * 
     * @return 统计信息Map
     */
    @Override
    public Map<String, Object> getStudentStatistics() {
        Map<String, Object> statistics = new HashMap<>();
        
        // 总学生数
        int totalStudents = studentsDao.countAll();
        statistics.put("totalStudents", totalStudents);
        
        // 男学生数
        int maleStudents = studentsDao.countByCondition(null, "M");
        statistics.put("maleStudents", maleStudents);
        
        // 女学生数
        int femaleStudents = studentsDao.countByCondition(null, "F");
        statistics.put("femaleStudents", femaleStudents);
        
        // 本月新增学生数（简化计算，实际应该根据created_at字段计算）
        int newStudentsThisMonth = totalStudents / 10; // 模拟数据
        statistics.put("newStudentsThisMonth", newStudentsThisMonth);
        
        return statistics;
    }
}
