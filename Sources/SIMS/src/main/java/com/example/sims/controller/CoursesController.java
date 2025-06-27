// CoursesController.java
package com.example.sims.controller;

import com.example.sims.pojo.Courses;
import com.example.sims.service.CoursesService;
import com.example.sims.service.StudentsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/courses")
public class CoursesController {

    @Autowired
    private CoursesService coursesService;
    
    @Autowired
    private StudentsService studentsService;

    @GetMapping
    public String listCourses(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(required = false) String courseName,
            @RequestParam(required = false) String teacher,
            @RequestParam(required = false) String courseType,
            @RequestParam(required = false) String college,
            @RequestParam(required = false) String status,
            Model model) {
        
        // 获取课程列表（支持搜索和分页）
        List<Courses> courses;
        int totalCount;
        
        if (courseName != null && !courseName.trim().isEmpty()) {
            // 按课程名称搜索
            courses = coursesService.getCoursesByName(courseName.trim());
            totalCount = courses.size();
        } else if (teacher != null && !teacher.trim().isEmpty()) {
            // 按教师搜索
            courses = coursesService.getCoursesByTeacher(teacher.trim());
            totalCount = courses.size();
        } else {
            // 分页查询
            courses = coursesService.getCoursesByPage(page, size);
            totalCount = coursesService.getCourseCount();
        }
        
        // 计算分页信息
        int totalPages = (int) Math.ceil((double) totalCount / size);
        
        // 获取课程统计信息
        Map<String, Object> statistics = coursesService.getCourseStatistics();
        
        // 添加数据到模型
        model.addAttribute("courses", courses);
        model.addAttribute("course", new Courses()); // 用于添加表单
        model.addAttribute("students", studentsService.getAllStudents()); // 用于统计显示
        
        // 分页信息
        model.addAttribute("currentPage", page);
        model.addAttribute("pageSize", size);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("totalPages", totalPages);

        // 搜索条件
        model.addAttribute("searchCourseName", courseName);
        model.addAttribute("searchTeacher", teacher);
        model.addAttribute("searchCourseType", courseType);
        model.addAttribute("searchCollege", college);
        model.addAttribute("searchStatus", status);
        
        // 统计信息
        model.addAttribute("statistics", statistics);
        
        return "courseInfoPage";
    }

    @PostMapping("/add")
    public String addCourse(@ModelAttribute Courses course) {
        try {
            coursesService.addCourse(course);
            return "redirect:/courses?success=add";
        } catch (Exception e) {
            return "redirect:/courses?error=" + e.getMessage();
        }
    }

    @PostMapping("/update")
    public String updateCourse(@ModelAttribute Courses course) {
        try {
            coursesService.updateCourse(course);
            return "redirect:/courses?success=update";
        } catch (Exception e) {
            return "redirect:/courses?error=" + e.getMessage();
        }
    }

    @GetMapping("/delete/{id}")
    public String deleteCourse(@PathVariable String id) {
        try {
            coursesService.deleteCourse(id);
            return "redirect:/courses?success=delete";
        } catch (Exception e) {
            return "redirect:/courses?error=" + e.getMessage();
        }
    }

    /**
     * 获取课程统计信息
     * 
     * @return 统计信息JSON
     */
    @GetMapping("/statistics")
    @ResponseBody
    public Map<String, Object> getStatistics() {
        return coursesService.getCourseStatistics();
    }

    /**
     * 检查课程ID是否存在
     * 
     * @param courseId 课程ID
     * @return 是否存在
     */
    @GetMapping("/check/{courseId}")
    @ResponseBody
    public boolean checkCourseId(@PathVariable String courseId) {
        return coursesService.existsById(courseId);
    }

    /**
     * 根据名称搜索课程
     * 
     * @param courseName 课程名称
     * @return 匹配的课程列表
     */
    @GetMapping("/search")
    @ResponseBody
    public List<Courses> searchCourses(@RequestParam String courseName) {
        return coursesService.getCoursesByName(courseName);
    }
}