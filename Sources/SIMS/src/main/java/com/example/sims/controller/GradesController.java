// GradesController.java
package com.example.sims.controller;

import com.example.sims.pojo.Courses;
import com.example.sims.pojo.Grades;
import com.example.sims.pojo.Students;
import com.example.sims.service.CoursesService;
import com.example.sims.service.GradesService;
import com.example.sims.service.StudentsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/grades")
public class GradesController {

    @Autowired
    private GradesService gradesService;

    @Autowired
    private StudentsService studentsService;

    @Autowired
    private CoursesService coursesService;

    @GetMapping
    public String listGrades(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(required = false) String studentName,
            @RequestParam(required = false) String courseName,
            @RequestParam(required = false) String studentId,
            @RequestParam(required = false) String courseId,
            Model model) {
        
        // 获取成绩列表（支持搜索和分页）
        List<Map<String, Object>> grades;
        int totalCount;
        
        if (studentName != null && !studentName.trim().isEmpty()) {
            // 按学生姓名搜索
            grades = gradesService.getGradesWithDetailsByStudentName(studentName.trim());
            totalCount = grades.size();
        } else if (courseName != null && !courseName.trim().isEmpty()) {
            // 按课程名称搜索
            grades = gradesService.getGradesWithDetailsByCourseName(courseName.trim());
            totalCount = grades.size();
        } else if (studentId != null && !studentId.trim().isEmpty()) {
            // 按学生ID搜索
            List<Grades> gradeList = gradesService.getGradesByStudentId(studentId.trim());
            grades = gradesService.getAllGradesWithDetails(); // 临时使用全部数据
            totalCount = gradeList.size();
        } else if (courseId != null && !courseId.trim().isEmpty()) {
            // 按课程ID搜索
            List<Grades> gradeList = gradesService.getGradesByCourseId(courseId.trim());
            grades = gradesService.getAllGradesWithDetails(); // 临时使用全部数据
            totalCount = gradeList.size();
        } else {
            // 分页查询
            grades = gradesService.getGradesWithDetailsByPage(page, size);
            totalCount = gradesService.getGradeCount();
        }
        
        // 计算分页信息
        int totalPages = (int) Math.ceil((double) totalCount / size);
        
        // 获取成绩统计信息
        Map<String, Object> statistics = gradesService.getGradeStatistics();
        
        // 添加数据到模型
        model.addAttribute("grades", grades);
        model.addAttribute("students", studentsService.getAllStudents());
        model.addAttribute("courses", coursesService.getAllCourses());
        model.addAttribute("grade", new Grades());
        
        // 分页信息
        model.addAttribute("currentPage", page);
        model.addAttribute("pageSize", size);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("totalPages", totalPages);
        
        // 搜索条件
        model.addAttribute("searchStudentName", studentName);
        model.addAttribute("searchCourseName", courseName);
        model.addAttribute("searchStudentId", studentId);
        model.addAttribute("searchCourseId", courseId);
        
        // 统计信息
        model.addAttribute("statistics", statistics);
        
        return "scoreInfoPage";
    }

    @GetMapping("/add")
    public String showAddForm(Model model) {
        model.addAttribute("grade", new Grades());
        // 需要添加学生和课程列表到model
        return "grades/form";
    }

    @PostMapping("/add")
    public String addGrade(@ModelAttribute Grades grade) {
        try {
            gradesService.addGrade(grade);
            return "redirect:/grades?success=add";
        } catch (Exception e) {
            return "redirect:/grades?error=" + e.getMessage();
        }
    }

    @PostMapping("/update")
    public String updateGrade(@ModelAttribute Grades grade) {
        try {
            gradesService.updateGrade(grade);
            return "redirect:/grades?success=update";
        } catch (Exception e) {
            return "redirect:/grades?error=" + e.getMessage();
        }
    }

    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable long id, Model model) {
        Grades grade = gradesService.getGradeById(id);
        model.addAttribute("grade", grade);
        // 需要添加学生和课程列表到model
        return "grades/form";
    }

    @GetMapping("/delete/{id}")
    public String deleteGrade(@PathVariable long id) {
        try {
            gradesService.deleteGrade(id);
            return "redirect:/grades?success=delete";
        } catch (Exception e) {
            return "redirect:/grades?error=" + e.getMessage();
        }
    }


}