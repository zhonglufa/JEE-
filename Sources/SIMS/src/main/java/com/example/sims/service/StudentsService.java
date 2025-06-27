package com.example.sims.service;

import com.example.sims.pojo.Students;

import java.util.List;
import java.util.Map;

/**
 * 学生信息服务接口
 * 定义学生信息相关的业务方法
 * 
 * @author SIMS Team
 * @version 1.0
 */
public interface StudentsService {

    /**
     * 获取所有学生信息
     * 
     * @return 学生信息列表
     */
    List<Students> getAllStudents();

    /**
     * 根据学生ID获取学生信息
     * 
     * @param id 学生ID
     * @return 学生信息对象
     */
    Students getStudentById(String id);

    /**
     * 根据姓名搜索学生信息
     * 
     * @param name 学生姓名
     * @return 匹配的学生信息列表
     */
    List<Students> getStudentsByName(String name);

    /**
     * 根据性别获取学生信息
     * 
     * @param gender 性别（M:男/F:女）
     * @return 匹配的学生信息列表
     */
    List<Students> getStudentsByGender(String gender);

    /**
     * 根据电话号码获取学生信息
     * 
     * @param phone 电话号码
     * @return 学生信息对象
     */
    Students getStudentByPhone(String phone);

    /**
     * 分页获取学生信息
     * 
     * @param page 页码（从1开始）
     * @param size 每页大小
     * @return 学生信息列表
     */
    List<Students> getStudentsByPage(int page, int size);

    /**
     * 获取学生总数
     * 
     * @return 学生总数
     */
    int getStudentCount();

    /**
     * 根据条件获取学生数量
     * 
     * @param name 姓名（可选）
     * @param gender 性别（可选）
     * @return 匹配的学生数量
     */
    int getStudentCountByCondition(String name, String gender);

    /**
     * 添加学生信息
     * 
     * @param student 学生信息对象
     * @return 影响的行数
     */
    int addStudent(Students student);

    /**
     * 更新学生信息
     * 
     * @param student 学生信息对象
     * @return 影响的行数
     */
    int updateStudent(Students student);

    /**
     * 删除学生信息
     * 
     * @param id 学生ID
     * @return 影响的行数
     */
    int deleteStudent(String id);

    /**
     * 检查学生ID是否存在
     * 
     * @param studentId 学生ID
     * @return 是否存在
     */
    boolean existsById(String studentId);

    /**
     * 检查电话号码是否存在
     * 
     * @param phone 电话号码
     * @return 是否存在
     */
    boolean existsByPhone(String phone);

    /**
     * 获取学生统计信息
     * 
     * @return 统计信息Map
     */
    Map<String, Object> getStudentStatistics();
}
