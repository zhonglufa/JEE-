<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>学生信息管理系统 - 课程管理</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #3498db;
            --secondary-color: #2c3e50;
            --accent-color: #1abc9c;
            --light-color: #ecf0f1;
            --dark-color: #34495e;
            --purple-color: #9b59b6;
            --orange-color: #e67e22;
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
        .main-content {
            margin-left: 250px;
            padding: 20px;
            transition: margin-left 0.3s;
        }

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
            background: linear-gradient(90deg, var(--purple-color), #8e44ad);
            color: white;
            border-radius: 12px 12px 0 0 !important;
            padding: 15px 20px;
            font-weight: 600;
            border: none;
        }

        .btn-primary {
            background: linear-gradient(90deg, var(--primary-color), var(--accent-color));
            border: none;
            border-radius: 8px;
            padding: 8px 20px;
            font-weight: 500;
            transition: all 0.3s;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(52, 152, 219, 0.4);
        }

        .btn-purple {
            background: linear-gradient(90deg, var(--purple-color), #8e44ad);
            border: none;
            border-radius: 8px;
            padding: 8px 20px;
            font-weight: 500;
            color: white;
        }

        .btn-purple:hover {
            background: linear-gradient(90deg, #8e44ad, var(--purple-color));
            color: white;
        }

        .table-container {
            background: white;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
            overflow: hidden;
        }

        .table thead {
            background: linear-gradient(90deg, var(--purple-color), #8e44ad);
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
            background-color: rgba(155, 89, 182, 0.05);
        }

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
            color: var(--purple-color);
        }

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
            border-color: var(--purple-color);
            box-shadow: 0 0 0 3px rgba(155, 89, 182, 0.2);
        }

        .stats-card {
            text-align: center;
            padding: 20px;
        }

        .stats-card i {
            font-size: 2.5rem;
            margin-bottom: 15px;
            background: linear-gradient(45deg, var(--purple-color), #8e44ad);
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

        .pagination .page-link {
            border-radius: 8px;
            margin: 0 3px;
            border: none;
            color: var(--purple-color);
        }

        .pagination .page-item.active .page-link {
            background: linear-gradient(90deg, var(--purple-color), #8e44ad);
            border: none;
            color: white;
        }

        .tag {
            display: inline-block;
            padding: 5px 12px;
            border-radius: 50px;
            font-size: 0.85rem;
            font-weight: 500;
        }

        .tag-primary {
            background: rgba(52, 152, 219, 0.15);
            color: var(--primary-color);
        }

        .tag-success {
            background: rgba(46, 204, 113, 0.15);
            color: #27ae60;
        }

        .tag-warning {
            background: rgba(241, 196, 15, 0.15);
            color: #f39c12;
        }

        .tag-danger {
            background: rgba(231, 76, 60, 0.15);
            color: #c0392b;
        }

        .badge-status {
            padding: 6px 12px;
            border-radius: 50px;
            font-weight: 500;
        }

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
            }

            .sidebar {
                transform: translateX(-100%);
                transition: transform 0.3s;
            }

            .sidebar.active {
                transform: translateX(0);
            }

            .mobile-menu-btn {
                display: block;
            }
        }

        .mobile-menu-btn {
            display: none;
            background: var(--purple-color);
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

        .course-icon {
            width: 50px;
            height: 50px;
            border-radius: 12px;
            background: linear-gradient(135deg, var(--purple-color), #8e44ad);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.5rem;
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
        
        /* 课程状态样式 */
        .status-active {
            color: #28a745;
            font-weight: bold;
            background-color: rgba(40, 167, 69, 0.1);
            padding: 4px 8px;
            border-radius: 12px;
            border: 1px solid #28a745;
        }
        
        .status-inactive {
            color: #6c757d;
            font-weight: bold;
            background-color: rgba(108, 117, 125, 0.1);
            padding: 4px 8px;
            border-radius: 12px;
            border: 1px solid #6c757d;
        }
        
        .status-ended {
            color: #dc3545;
            font-weight: bold;
            background-color: rgba(220, 53, 69, 0.1);
            padding: 4px 8px;
            border-radius: 12px;
            border: 1px solid #dc3545;
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
                <a class="nav-link active" href="${pageContext.request.contextPath}/courses">
                    <i class="fas fa-book-open"></i>
                    <span>课程管理</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/grades">
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
                <c:when test="${param.success == 'add'}">课程添加成功！</c:when>
                <c:when test="${param.success == 'update'}">课程更新成功！</c:when>
                <c:when test="${param.success == 'delete'}">课程删除成功！</c:when>
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
            <h4 class="mb-0"><i class="fas fa-book-open me-2" style="color: #9b59b6;"></i>课程信息管理</h4>
            <nav aria-label="breadcrumb" class="d-inline-block mt-1">
                <ol class="breadcrumb bg-transparent p-0 m-0">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home">首页</a></li>
                    <li class="breadcrumb-item active" aria-current="page">课程管理</li>
                </ol>
            </nav>
        </div>
        <div class="d-flex align-items-center">
            <div class="search-box me-3">
                <i class="fas fa-search"></i>
                <input type="text" class="form-control" placeholder="搜索课程...">
            </div>
            <div class="dropdown">
                <button class="btn btn-light dropdown-toggle" type="button" data-bs-toggle="dropdown">
                    <i class="fas fa-bell"></i>
                    <span class="badge bg-danger">2</span>
                </button>
                <ul class="dropdown-menu dropdown-menu-end">
                    <li><a class="dropdown-item" href="#">新课程审核通知</a></li>
                    <li><a class="dropdown-item" href="#">课程更新提醒</a></li>
                </ul>
            </div>
        </div>
    </div>

    <!-- 统计信息 -->
    <div class="row mb-4">
        <div class="col-md-3">
            <div class="card stats-card text-center">
                <div class="card-body">
                    <i class="fas fa-book fa-2x text-primary mb-2"></i>
                    <h5 class="card-title">总课程数</h5>
                    <p class="card-text number">${statistics.totalCourses != null ? statistics.totalCourses : 0}</p>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card stats-card text-center">
                <div class="card-body">
                    <i class="fas fa-chalkboard-teacher fa-2x text-success mb-2"></i>
                    <h5 class="card-title">任课教师</h5>
                    <p class="card-text number">${statistics.totalTeachers != null ? statistics.totalTeachers : 0}</p>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card stats-card text-center">
                <div class="card-body">
                    <i class="fas fa-star fa-2x text-warning mb-2"></i>
                    <h5 class="card-title">平均学分</h5>
                    <p class="card-text number">${statistics.averageCredits != null ? statistics.averageCredits : 0.0}</p>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card stats-card text-center">
                <div class="card-body">
                    <i class="fas fa-plus-circle fa-2x text-info mb-2"></i>
                    <h5 class="card-title">本月新增</h5>
                    <p class="card-text number">${statistics.newCoursesThisMonth != null ? statistics.newCoursesThisMonth : 0}</p>
                </div>
            </div>
        </div>
    </div>

    <!-- 操作区域 -->
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <span>课程信息管理</span>
                    <div>
                        <button class="btn btn-light me-2">
                            <i class="fas fa-download me-1"></i> 导出课程
                        </button>
                        <button class="btn btn-light me-2">
                            <i class="fas fa-upload me-1"></i> 导入课程
                        </button>
                        <button class="btn btn-purple" data-bs-toggle="modal" data-bs-target="#addCourseModal">
                            <i class="fas fa-plus me-1"></i> 添加课程
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
                                    <form method="get" action="${pageContext.request.contextPath}/courses" class="row g-3">
                                        <input type="hidden" name="page" value="1">
                                        <div class="col-md-3">
                                            <label class="form-label">课程名称</label>
                                            <input type="text" class="form-control" name="courseName" value="${searchCourseName}" placeholder="搜索课程名称">
                                        </div>
                                        <div class="col-md-3">
                                            <label class="form-label">授课教师</label>
                                            <input type="text" class="form-control" name="teacher" value="${searchTeacher}" placeholder="搜索教师">
                                        </div>
                                        <div class="col-md-2">
                                            <label class="form-label">课程类型</label>
                                            <select class="form-select" name="courseType">
                                                <option value="">全部类型</option>
                                                <option value="公共基础课" ${searchCourseType == '公共基础课' ? 'selected' : ''}>公共基础课</option>
                                                <option value="专业必修课" ${searchCourseType == '专业必修课' ? 'selected' : ''}>专业必修课</option>
                                                <option value="专业选修课" ${searchCourseType == '专业选修课' ? 'selected' : ''}>专业选修课</option>
                                                <option value="通识选修课" ${searchCourseType == '通识选修课' ? 'selected' : ''}>通识选修课</option>
                                            </select>
                                        </div>
                                        <div class="col-md-2">
                                            <label class="form-label">开课学院</label>
                                            <select class="form-select" name="college">
                                                <option value="">全部学院</option>
                                                <option value="计算机学院" ${searchCollege == '计算机学院' ? 'selected' : ''}>计算机学院</option>
                                                <option value="经济管理学院" ${searchCollege == '经济管理学院' ? 'selected' : ''}>经济管理学院</option>
                                                <option value="外国语学院" ${searchCollege == '外国语学院' ? 'selected' : ''}>外国语学院</option>
                                                <option value="机械工程学院" ${searchCollege == '机械工程学院' ? 'selected' : ''}>机械工程学院</option>
                                            </select>
                                        </div>
                                        <div class="col-md-2">
                                            <label class="form-label">开课状态</label>
                                            <select class="form-select" name="status">
                                                <option value="">全部状态</option>
                                                <option value="已开通" ${searchStatus == '已开通' ? 'selected' : ''}>已开通</option>
                                                <option value="未开课" ${searchStatus == '未开课' ? 'selected' : ''}>未开课</option>
                                                <option value="已结束" ${searchStatus == '已结束' ? 'selected' : ''}>已结束</option>
                                            </select>
                                        </div>
                                        <div class="col-12">
                                            <div class="d-flex gap-2">
                                                <button type="submit" class="btn btn-primary">
                                                    <i class="fas fa-search me-1"></i>搜索
                                                </button>
                                                <a href="${pageContext.request.contextPath}/courses" class="btn btn-secondary">
                                                    <i class="fas fa-refresh me-1"></i>重置
                                                </a>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- 课程信息表格 -->
                    <div class="table-responsive">
                        <table class="table table-hover align-middle">
                            <thead>
                            <tr>
                                <th width="50">#</th>
                                <th>课程编号</th>
                                <th>课程名称</th>
                                <th>学分</th>
                                <th>课程类型</th>
                                <th>授课教师</th>
                                <th>开课学院</th>
                                <th>选课人数</th>
                                <th>开课状态</th>
                                <th width="120">操作</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${courses}" var="course" varStatus="status">
                                <tr>
                                    <td>${status.count}</td>
                                    <td>${course.courseId}</td>
                                    <td>
                                        <div class="d-flex align-items-center">
                                            <div class="course-icon me-3">
                                                <i class="fas fa-laptop-code"></i>
                                            </div>
                                            <div>
                                                <div>${course.courseName}</div>
                                                <div class="small text-muted">每周一 3-4节</div>
                                            </div>
                                        </div>
                                    </td>
                                    <td>${course.credit}</td>
                                    <td><span class="tag tag-primary">${course.courseType}</span></td>
                                    <td>${course.teacher}</td>
                                    <td>${course.college}</td>
                                    <td>142</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${course.status == '已开通'}">
                                                <span class="status-active">${course.status}</span>
                                            </c:when>
                                            <c:when test="${course.status == '未开课'}">
                                                <span class="status-inactive">${course.status}</span>
                                            </c:when>
                                            <c:when test="${course.status == '已结束'}">
                                                <span class="status-ended">${course.status}</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="status-inactive">${course.status}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <button class="btn btn-sm btn-outline-primary action-btn" data-bs-toggle="modal" 
                                                data-bs-target="#editCourseModal"
                                                data-id="${course.courseId}"
                                                data-name="${course.courseName}"
                                                data-credit="${course.credit}"
                                                data-teacher="${course.teacher}"
                                                data-course-type="${course.courseType}"
                                                data-college="${course.college}"
                                                data-status="${course.status}">
                                            <i class="fas fa-edit"></i>
                                        </button>
                                        <a href="${pageContext.request.contextPath}/courses/delete/${course.courseId}"
                                           class="btn btn-sm btn-outline-danger action-btn"
                                           onclick="return confirm('确定要删除这门课程吗？')">
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
                                    <a class="page-link" href="${pageContext.request.contextPath}/courses?page=${currentPage-1}&courseName=${searchCourseName}&teacher=${searchTeacher}&courseType=${searchCourseType}&college=${searchCollege}&status=${searchStatus}">
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
                                            <a class="page-link" href="${pageContext.request.contextPath}/courses?page=${pageNum}&courseName=${searchCourseName}&teacher=${searchTeacher}&courseType=${searchCourseType}&college=${searchCollege}&status=${searchStatus}">${pageNum}</a>
                                        </li>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                            
                            <c:if test="${currentPage < totalPages}">
                                <li class="page-item">
                                    <a class="page-link" href="${pageContext.request.contextPath}/courses?page=${currentPage+1}&courseName=${searchCourseName}&teacher=${searchTeacher}&courseType=${searchCourseType}&college=${searchCollege}&status=${searchStatus}">
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
    </div>
</div>

<!-- 添加课程模态框 -->
<div class="modal fade" id="addCourseModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header" style="background: linear-gradient(90deg, var(--purple-color), #8e44ad); color: white;">
                <h5 class="modal-title"><i class="fas fa-book-medical me-2"></i>添加新课程</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form:form modelAttribute="course" action="${pageContext.request.contextPath}/courses/add" method="post">
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label class="form-label">课程编号 <span class="text-danger">*</span></label>
                            <form:input path="courseId" cssClass="form-control" placeholder="请输入课程编号" required="true"/>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">课程名称 <span class="text-danger">*</span></label>
                            <form:input path="courseName" cssClass="form-control" placeholder="请输入课程名称" required="true"/>
                        </div>
                    </div>

                    <div class="row mb-3">
                        <div class="col-md-4">
                            <label class="form-label">学分 <span class="text-danger">*</span></label>
                            <form:input path="credit" cssClass="form-control" type="number" step="0.5" placeholder="请输入学分" required="true"/>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">课程类型 <span class="text-danger">*</span></label>
                            <form:select path="courseType" cssClass="form-select" required="true">
                                <option value="">请选择课程类型</option>
                                <option value="公共基础课">公共基础课</option>
                                <option value="专业必修课">专业必修课</option>
                                <option value="专业选修课">专业选修课</option>
                                <option value="通识选修课">通识选修课</option>
                            </form:select>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">开课状态 <span class="text-danger">*</span></label>
                            <form:select path="status" cssClass="form-select" required="true">
                                <option value="">请选择开课状态</option>
                                <option value="已开通">已开通</option>
                                <option value="未开课">未开课</option>
                                <option value="已结束">已结束</option>
                            </form:select>
                        </div>
                    </div>

                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label class="form-label">开课学院 <span class="text-danger">*</span></label>
                            <form:select path="college" cssClass="form-select" required="true">
                                <option value="">请选择学院</option>
                                <option value="计算机学院">计算机学院</option>
                                <option value="经济管理学院">经济管理学院</option>
                                <option value="外国语学院">外国语学院</option>
                                <option value="机械工程学院">机械工程学院</option>
                                <option value="艺术学院">艺术学院</option>
                            </form:select>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">授课教师 <span class="text-danger">*</span></label>
                            <form:input path="teacher" cssClass="form-control" placeholder="请输入授课教师" required="true"/>
                        </div>
                    </div>

                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label class="form-label">开课时间</label>
                            <input type="text" class="form-control" placeholder="例如：2023年秋季学期">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">上课地点</label>
                            <input type="text" class="form-control" placeholder="请输入上课地点">
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">课程简介</label>
                        <textarea class="form-control" rows="3" placeholder="请输入课程简介"></textarea>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">课程大纲</label>
                        <textarea class="form-control" rows="4" placeholder="请输入课程大纲"></textarea>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">取消</button>
                        <button type="submit" class="btn btn-purple">保存课程</button>
                    </div>
                </form:form>
            </div>
        </div>
    </div>
</div>

<!-- 编辑课程模态框 -->
<div class="modal fade" id="editCourseModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header" style="background: linear-gradient(90deg, var(--orange-color), #d35400); color: white;">
                <h5 class="modal-title"><i class="fas fa-book-open me-2"></i>编辑课程信息</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form:form modelAttribute="course" action="${pageContext.request.contextPath}/courses/update" method="post">
                    <form:hidden path="courseId" id="edit-course-id"/>
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label class="form-label">课程名称 <span class="text-danger">*</span></label>
                            <form:input path="courseName" id="edit-course-name" cssClass="form-control" required="true"/>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">学分 <span class="text-danger">*</span></label>
                            <form:input path="credit" id="edit-credit" cssClass="form-control" type="number" step="0.5" required="true"/>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-md-4">
                            <label class="form-label">课程类型 <span class="text-danger">*</span></label>
                            <form:select path="courseType" id="edit-course-type" cssClass="form-select" required="true">
                                <option value="公共基础课">公共基础课</option>
                                <option value="专业必修课">专业必修课</option>
                                <option value="专业选修课">专业选修课</option>
                                <option value="通识选修课">通识选修课</option>
                            </form:select>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">开课学院 <span class="text-danger">*</span></label>
                            <form:select path="college" id="edit-college" cssClass="form-select" required="true">
                                <option value="计算机学院">计算机学院</option>
                                <option value="经济管理学院">经济管理学院</option>
                                <option value="外国语学院">外国语学院</option>
                                <option value="机械工程学院">机械工程学院</option>
                                <option value="艺术学院">艺术学院</option>
                            </form:select>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">开课状态 <span class="text-danger">*</span></label>
                            <form:select path="status" id="edit-status" cssClass="form-select" required="true">
                                <option value="已开通">已开通</option>
                                <option value="未开课">未开课</option>
                                <option value="已结束">已结束</option>
                            </form:select>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-md-12">
                            <label class="form-label">授课教师 <span class="text-danger">*</span></label>
                            <form:input path="teacher" id="edit-teacher" cssClass="form-control" required="true"/>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">课程简介</label>
                        <textarea class="form-control" rows="3" placeholder="请输入课程简介"></textarea>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">取消</button>
                        <button type="submit" class="btn btn-warning text-white">更新课程</button>
                    </div>
                </form:form>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(document).ready(function() {
        // 移动端菜单切换
        $('#mobileMenuBtn').click(function() {
            $('#sidebar').toggleClass('active');
        });

        // 编辑课程模态框数据填充
        $('#editCourseModal').on('show.bs.modal', function (event) {
            var button = $(event.relatedTarget);
            var modal = $(this);
            modal.find('#edit-course-id').val(button.data('id'));
            modal.find('#edit-course-name').val(button.data('name'));
            modal.find('#edit-credit').val(button.data('credit'));
            modal.find('#edit-teacher').val(button.data('teacher'));
            modal.find('#edit-course-type').val(button.data('course-type'));
            modal.find('#edit-college').val(button.data('college'));
            modal.find('#edit-status').val(button.data('status'));
        });
    });
</script>
</body>
</html>