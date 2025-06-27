-- =====================================================
-- 学生信息管理系统数据库表结构脚本
-- 作者: SIMS Team
-- 版本: 1.0
-- 描述: 创建系统所需的数据库表结构
-- =====================================================

-- 创建数据库（如果不存在）
-- CREATE DATABASE IF NOT EXISTS sims_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
-- USE sims_db;

-- =====================================================
-- 1. 用户信息表
-- =====================================================
CREATE TABLE IF NOT EXISTS user (
    id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '用户ID，自增主键',
    username VARCHAR(50) NOT NULL UNIQUE COMMENT '用户名，唯一',
    email VARCHAR(100) NOT NULL UNIQUE COMMENT '邮箱地址，唯一',
    password VARCHAR(255) NOT NULL COMMENT '密码，加密存储',
    real_name VARCHAR(50) NOT NULL COMMENT '真实姓名',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    INDEX idx_username (username),
    INDEX idx_email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户信息表';

-- =====================================================
-- 2. 学生信息表
-- =====================================================
CREATE TABLE IF NOT EXISTS students (
    id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '学生ID，自增主键',
    student_id VARCHAR(20) NOT NULL UNIQUE COMMENT '学号，唯一',
    name VARCHAR(50) NOT NULL COMMENT '学生姓名',
    gender CHAR(1) NOT NULL COMMENT '性别：M-男，F-女',
    birth_date DATE COMMENT '出生日期',
    phone VARCHAR(20) COMMENT '联系电话',
    address TEXT COMMENT '家庭住址',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    INDEX idx_student_id (student_id),
    INDEX idx_name (name),
    INDEX idx_gender (gender)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='学生信息表';

-- =====================================================
-- 3. 课程信息表
-- =====================================================
CREATE TABLE IF NOT EXISTS courses (
    id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '课程ID，自增主键',
    course_id VARCHAR(20) NOT NULL UNIQUE COMMENT '课程编号，唯一',
    course_name VARCHAR(100) NOT NULL COMMENT '课程名称',
    course_type VARCHAR(20) NOT NULL COMMENT '课程类型（如: 专业必修/选修）',
    credit DECIMAL(3,1) NOT NULL COMMENT '学分',
    teacher VARCHAR(50) NOT NULL COMMENT '任课教师',
    college VARCHAR(30) NOT NULL COMMENT '开课学院',
    STATUS VARCHAR(10) NOT NULL COMMENT '开课状态（如: 已开通/未开通）',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    INDEX idx_course_id (course_id),
    INDEX idx_course_name (course_name),
    INDEX idx_teacher (teacher)
    ) ENGINE=INNODB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='课程信息表';


-- =====================================================
-- 4. 成绩信息表
-- =====================================================
CREATE TABLE IF NOT EXISTS grades (
    id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '成绩ID，自增主键',
    student_id VARCHAR(20) NOT NULL COMMENT '学生ID，关联students表',
    course_id VARCHAR(20) NOT NULL COMMENT '课程ID，关联courses表',
    score DECIMAL(5,2) COMMENT '成绩分数',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    UNIQUE KEY uk_student_course (student_id, course_id) COMMENT '学生和课程组合唯一约束',
    INDEX idx_student_id (student_id),
    INDEX idx_course_id (course_id),
    INDEX idx_score (score),
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (course_id) REFERENCES courses(course_id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='成绩信息表';

-- =====================================================
-- 5. 系统日志表（可选）
-- =====================================================
CREATE TABLE IF NOT EXISTS system_logs (
    id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '日志ID，自增主键',
    user_id BIGINT COMMENT '操作用户ID',
    username VARCHAR(50) COMMENT '操作用户名',
    action VARCHAR(100) NOT NULL COMMENT '操作类型',
    description TEXT COMMENT '操作描述',
    ip_address VARCHAR(45) COMMENT 'IP地址',
    user_agent TEXT COMMENT '用户代理',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    INDEX idx_user_id (user_id),
    INDEX idx_username (username),
    INDEX idx_action (action),
    INDEX idx_created_at (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统操作日志表';

-- =====================================================
-- 6. 数据备份表（可选）
-- =====================================================
CREATE TABLE IF NOT EXISTS data_backups (
    id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '备份ID，自增主键',
    backup_name VARCHAR(100) NOT NULL COMMENT '备份名称',
    backup_type ENUM('FULL', 'INCREMENTAL') NOT NULL COMMENT '备份类型：完整/增量',
    file_path VARCHAR(500) COMMENT '备份文件路径',
    file_size BIGINT COMMENT '文件大小（字节）',
    status ENUM('PENDING', 'IN_PROGRESS', 'COMPLETED', 'FAILED') NOT NULL COMMENT '备份状态',
    created_by BIGINT COMMENT '创建用户ID',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    completed_at TIMESTAMP NULL COMMENT '完成时间',
    INDEX idx_backup_name (backup_name),
    INDEX idx_status (status),
    INDEX idx_created_at (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='数据备份记录表';

-- =====================================================
-- 7. 创建视图（可选，用于简化查询）
-- =====================================================

-- 学生成绩详情视图
CREATE OR REPLACE VIEW v_student_grades AS
SELECT 
    g.id,
    g.student_id,
    s.name as student_name,
    s.gender as student_gender,
    g.course_id,
    c.course_name,
    c.credit,
    c.teacher,
    g.score,
    g.created_at,
    g.updated_at
FROM grades g
JOIN students s ON g.student_id = s.student_id
JOIN courses c ON g.course_id = c.course_id;

-- 课程统计视图
CREATE OR REPLACE VIEW v_course_statistics AS
SELECT 
    c.course_id,
    c.course_name,
    c.credit,
    c.teacher,
    COUNT(g.student_id) as enrolled_students,
    AVG(g.score) as average_score,
    MAX(g.score) as max_score,
    MIN(g.score) as min_score,
    COUNT(CASE WHEN g.score >= 90 THEN 1 END) as excellent_count,
    COUNT(CASE WHEN g.score >= 80 AND g.score < 90 THEN 1 END) as good_count,
    COUNT(CASE WHEN g.score >= 60 AND g.score < 80 THEN 1 END) as pass_count,
    COUNT(CASE WHEN g.score < 60 THEN 1 END) as fail_count
FROM courses c
LEFT JOIN grades g ON c.course_id = g.course_id
GROUP BY c.course_id, c.course_name, c.credit, c.teacher;

-- 学生统计视图
CREATE OR REPLACE VIEW v_student_statistics AS
SELECT 
    s.student_id,
    s.name as student_name,
    s.gender,
    COUNT(g.course_id) as enrolled_courses,
    AVG(g.score) as average_score,
    MAX(g.score) as max_score,
    MIN(g.score) as min_score,
    SUM(c.credit) as total_credits,
    COUNT(CASE WHEN g.score >= 90 THEN 1 END) as excellent_count,
    COUNT(CASE WHEN g.score >= 80 AND g.score < 90 THEN 1 END) as good_count,
    COUNT(CASE WHEN g.score >= 60 AND g.score < 80 THEN 1 END) as pass_count,
    COUNT(CASE WHEN g.score < 60 THEN 1 END) as fail_count
FROM students s
LEFT JOIN grades g ON s.student_id = g.student_id
LEFT JOIN courses c ON g.course_id = c.course_id
GROUP BY s.student_id, s.name, s.gender;

-- =====================================================
-- 8. 创建存储过程（可选，用于复杂业务逻辑）
-- =====================================================

-- 获取学生成绩单存储过程
DELIMITER //
CREATE PROCEDURE GetStudentTranscript(IN p_student_id VARCHAR(20))
BEGIN
    SELECT 
        s.student_id,
        s.name as student_name,
        s.gender,
        c.course_id,
        c.course_name,
        c.credit,
        c.teacher,
        g.score,
        CASE 
            WHEN g.score >= 90 THEN '优秀'
            WHEN g.score >= 80 THEN '良好'
            WHEN g.score >= 70 THEN '中等'
            WHEN g.score >= 60 THEN '及格'
            ELSE '不及格'
        END as grade_level
    FROM students s
    LEFT JOIN grades g ON s.student_id = g.student_id
    LEFT JOIN courses c ON g.course_id = c.course_id
    WHERE s.student_id = p_student_id
    ORDER BY c.course_id;
END //
DELIMITER ;

-- 获取课程成绩分布存储过程
DELIMITER //
CREATE PROCEDURE GetCourseGradeDistribution(IN p_course_id VARCHAR(20))
BEGIN
    SELECT 
        c.course_id,
        c.course_name,
        c.teacher,
        COUNT(g.student_id) as total_students,
        AVG(g.score) as average_score,
        COUNT(CASE WHEN g.score >= 90 THEN 1 END) as excellent_count,
        COUNT(CASE WHEN g.score >= 80 AND g.score < 90 THEN 1 END) as good_count,
        COUNT(CASE WHEN g.score >= 70 AND g.score < 80 THEN 1 END) as medium_count,
        COUNT(CASE WHEN g.score >= 60 AND g.score < 70 THEN 1 END) as pass_count,
        COUNT(CASE WHEN g.score < 60 THEN 1 END) as fail_count
    FROM courses c
    LEFT JOIN grades g ON c.course_id = g.course_id
    WHERE c.course_id = p_course_id
    GROUP BY c.course_id, c.course_name, c.teacher;
END //
DELIMITER ;

-- =====================================================
-- 9. 创建触发器（可选，用于数据完整性）
-- =====================================================

-- 成绩插入前检查触发器
DELIMITER //
CREATE TRIGGER before_grade_insert
BEFORE INSERT ON grades
FOR EACH ROW
BEGIN
    -- 检查成绩范围
    IF NEW.score IS NOT NULL AND (NEW.score < 0 OR NEW.score > 100) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '成绩必须在0-100之间';
    END IF;
    
    -- 检查学生是否存在
    IF NOT EXISTS (SELECT 1 FROM students WHERE student_id = NEW.student_id) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '学生不存在';
    END IF;
    
    -- 检查课程是否存在
    IF NOT EXISTS (SELECT 1 FROM courses WHERE course_id = NEW.course_id) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '课程不存在';
    END IF;
END //
DELIMITER ;

-- 成绩更新前检查触发器
DELIMITER //
CREATE TRIGGER before_grade_update
BEFORE UPDATE ON grades
FOR EACH ROW
BEGIN
    -- 检查成绩范围
    IF NEW.score IS NOT NULL AND (NEW.score < 0 OR NEW.score > 100) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '成绩必须在0-100之间';
    END IF;
END //
DELIMITER ;

-- =====================================================
-- 10. 表结构验证查询
-- =====================================================

-- 显示所有表
SHOW TABLES;

-- 显示表结构
DESCRIBE user;
DESCRIBE students;
DESCRIBE courses;
DESCRIBE grades;

-- 显示视图
SHOW FULL TABLES WHERE Table_type = 'VIEW';

-- 显示存储过程
SHOW PROCEDURE STATUS WHERE Db = DATABASE();

-- 显示触发器
SHOW TRIGGERS;

-- =====================================================
-- 11. 表结构说明
-- =====================================================
/*
数据库表结构说明：

1. user表：用户信息表
   - 存储系统用户信息
   - 支持用户名和邮箱唯一性约束
   - 密码使用加密存储

2. students表：学生信息表
   - 存储学生基本信息
   - 学号唯一性约束
   - 支持性别、出生日期等详细信息

3. courses表：课程信息表
   - 存储课程基本信息
   - 课程编号唯一性约束
   - 包含学分和任课教师信息

4. grades表：成绩信息表
   - 存储学生成绩信息
   - 学生和课程组合唯一性约束
   - 外键关联确保数据完整性

5. system_logs表：系统日志表（可选）
   - 记录系统操作日志
   - 支持审计和问题追踪

6. data_backups表：数据备份表（可选）
   - 记录数据备份信息
   - 支持备份管理

视图说明：
- v_student_grades：学生成绩详情视图
- v_course_statistics：课程统计视图
- v_student_statistics：学生统计视图

存储过程说明：
- GetStudentTranscript：获取学生成绩单
- GetCourseGradeDistribution：获取课程成绩分布

触发器说明：
- before_grade_insert：成绩插入前检查
- before_grade_update：成绩更新前检查

使用说明：
1. 先执行此表结构脚本
2. 再执行测试数据脚本
3. 确保数据库字符集为utf8mb4
4. 根据需要启用或禁用可选功能
*/ 