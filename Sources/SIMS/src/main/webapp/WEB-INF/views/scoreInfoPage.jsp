<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>学生信息管理系统 - 成绩管理</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        :root {
            --primary-color: #3498db;
            --secondary-color: #2c3e50;
            --accent-color: #1abc9c;
            --light-color: #ecf0f1;
            --dark-color: #34495e;
            --danger-color: #e74c3c;
            --warning-color: #f39c12;
            --success-color: #27ae60;
            --purple-color: #9b59b6;
        }

        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            height: 100vh;
            overflow-x: hidden;
        }

        /* 侧边栏样式 */
        .sidebar {
            background: linear-gradient(180deg, var(--secondary-color), var(--dark-color));
            color: white;
            min-height: 100vh;
            box-shadow: 3px 0 10px rgba(0,0,0,0.1);
            position: fixed;
            z-index: 100;
            transition: transform 0.3s ease;
        }

        .sidebar .nav-link {
            color: rgba(255,255,255,0.8);
            border-left: 3px solid transparent;
            padding: 12px 20px;
            margin: 5px 0;
            transition: all 0.3s;
        }

        .sidebar .nav-link:hover, .sidebar .nav-link.active {
            color: white;
            background: rgba(255,255,255,0.1);
            border-left: 3px solid var(--accent-color);
        }

        .sidebar .nav-link i {
            width: 25px;
            text-align: center;
            margin-right: 10px;
        }

        .user-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid var(--accent-color);
        }

        /* 主内容区 */
        .main-content {
            margin-left: 250px;
            padding: 20px;
            transition: margin-left 0.3s;
        }

        /* 头部区域 */
        .header {
            background: white;
            padding: 15px 20px;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.05);
            margin-bottom: 25px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        /* 卡片设计 */
        .card {
            border-radius: 12px;
            border: none;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
            margin-bottom: 25px;
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.12);
        }

        .card-header {
            background: linear-gradient(90deg, var(--success-color), #2ecc71);
            color: white;
            border-radius: 12px 12px 0 0 !important;
            padding: 15px 20px;
            font-weight: 600;
            border: none;
        }

        /* 按钮样式 */
        .btn-primary {
            background: linear-gradient(90deg, var(--success-color), #2ecc71);
            border: none;
            border-radius: 8px;
            padding: 8px 20px;
            font-weight: 500;
            transition: all 0.3s;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(39, 174, 96, 0.4);
        }

        .btn-outline-success {
            color: var(--success-color);
            border-color: var(--success-color);
        }

        .btn-outline-success:hover {
            background-color: var(--success-color);
            color: white;
        }

        /* 表格样式 */
        .table-container {
            background: white;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
            overflow: hidden;
        }

        .table thead {
            background: linear-gradient(90deg, var(--success-color), #2ecc71);
            color: white;
        }

        .table th {
            border: none;
            padding: 15px 20px;
            font-weight: 500;
        }

        .table td {
            padding: 12px 20px;
            vertical-align: middle;
            border-top: 1px solid #eee;
        }

        .table tbody tr {
            transition: background-color 0.2s;
        }

        .table tbody tr:hover {
            background-color: rgba(46, 204, 113, 0.05);
        }

        /* 操作按钮 */
        .action-btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 35px;
            height: 35px;
            border-radius: 8px;
            margin: 0 3px;
            transition: all 0.2s;
        }

        .action-btn:hover {
            transform: scale(1.1);
        }

        /* 搜索框 */
        .search-box {
            position: relative;
        }

        .search-box input {
            border-radius: 50px;
            padding-left: 45px;
        }

        .search-box i {
            position: absolute;
            left: 20px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--success-color);
        }

        /* 表单元素 */
        .form-label {
            font-weight: 500;
            color: var(--dark-color);
            margin-bottom: 8px;
        }

        .form-control, .form-select {
            border-radius: 8px;
            padding: 10px 15px;
            border: 1px solid #ddd;
            transition: all 0.3s;
        }

        .form-control:focus, .form-select:focus {
            border-color: var(--success-color);
            box-shadow: 0 0 0 3px rgba(46, 204, 113, 0.2);
        }

        /* 统计卡片 */
        .stats-card {
            text-align: center;
            padding: 20px;
            border-radius: 12px;
            background: white;
            box-shadow: 0 4px 6px rgba(0,0,0,0.05);
        }

        .stats-card i {
            font-size: 2.5rem;
            margin-bottom: 15px;
            background: linear-gradient(45deg, var(--success-color), #2ecc71);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .stats-card .number {
            font-size: 1.8rem;
            font-weight: 700;
            margin-bottom: 5px;
            color: var(--dark-color);
        }

        .stats-card .label {
            color: #777;
            font-size: 0.9rem;
        }

        /* 分页 */
        .pagination .page-link {
            border-radius: 8px;
            margin: 0 3px;
            border: none;
            color: var(--success-color);
        }

        .pagination .page-item.active .page-link {
            background: linear-gradient(90deg, var(--success-color), #2ecc71);
            border: none;
            color: white;
        }

        /* 成绩单元格 */
        .grade-cell {
            font-weight: 600;
            text-align: center;
        }

        .grade-A {
            color: #27ae60;
            background-color: rgba(39, 174, 96, 0.1);
            border-radius: 20px;
            padding: 3px 10px;
        }

        .grade-B {
            color: #f39c12;
            background-color: rgba(243, 156, 18, 0.1);
            border-radius: 20px;
            padding: 3px 10px;
        }

        .grade-C {
            color: #e74c3c;
            background-color: rgba(231, 76, 60, 0.1);
            border-radius: 20px;
            padding: 3px 10px;
        }

        /* 图表容器 */
        .chart-container {
            height: 300px;
            background: white;
            border-radius: 12px;
            padding: 20px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.05);
        }

        .score-trend {
            height: 250px;
            width: 100%;
        }

        .student-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid var(--accent-color);
        }

        /* 分析卡片 */
        .analysis-card {
            background: white;
            border-radius: 12px;
            padding: 20px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.05);
            margin-bottom: 20px;
        }

        .analysis-card h5 {
            color: var(--success-color);
            border-bottom: 2px solid var(--accent-color);
            padding-bottom: 10px;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
        }

        .analysis-card h5 i {
            margin-right: 10px;
        }

        /* 移动端菜单按钮 */
        .mobile-menu-btn {
            display: none;
            background: var(--success-color);
            color: white;
            border: none;
            width: 40px;
            height: 40px;
            border-radius: 8px;
            position: fixed;
            top: 15px;
            left: 15px;
            z-index: 101;
        }

        /* 响应式设计 */
        @media (max-width: 992px) {
            .sidebar {
                width: 70px;
                text-align: center;
            }

            .sidebar .nav-link span {
                display: none;
            }

            .sidebar .nav-link i {
                margin-right: 0;
                font-size: 1.2rem;
            }

            .main-content {
                margin-left: 70px;
            }
        }

        @media (max-width: 768px) {
            .main-content {
                margin-left: 0;
                padding: 15px;
            }

            .sidebar {
                transform: translateX(-100%);
            }

            .sidebar.active {
                transform: translateX(0);
            }

            .mobile-menu-btn {
                display: block;
            }

            .header {
                flex-direction: column;
                align-items: flex-start;
            }

            .header > div:last-child {
                margin-top: 15px;
                width: 100%;
            }

            .stats-card .number {
                font-size: 1.5rem;
            }

            .table-responsive {
                border: none;
            }

            .analysis-card {
                margin-bottom: 15px;
            }
        }

        /* 模态框样式 */
        .modal-header {
            background: linear-gradient(90deg, var(--success-color), #2ecc71);
            color: white;
            border-radius: 12px 12px 0 0;
        }

        .modal-title i {
            margin-right: 10px;
        }

        /* 成绩趋势标签 */
        .trend-up {
            color: #27ae60;
            font-weight: bold;
        }

        .trend-down {
            color: #e74c3c;
            font-weight: bold;
        }

        /* 新增：成绩对比标签 */
        .score-comparison {
            display: flex;
            justify-content: space-between;
            margin-top: 5px;
            font-size: 0.85rem;
        }

        .score-improvement {
            color: #27ae60;
        }

        .score-decline {
            color: #e74c3c;
        }

        /* 新增：成绩操作按钮组 */
        .score-actions {
            display: flex;
            gap: 8px;
        }

        /* 分页选中效果 */
        .pagination .page-item.active .page-link {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
            color: white;
        }
        
        .pagination .page-item .page-link:hover {
            background-color: var(--accent-color);
            border-color: var(--accent-color);
            color: white;
        }
        
        /* 搜索表单样式 */
        .search-form {
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        
        /* 统计卡片样式 */
        .stats-card {
            transition: transform 0.3s ease;
        }
        
        .stats-card:hover {
            transform: translateY(-5px);
        }
        
        /* 表格行悬停效果 */
        .table tbody tr:hover {
            background-color: rgba(0,123,255,0.1);
        }
        
        /* 操作按钮样式 */
        .action-btn {
            margin: 0 2px;
            transition: all 0.3s ease;
        }
        
        .action-btn:hover {
            transform: scale(1.1);
        }
        
        /* 成绩等级样式 */
        .score-excellent {
            color: #28a745;
            font-weight: bold;
        }
        
        .score-good {
            color: #17a2b8;
            font-weight: bold;
        }
        
        .score-pass {
            color: #ffc107;
            font-weight: bold;
        }
        
        .score-fail {
            color: #dc3545;
            font-weight: bold;
        }
    </style>
</head>
<body>
<!-- 移动端菜单按钮 -->
<button class="mobile-menu-btn" id="mobileMenuBtn">
    <i class="fas fa-bars"></i>
</button>

<!-- 侧边导航栏 -->
<div class="sidebar" id="sidebar">
    <div class="d-flex flex-column p-3">
        <div class="text-center mb-4 mt-3">
            <h4><i class="fas fa-graduation-cap me-2"></i> <span class="d-none d-lg-inline">学生管理系统</span></h4>
        </div>
        <ul class="nav flex-column">
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/home">
                    <i class="fas fa-home"></i>
                    <span>系统首页</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/students">
                    <i class="fas fa-user-graduate"></i>
                    <span>学生管理</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/courses">
                    <i class="fas fa-book-open"></i>
                    <span>课程管理</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link active" href="${pageContext.request.contextPath}/grades">
                    <i class="fas fa-chart-bar"></i>
                    <span>成绩管理</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#">
                    <i class="fas fa-chart-pie"></i>
                    <span>统计分析</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#">
                    <i class="fas fa-cog"></i>
                    <span>系统设置</span>
                </a>
            </li>
        </ul>
        <div class="mt-auto">
            <div class="d-flex align-items-center p-3">
                <img src="https://randomuser.me/api/portraits/men/41.jpg" class="user-avatar me-3">
                <div class="d-none d-lg-block">
                    <div class="fw-bold">${sessionScope.currentUser.realName.substring(0, 1)}老师</div>
                    <div class="small">管理员</div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- 主内容区 -->
<div class="main-content" id="mainContent">
    <!-- 消息提示区域 -->
    <c:if test="${param.success != null}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <i class="fas fa-check-circle me-2"></i>
            <c:choose>
                <c:when test="${param.success == 'add'}">成绩添加成功！</c:when>
                <c:when test="${param.success == 'update'}">成绩更新成功！</c:when>
                <c:when test="${param.success == 'delete'}">成绩删除成功！</c:when>
                <c:otherwise>操作成功！</c:otherwise>
            </c:choose>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    <c:if test="${param.error != null}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <i class="fas fa-exclamation-circle me-2"></i>
            操作失败：${param.error}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    
    <div class="header">
        <div>
            <h4 class="mb-0"><i class="fas fa-chart-bar me-2"></i>成绩信息管理</h4>
            <nav aria-label="breadcrumb" class="d-inline-block mt-1">
                <ol class="breadcrumb bg-transparent p-0 m-0">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home">首页</a></li>
                    <li class="breadcrumb-item active" aria-current="page">成绩管理</li>
                </ol>
            </nav>
        </div>
        <div class="d-flex align-items-center">
            <div class="search-box me-3">
                <i class="fas fa-search"></i>
                <input type="text" class="form-control" placeholder="搜索学生或课程...">
            </div>
            <div class="dropdown">
                <button class="btn btn-light dropdown-toggle" type="button" data-bs-toggle="dropdown">
                    <i class="fas fa-cog"></i> 更多操作
                </button>
                <ul class="dropdown-menu dropdown-menu-end">
                    <li><a class="dropdown-item" href="#"><i class="fas fa-download me-2"></i>导出成绩单</a></li>
                    <li><a class="dropdown-item" href="#"><i class="fas fa-print me-2"></i>打印成绩单</a></li>
                    <li><hr class="dropdown-divider"></li>
                    <li><a class="dropdown-item" href="#"><i class="fas fa-sync-alt me-2"></i>更新成绩</a></li>
                </ul>
            </div>
        </div>
    </div>

    <!-- 统计信息 -->
    <div class="row mb-4">
        <div class="col-md-2">
            <div class="card stats-card text-center">
                <div class="card-body">
                    <i class="fas fa-list fa-2x text-primary mb-2"></i>
                    <h6 class="card-title">总记录数</h6>
                    <p class="card-text number">${statistics.totalRecords != null ? statistics.totalRecords : 0}</p>
                </div>
            </div>
        </div>
        <div class="col-md-2">
            <div class="card stats-card text-center">
                <div class="card-body">
                    <i class="fas fa-calculator fa-2x text-success mb-2"></i>
                    <h6 class="card-title">平均分</h6>
                    <p class="card-text number">${statistics.averageScore != null ? statistics.averageScore : 0.0}</p>
                </div>
            </div>
        </div>
        <div class="col-md-2">
            <div class="card stats-card text-center">
                <div class="card-body">
                    <i class="fas fa-trophy fa-2x text-warning mb-2"></i>
                    <h6 class="card-title">最高分</h6>
                    <p class="card-text number">${statistics.maxScore != null ? statistics.maxScore : 0}</p>
                </div>
            </div>
        </div>
        <div class="col-md-2">
            <div class="card stats-card text-center">
                <div class="card-body">
                    <i class="fas fa-user-graduate fa-2x text-info mb-2"></i>
                    <h6 class="card-title">参与学生</h6>
                    <p class="card-text number">${statistics.uniqueStudents != null ? statistics.uniqueStudents : 0}</p>
                </div>
            </div>
        </div>
        <div class="col-md-2">
            <div class="card stats-card text-center">
                <div class="card-body">
                    <i class="fas fa-book fa-2x text-secondary mb-2"></i>
                    <h6 class="card-title">参与课程</h6>
                    <p class="card-text number">${statistics.uniqueCourses != null ? statistics.uniqueCourses : 0}</p>
                </div>
            </div>
        </div>
        <div class="col-md-2">
            <div class="card stats-card text-center">
                <div class="card-body">
                    <i class="fas fa-chart-pie fa-2x text-danger mb-2"></i>
                    <h6 class="card-title">优秀率</h6>
                    <p class="card-text number">
                        <c:if test="${statistics.totalRecords != null && statistics.totalRecords > 0 && statistics.excellentCount != null}">
                            ${String.format("%.2f", (statistics.excellentCount / statistics.totalRecords * 100))}%
                        </c:if>
                        <c:if test="${statistics.totalRecords == null || statistics.totalRecords == 0 || statistics.excellentCount == null}">0%</c:if>
                    </p>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <!-- 左侧：成绩管理操作区 -->
        <div class="col-lg-8">
            <div class="card">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <span>成绩信息管理</span>
                    <div class="score-actions">
                        <button class="btn btn-light">
                            <i class="fas fa-download me-1"></i> 导出
                        </button>
                        <button class="btn btn-light">
                            <i class="fas fa-upload me-1"></i> 导入
                        </button>
                        <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addGradeModal">
                            <i class="fas fa-plus me-1"></i> 添加成绩
                        </button>
                    </div>
                </div>
                <div class="card-body">
                    <!-- 搜索和筛选条件 -->
                    <div class="row mb-4">
                        <div class="col-md-12">
                            <div class="card">
                                <div class="card-body">
                                    <h6 class="card-title mb-3"><i class="fas fa-search me-2"></i>搜索和筛选</h6>
                                    <form method="get" action="${pageContext.request.contextPath}/grades" class="row g-3">
                                        <input type="hidden" name="page" value="1">
                                        <div class="col-md-3">
                                            <label class="form-label">学生姓名</label>
                                            <input type="text" class="form-control" name="studentName" value="${searchStudentName}" placeholder="搜索学生姓名">
                                        </div>
                                        <div class="col-md-3">
                                            <label class="form-label">课程名称</label>
                                            <input type="text" class="form-control" name="courseName" value="${searchCourseName}" placeholder="搜索课程名称">
                                        </div>
                                        <div class="col-md-3">
                                            <label class="form-label">学生学号</label>
                                            <input type="text" class="form-control" name="studentId" value="${searchStudentId}" placeholder="搜索学生学号">
                                        </div>
                                        <div class="col-md-3">
                                            <label class="form-label">课程编号</label>
                                            <input type="text" class="form-control" name="courseId" value="${searchCourseId}" placeholder="搜索课程编号">
                                        </div>
                                        <div class="col-12">
                                            <div class="d-flex gap-2">
                                                <button type="submit" class="btn btn-primary">
                                                    <i class="fas fa-search me-1"></i>搜索
                                                </button>
                                                <a href="${pageContext.request.contextPath}/grades" class="btn btn-secondary">
                                                    <i class="fas fa-refresh me-1"></i>重置
                                                </a>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- 成绩表格 -->
                    <div class="table-responsive">
                        <table class="table table-hover align-middle">
                            <thead class="table-dark">
                                <tr>
                                    <th>序号</th>
                                    <th>学号</th>
                                    <th>学生姓名</th>
                                    <th>课程编号</th>
                                    <th>课程名称</th>
                                    <th>成绩</th>
                                    <th>操作</th>
                                </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${grades}" var="grade" varStatus="status">
                                <tr>
                                    <td>${status.index + 1}</td>
                                    <td>${grade.student_id}</td>
                                    <td>${grade.student_name}</td>
                                    <td>${grade.course_id}</td>
                                    <td>${grade.course_name}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${grade.score >= 90}">
                                                <span class="score-excellent">${grade.score} (优秀)</span>
                                            </c:when>
                                            <c:when test="${grade.score >= 80}">
                                                <span class="score-good">${grade.score} (良好)</span>
                                            </c:when>
                                            <c:when test="${grade.score >= 60}">
                                                <span class="score-pass">${grade.score} (及格)</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="score-fail">${grade.score} (不及格)</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <button class="btn btn-sm btn-outline-primary action-btn" data-bs-toggle="modal"
                                                data-bs-target="#editGradeModal"
                                                data-id="${grade.id}"
                                                data-student-id="${grade.student_id}"
                                                data-course-id="${grade.course_id}"
                                                data-score="${grade.score}">
                                            <i class="fas fa-edit"></i>
                                        </button>
                                        <a href="${pageContext.request.contextPath}/grades/delete/${grade.id}"
                                           class="btn btn-sm btn-outline-danger action-btn"
                                           onclick="return confirm('确定要删除这条成绩记录吗？')">
                                            <i class="fas fa-trash-alt"></i>
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>

                    <!-- 分页 -->
                    <nav>
                        <ul class="pagination justify-content-end">
                            <c:if test="${currentPage > 1}">
                                <li class="page-item">
                                    <a class="page-link" href="${pageContext.request.contextPath}/grades?page=${currentPage-1}&studentName=${searchStudentName}&courseName=${searchCourseName}&studentId=${searchStudentId}&courseId=${searchCourseId}">
                                        上一页
                                    </a>
                                </li>
                            </c:if>
                            <c:if test="${currentPage == 1}">
                                <li class="page-item disabled">
                                    <a class="page-link" href="#" tabindex="-1">上一页</a>
                                </li>
                            </c:if>
                            
                            <c:forEach begin="1" end="${totalPages}" var="pageNum">
                                <c:choose>
                                    <c:when test="${pageNum == currentPage}">
                                        <li class="page-item active">
                                            <a class="page-link" href="#">${pageNum}</a>
                                        </li>
                                    </c:when>
                                    <c:otherwise>
                                        <li class="page-item">
                                            <a class="page-link" href="${pageContext.request.contextPath}/grades?page=${pageNum}&studentName=${searchStudentName}&courseName=${searchCourseName}&studentId=${searchStudentId}&courseId=${searchCourseId}">${pageNum}</a>
                                        </li>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                            
                            <c:if test="${currentPage < totalPages}">
                                <li class="page-item">
                                    <a class="page-link" href="${pageContext.request.contextPath}/grades?page=${currentPage+1}&studentName=${searchStudentName}&courseName=${searchCourseName}&studentId=${searchStudentId}&courseId=${searchCourseId}">
                                        下一页
                                    </a>
                                </li>
                            </c:if>
                            <c:if test="${currentPage >= totalPages}">
                                <li class="page-item disabled">
                                    <a class="page-link" href="#" tabindex="-1">下一页</a>
                                </li>
                            </c:if>
                        </ul>
                    </nav>
                </div>
            </div>
        </div>

        <!-- 右侧：成绩分析区 -->
        <div class="col-lg-4">
            <!-- 成绩分布图表 -->
            <div class="analysis-card">
                <h5><i class="fas fa-chart-pie"></i>成绩分布统计</h5>
                <div class="chart-container">
                    <canvas id="gradeDistributionChart"></canvas>
                </div>
            </div>

            <!-- 成绩趋势分析 -->
            <div class="analysis-card">
                <h5><i class="fas fa-chart-line"></i>成绩趋势分析</h5>
                <div class="chart-container">
                    <canvas id="scoreTrendChart"></canvas>
                </div>
            </div>

            <!-- 成绩分析摘要 -->
            <div class="analysis-card">
                <h5><i class="fas fa-clipboard-list"></i>成绩分析摘要</h5>
                <ul class="list-group list-group-flush">
                    <li class="list-group-item d-flex justify-content-between align-items-center">
                        <div>
                            <i class="fas fa-graduation-cap text-success me-2"></i>
                            最高分课程
                        </div>
                        <span>机械设计基础 <span class="trend-up">95分</span></span>
                    </li>
                    <li class="list-group-item d-flex justify-content-between align-items-center">
                        <div>
                            <i class="fas fa-book text-warning me-2"></i>
                            平均分最高课程
                        </div>
                        <span>计算机科学导论 <span class="trend-up">86.5分</span></span>
                    </li>
                    <li class="list-group-item d-flex justify-content-between align-items-center">
                        <div>
                            <i class="fas fa-user-graduate text-info me-2"></i>
                            进步最大学生
                        </div>
                        <span>王五 <span class="trend-up">提升12分</span></span>
                    </li>
                    <li class="list-group-item d-flex justify-content-between align-items-center">
                        <div>
                            <i class="fas fa-exclamation-triangle text-danger me-2"></i>
                            需关注课程
                        </div>
                        <span>高级英语写作 <span class="trend-down">平均分72.3</span></span>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>

<!-- 添加成绩模态框 -->
<div class="modal fade" id="addGradeModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">录入新成绩</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <form:form modelAttribute="grade" action="${pageContext.request.contextPath}/grades/add" method="post">
                    <div class="mb-3">
                        <label class="form-label">学生</label>
                        <form:select path="studentId" cssClass="form-select" required="true">
                            <c:forEach items="${students}" var="student">
                                <form:option value="${student.studentId}">${student.name}</form:option>
                            </c:forEach>
                        </form:select>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">课程</label>
                        <form:select path="courseId" cssClass="form-select" required="true">
                            <c:forEach items="${courses}" var="course">
                                <form:option value="${course.courseId}">${course.courseName}</form:option>
                            </c:forEach>
                        </form:select>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">分数</label>
                        <form:input path="score" cssClass="form-control" type="number" required="true"/>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">关闭</button>
                        <button type="submit" class="btn btn-primary">保存成绩</button>
                    </div>
                </form:form>
            </div>
        </div>
    </div>
</div>

<!-- 编辑成绩模态框 -->
<div class="modal fade" id="editGradeModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">编辑成绩</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <form:form modelAttribute="grade" action="${pageContext.request.contextPath}/grades/update" method="post">
                    <form:hidden path="id" id="edit-grade-id"/>
                    <div class="mb-3">
                        <label>学生</label>
                        <input type="text" id="edit-student-name" class="form-control" readonly/>
                    </div>
                     <div class="mb-3">
                        <label>课程</label>
                        <input type="text" id="edit-course-name" class="form-control" readonly/>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">分数</label>
                        <form:input path="score" id="edit-score" cssClass="form-control" type="number" required="true"/>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">关闭</button>
                        <button type="submit" class="btn btn-primary">保存更改</button>
                    </div>
                </form:form>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
    $(document).ready(function () {
        $('#editGradeModal').on('show.bs.modal', function (event) {
            var button = $(event.relatedTarget);
            var modal = $(this);
            modal.find('#edit-grade-id').val(button.data('id'));
            modal.find('#edit-student-name').val(button.data('student'));
            modal.find('#edit-course-name').val(button.data('course'));
            modal.find('#edit-score').val(button.data('score'));
        });

        // 成绩分布图表
        const gradeCtx = document.getElementById('gradeDistributionChart').getContext('2d');
        const gradeChart = new Chart(gradeCtx, {
            type: 'doughnut',
            data: {
                labels: ['90-100 (A)', '80-89 (B)', '70-79 (C)', '60-69 (D)', '0-59 (F)'],
                datasets: [{
                    data: [24, 38, 22, 10, 6],
                    backgroundColor: [
                        '#27ae60',
                        '#2ecc71',
                        '#f39c12',
                        '#e67e22',
                        '#e74c3c'
                    ],
                    borderWidth: 0,
                    hoverOffset: 10
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        position: 'bottom',
                        labels: {
                            padding: 20,
                            usePointStyle: true,
                            pointStyle: 'circle'
                        }
                    },
                    tooltip: {
                        callbacks: {
                            label: function(context) {
                                return `${context.label}: ${context.raw}%`;
                            }
                        }
                    }
                },
                cutout: '65%'
            }
        });

        // 成绩趋势图表
        const trendCtx = document.getElementById('scoreTrendChart').getContext('2d');
        const trendChart = new Chart(trendCtx, {
            type: 'line',
            data: {
                labels: ['9月', '10月', '11月', '12月', '1月', '2月'],
                datasets: [{
                    label: '班级平均分',
                    data: [72, 75, 78, 82, 80, 85],
                    borderColor: '#27ae60',
                    backgroundColor: 'rgba(39, 174, 96, 0.1)',
                    fill: true,
                    tension: 0.3,
                    pointBackgroundColor: '#fff',
                    pointBorderColor: '#27ae60',
                    pointBorderWidth: 2,
                    pointRadius: 5,
                    pointHoverRadius: 7
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                scales: {
                    y: {
                        beginAtZero: false,
                        min: 60,
                        max: 100,
                        grid: {
                            color: 'rgba(0, 0, 0, 0.05)'
                        }
                    },
                    x: {
                        grid: {
                            display: false
                        }
                    }
                },
                plugins: {
                    tooltip: {
                        backgroundColor: 'rgba(0, 0, 0, 0.8)',
                        padding: 12,
                        displayColors: false,
                        callbacks: {
                            title: function(tooltipItems) {
                                return tooltipItems[0].label;
                            },
                            label: function(context) {
                                return `平均分: ${context.parsed.y}分`;
                            }
                        }
                    }
                }
            }
        });

        // 移动端菜单切换
        $('#mobileMenuBtn').click(function() {
            $('#sidebar').toggleClass('active');
        });
    });
</script>
</body>
</html>