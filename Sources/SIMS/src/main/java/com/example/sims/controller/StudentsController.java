package com.example.sims.controller;

import com.example.sims.pojo.Students;
import com.example.sims.service.StudentsService;
import com.example.sims.service.CoursesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

/**
 * 学生信息控制器
 * 处理学生信息相关的HTTP请求
 * 
 * @author SIMS Team
 * @version 1.0
 */
@Controller
@RequestMapping("/students")
public class StudentsController {

    @Autowired
    private StudentsService studentsService;
    
    @Autowired
    private CoursesService coursesService;

    /**
     * 学生管理页面 - 支持分页和搜索
     * 
     * @param page 页码（可选，默认1）
     * @param size 每页大小（可选，默认10）
     * @param name 学生姓名搜索（可选）
     * @param gender 性别筛选（可选）
     * @param model 模型对象
     * @return 学生管理页面视图
     */
    @GetMapping
    public String listStudents(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(required = false) String name,
            @RequestParam(required = false) String gender,
            Model model) {
        
        // 获取学生列表（支持搜索和分页）
        List<Students> students;
        int totalCount;
        
        if (name != null && !name.trim().isEmpty()) {
            // 按姓名搜索
            students = studentsService.getStudentsByName(name.trim());
            totalCount = students.size();
        } else if (gender != null && !gender.trim().isEmpty()) {
            // 按性别筛选
            students = studentsService.getStudentsByGender(gender.trim());
            totalCount = students.size();
        } else {
            // 分页查询
            students = studentsService.getStudentsByPage(page, size);
            totalCount = studentsService.getStudentCount();
        }
        
        // 计算分页信息
        int totalPages = (int) Math.ceil((double) totalCount / size);
        
        // 获取学生统计信息
        Map<String, Object> statistics = studentsService.getStudentStatistics();
        
        // 添加数据到模型
        model.addAttribute("students", students);
        model.addAttribute("student", new Students()); // 用于添加表单
        model.addAttribute("courses", coursesService.getAllCourses()); // 用于统计显示
        
        // 分页信息
        model.addAttribute("currentPage", page);
        model.addAttribute("pageSize", size);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("totalPages", totalPages);
        
        // 搜索条件
        model.addAttribute("searchName", name);
        model.addAttribute("searchGender", gender);
        
        // 统计信息
        model.addAttribute("statistics", statistics);
        
        return "stuInfoPage";
    }

    /**
     * 添加学生信息
     * 
     * @param student 学生信息对象
     * @return 重定向到学生列表页面
     */
    @PostMapping("/add")
    public String addStudent(@ModelAttribute Students student) {
        try {
            studentsService.addStudent(student);
            return "redirect:/students?success=add";
        } catch (Exception e) {
            return "redirect:/students?error=" + e.getMessage();
        }
    }

    /**
     * 更新学生信息
     * 
     * @param student 学生信息对象
     * @return 重定向到学生列表页面
     */
    @PostMapping("/update")
    public String updateStudent(@ModelAttribute Students student) {
        try {
            studentsService.updateStudent(student);
            return "redirect:/students?success=update";
        } catch (Exception e) {
            return "redirect:/students?error=" + e.getMessage();
        }
    }

    /**
     * 删除学生信息
     * 
     * @param id 学生ID
     * @return 重定向到学生列表页面
     */
    @GetMapping("/delete/{id}")
    public String deleteStudent(@PathVariable("id") String id) {
        try {
            studentsService.deleteStudent(id);
            return "redirect:/students?success=delete";
        } catch (Exception e) {
            return "redirect:/students?error=" + e.getMessage();
        }
    }

    /**
     * 获取学生统计信息
     * 
     * @return 统计信息JSON
     */
    @GetMapping("/statistics")
    @ResponseBody
    public Map<String, Object> getStatistics() {
        return studentsService.getStudentStatistics();
    }


    /**
     * 根据姓名搜索学生
     * 
     * @param name 学生姓名
     * @return 匹配的学生列表
     */
    @GetMapping("/search")
    @ResponseBody
    public List<Students> searchStudents(@RequestParam String name) {
        return studentsService.getStudentsByName(name);
    }
}