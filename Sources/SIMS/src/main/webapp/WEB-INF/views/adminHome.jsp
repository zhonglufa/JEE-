<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>学生信息管理系统 - 管理员首页</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <style>
    :root {
      --primary-color: #3498db;
      --secondary-color: #2c3e50;
      --accent-color: #1abc9c;
      --light-color: #ecf0f1;
      --dark-color: #34495e;
      --success-color: #27ae60;
      --warning-color: #f39c12;
      --danger-color: #e74c3c;
    }

    body {
      background: linear-gradient(135deg, #f5f7fa 0%, #e4edf5 100%);
      min-height: 100vh;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    .navbar {
      background: linear-gradient(90deg, var(--secondary-color), var(--dark-color));
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    }

    .user-avatar {
      width: 36px;
      height: 36px;
      border-radius: 50%;
      object-fit: cover;
      border: 2px solid var(--accent-color);
    }

    .dropdown-toggle::after {
      display: none;
    }

    .user-dropdown .dropdown-menu {
      border-radius: 10px;
      border: none;
      box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
      margin-top: 10px;
    }

    .user-dropdown .dropdown-item {
      padding: 8px 16px;
      border-radius: 5px;
      margin: 3px 8px;
      width: auto;
    }

    .user-dropdown .dropdown-item:hover {
      background-color: rgba(52, 152, 219, 0.1);
    }

    .hero-section {
      background: url('https://images.unsplash.com/photo-1523580494863-6f3031224c94?ixlib=rb-4.0.3&auto=format&fit=crop&w=1950&q=80') no-repeat center center;
      background-size: cover;
      padding: 100px 0;
      position: relative;
      color: white;
      text-align: center;
      margin-bottom: 50px;
    }

    .hero-section::before {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      bottom: 0;
      background: rgba(44, 62, 80, 0.85);
    }

    .hero-content {
      position: relative;
      z-index: 2;
    }

    .feature-card {
      transition: all 0.3s ease;
      border-radius: 15px;
      overflow: hidden;
      box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
      margin-bottom: 30px;
      border: none;
      background: white;
    }

    .feature-card:hover {
      transform: translateY(-10px);
      box-shadow: 0 12px 24px rgba(0, 0, 0, 0.15);
    }

    .feature-icon {
      font-size: 3rem;
      margin: 20px 0;
      color: var(--primary-color);
    }

    .card-header {
      background: linear-gradient(90deg, var(--primary-color), var(--accent-color));
      color: white;
      padding: 20px;
      border: none;
    }

    .stats-container {
      background: white;
      border-radius: 15px;
      box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
      padding: 30px;
      margin-bottom: 30px;
      transition: all 0.3s ease;
    }

    .stats-container:hover {
      transform: translateY(-5px);
      box-shadow: 0 12px 24px rgba(0, 0, 0, 0.15);
    }

    .stat-number {
      font-size: 2.5rem;
      font-weight: 700;
      color: var(--primary-color);
      margin-bottom: 10px;
    }

    .stat-label {
      color: var(--dark-color);
      font-size: 1rem;
      font-weight: 500;
    }

    .stat-icon {
      font-size: 2rem;
      margin-top: 15px;
      opacity: 0.7;
    }

    .btn-primary {
      background: linear-gradient(90deg, var(--primary-color), var(--accent-color));
      border: none;
      padding: 10px 25px;
      border-radius: 50px;
      font-weight: 600;
      transition: all 0.3s ease;
    }

    .btn-primary:hover {
      transform: translateY(-3px);
      box-shadow: 0 5px 15px rgba(52, 152, 219, 0.4);
    }

    .footer {
      background: var(--secondary-color);
      color: white;
      padding: 30px 0;
      margin-top: 50px;
    }

    .system-overview {
      background: white;
      border-radius: 15px;
      padding: 30px;
      box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
    }

    .system-overview h3 {
      color: var(--secondary-color);
      border-bottom: 2px solid var(--accent-color);
      padding-bottom: 10px;
      margin-bottom: 20px;
    }

    .overview-item {
      display: flex;
      align-items: center;
      margin-bottom: 15px;
      padding: 10px;
      border-radius: 8px;
      transition: background 0.3s;
    }

    .overview-item:hover {
      background: #f8f9fa;
    }

    .overview-icon {
      width: 40px;
      height: 40px;
      background: var(--accent-color);
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      margin-right: 15px;
      color: white;
    }

    .notification-badge {
      position: absolute;
      top: -5px;
      right: -5px;
      background: var(--danger-color);
      color: white;
      border-radius: 50%;
      width: 20px;
      height: 20px;
      font-size: 0.75rem;
      display: flex;
      align-items: center;
      justify-content: center;
    }

    .recent-data-table {
      background: white;
      border-radius: 15px;
      box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
      overflow: hidden;
    }

    .recent-data-table .table {
      margin-bottom: 0;
    }

    .recent-data-table .table th {
      background: var(--primary-color);
      color: white;
      border: none;
      font-weight: 600;
    }

    .recent-data-table .table td {
      border-color: #f8f9fa;
      vertical-align: middle;
    }

    .recent-data-table .table tbody tr:hover {
      background-color: #f8f9fa;
    }

    @media (max-width: 768px) {
      .hero-section {
        padding: 60px 0;
      }

      .stat-number {
        font-size: 2rem;
      }

      .navbar-nav {
        margin-top: 15px;
      }

      .user-info {
        margin-top: 15px;
      }
    }
  </style>
</head>
<body>
<!-- 导航栏 -->
<nav class="navbar navbar-expand-lg navbar-dark sticky-top">
  <div class="container">
    <a class="navbar-brand" href="${pageContext.request.contextPath}/home">
      <i class="fas fa-graduation-cap me-2"></i>
      <strong>学生信息管理系统</strong>
    </a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav ms-auto">
        <li class="nav-item">
          <a class="nav-link active" href="${pageContext.request.contextPath}/home">首页</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath}/students">学生管理</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath}/courses">课程管理</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath}/grades">成绩管理</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">统计分析</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">系统设置</a>
        </li>
      </ul>

      <!-- 用户登录信息显示区域 -->
      <div class="ms-3 user-info">
        <div class="dropdown user-dropdown">
          <a href="#" class="d-flex align-items-center text-white text-decoration-none dropdown-toggle"
             id="userDropdown" data-bs-toggle="dropdown" aria-expanded="false">
            <img src="https://randomuser.me/api/portraits/men/32.jpg" class="user-avatar me-2">
            <div class="d-none d-md-block">
              <span class="me-1">${realName.substring(0, 1)}老师</span>
              <small class="text-muted">管理员</small>
            </div>
            <span class="position-relative">
              <i class="fas fa-bell ms-2"></i>
              <span class="notification-badge">3</span>
            </span>
          </a>
          <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
            <li>
              <div class="d-flex align-items-center p-3 border-bottom">
                <img src="https://randomuser.me/api/portraits/men/32.jpg" class="user-avatar me-3">
                <div>
                  <div class="fw-bold">${sessionScope.currentUser.realName}</div>
                  <div class="small text-muted">${sessionScope.currentUser.email}</div>
                </div>
              </div>
            </li>
            <li><a class="dropdown-item" href="#"><i class="fas fa-user-circle me-2"></i>个人中心</a></li>
            <li><a class="dropdown-item" href="#"><i class="fas fa-cog me-2"></i>账户设置</a></li>
            <li><a class="dropdown-item" href="#"><i class="fas fa-bell me-2"></i>通知 <span class="badge bg-danger">3</span></a></li>
            <li><hr class="dropdown-divider"></li>
            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt me-2"></i>退出登录</a></li>
          </ul>
        </div>
      </div>
    </div>
  </div>
</nav>

<!-- 头部英雄区域 -->
<section class="hero-section">
  <div class="container hero-content">
    <h1 class="display-4 fw-bold mb-3">欢迎回来，${sessionScope.currentUser.realName.substring(0, 1)}老师！</h1>
    <p class="lead mb-4">学生信息管理系统 - 高效管理学生信息、课程安排与成绩数据的综合解决方案</p>
    <div class="d-flex justify-content-center gap-3">
      <a href="${pageContext.request.contextPath}/students" class="btn btn-primary btn-lg">
        <i class="fas fa-play-circle me-2"></i>开始使用
      </a>
      <a href="#" class="btn btn-outline-light btn-lg">
        <i class="fas fa-info-circle me-2"></i>了解更多
      </a>
    </div>
  </div>
</section>

<div class="container">
  <!-- 系统数据概览 -->
  <div class="row mb-5">
    <div class="col-md-3 col-sm-6">
      <div class="stats-container text-center">
        <div class="stat-number">${studentStats.totalStudents}</div>
        <div class="stat-label">在校学生</div>
        <i class="fas fa-users stat-icon text-primary"></i>
      </div>
    </div>
    <div class="col-md-3 col-sm-6">
      <div class="stats-container text-center">
        <div class="stat-number">${courseStats.totalCourses}</div>
        <div class="stat-label">课程数量</div>
        <i class="fas fa-book stat-icon text-success"></i>
      </div>
    </div>
    <div class="col-md-3 col-sm-6">
      <div class="stats-container text-center">
        <div class="stat-number">${gradeStats.totalRecords}</div>
        <div class="stat-label">成绩记录</div>
        <i class="fas fa-chart-line stat-icon text-info"></i>
      </div>
    </div>
    <div class="col-md-3 col-sm-6">
      <div class="stats-container text-center">
        <div class="stat-number">98.5%</div>
        <div class="stat-label">系统可用性</div>
        <i class="fas fa-server stat-icon text-warning"></i>
      </div>
    </div>
  </div>

  <!-- 核心功能区域 -->
  <div class="row mb-5">
    <div class="col-12 mb-4">
      <h2 class="text-center mb-4" style="color: var(--secondary-color);">核心功能模块</h2>
      <p class="text-center text-muted mb-5">全面覆盖学生信息管理的各个方面，提高工作效率与数据准确性</p>
    </div>

    <div class="col-lg-4 col-md-6">
      <div class="feature-card">
        <div class="card-header text-center">
          <i class="fas fa-user-graduate feature-icon"></i>
          <h3>学生信息管理</h3>
        </div>
        <div class="card-body">
          <p class="card-text">
            全面管理学生基本信息，包括学号、姓名、性别、出生日期、联系方式、家庭住址等。
            支持信息的增删改查、批量导入导出以及历史记录追踪。
          </p>
          <ul class="list-group list-group-flush mb-3">
            <li class="list-group-item"><i class="fas fa-check-circle text-success me-2"></i>学生档案管理</li>
            <li class="list-group-item"><i class="fas fa-check-circle text-success me-2"></i>信息批量处理</li>
            <li class="list-group-item"><i class="fas fa-check-circle text-success me-2"></i>数据统计分析</li>
          </ul>
          <a href="${pageContext.request.contextPath}/students" class="btn btn-primary w-100">进入模块</a>
        </div>
      </div>
    </div>

    <div class="col-lg-4 col-md-6">
      <div class="feature-card">
        <div class="card-header text-center">
          <i class="fas fa-book-open feature-icon"></i>
          <h3>课程管理</h3>
        </div>
        <div class="card-body">
          <p class="card-text">
            系统化管理课程信息，包括课程编号、课程名称、学分、授课教师、上课时间地点等。
            支持课程安排、教师分配、课表生成等功能。
          </p>
          <ul class="list-group list-group-flush mb-3">
            <li class="list-group-item"><i class="fas fa-check-circle text-success me-2"></i>课程信息维护</li>
            <li class="list-group-item"><i class="fas fa-check-circle text-success me-2"></i>教师分配管理</li>
            <li class="list-group-item"><i class="fas fa-check-circle text-success me-2"></i>智能排课系统</li>
          </ul>
          <a href="${pageContext.request.contextPath}/courses" class="btn btn-primary w-100">进入模块</a>
        </div>
      </div>
    </div>

    <div class="col-lg-4 col-md-6">
      <div class="feature-card">
        <div class="card-header text-center">
          <i class="fas fa-chart-bar feature-icon"></i>
          <h3>成绩管理</h3>
        </div>
        <div class="card-body">
          <p class="card-text">
            高效管理学生各科成绩，支持成绩录入、查询、修改及统计分析。
            提供多种统计图表和报表输出，帮助教师进行教学评估。
          </p>
          <ul class="list-group list-group-flush mb-3">
            <li class="list-group-item"><i class="fas fa-check-circle text-success me-2"></i>成绩录入与修改</li>
            <li class="list-group-item"><i class="fas fa-check-circle text-success me-2"></i>成绩查询分析</li>
            <li class="list-group-item"><i class="fas fa-check-circle text-success me-2"></i>综合报表生成</li>
          </ul>
          <a href="${pageContext.request.contextPath}/grades" class="btn btn-primary w-100">进入模块</a>
        </div>
      </div>
    </div>
  </div>

  <!-- 最新数据展示 -->
  <div class="row mb-5">
    <div class="col-lg-4">
      <div class="recent-data-table">
        <div class="card-header">
          <h5 class="mb-0"><i class="fas fa-users me-2"></i>最新学生</h5>
        </div>
        <div class="table-responsive">
          <table class="table table-hover mb-0">
            <thead>
              <tr>
                <th>姓名</th>
                <th>学号</th>
                <th>性别</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach items="${recentStudents}" var="student" varStatus="status">
                <c:if test="${status.index < 5}">
                  <tr>
                    <td>${student.name}</td>
                    <td>${student.studentId}</td>
                    <td>
                      <span class="badge ${student.gender == 'M' ? 'bg-primary' : 'bg-danger'}">
                        ${student.gender == 'M' ? '男' : '女'}
                      </span>
                    </td>
                  </tr>
                </c:if>
              </c:forEach>
              <c:if test="${empty recentStudents}">
                <tr>
                  <td colspan="3" class="text-center text-muted">暂无数据</td>
                </tr>
              </c:if>
            </tbody>
          </table>
        </div>
      </div>
    </div>

    <div class="col-lg-4">
      <div class="recent-data-table">
        <div class="card-header">
          <h5 class="mb-0"><i class="fas fa-book me-2"></i>最新课程</h5>
        </div>
        <div class="table-responsive">
          <table class="table table-hover mb-0">
            <thead>
              <tr>
                <th>课程名称</th>
                <th>课程编号</th>
                <th>学分</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach items="${recentCourses}" var="course" varStatus="status">
                <c:if test="${status.index < 5}">
                  <tr>
                    <td>${course.courseName}</td>
                    <td>${course.courseId}</td>
                    <td>${course.credit}</td>
                  </tr>
                </c:if>
              </c:forEach>
              <c:if test="${empty recentCourses}">
                <tr>
                  <td colspan="3" class="text-center text-muted">暂无数据</td>
                </tr>
              </c:if>
            </tbody>
          </table>
        </div>
      </div>
    </div>

    <div class="col-lg-4">
      <div class="recent-data-table">
        <div class="card-header">
          <h5 class="mb-0"><i class="fas fa-chart-line me-2"></i>最新成绩</h5>
        </div>
        <div class="table-responsive">
          <table class="table table-hover mb-0">
            <thead>
              <tr>
                <th>学生</th>
                <th>课程</th>
                <th>成绩</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach items="${recentGrades}" var="grade" varStatus="status">
                <c:if test="${status.index < 5}">
                  <tr>
                    <td>${grade.student_name}</td>
                    <td>${grade.course_name}</td>
                    <td>
                      <span class="badge ${grade.score >= 90 ? 'bg-success' : grade.score >= 80 ? 'bg-primary' : grade.score >= 70 ? 'bg-warning' : 'bg-danger'}">
                        ${grade.score}
                      </span>
                    </td>
                  </tr>
                </c:if>
              </c:forEach>
              <c:if test="${empty recentGrades}">
                <tr>
                  <td colspan="3" class="text-center text-muted">暂无数据</td>
                </tr>
              </c:if>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>

  <!-- 系统概述 -->
  <div class="row mb-5">
    <div class="col-lg-6">
      <div class="system-overview">
        <h3><i class="fas fa-info-circle me-2"></i>系统特点</h3>
        <div class="overview-item">
          <div class="overview-icon">
            <i class="fas fa-bolt"></i>
          </div>
          <div>
            <h5>高效便捷</h5>
            <p class="mb-0">简洁的操作流程，大幅提升工作效率</p>
          </div>
        </div>
        <div class="overview-item">
          <div class="overview-icon">
            <i class="fas fa-shield-alt"></i>
          </div>
          <div>
            <h5>安全可靠</h5>
            <p class="mb-0">完善的数据备份与权限管理系统</p>
          </div>
        </div>
        <div class="overview-item">
          <div class="overview-icon">
            <i class="fas fa-mobile-alt"></i>
          </div>
          <div>
            <h5>多端适配</h5>
            <p class="mb-0">完美支持PC、平板、手机等设备访问</p>
          </div>
        </div>
        <div class="overview-item">
          <div class="overview-icon">
            <i class="fas fa-chart-pie"></i>
          </div>
          <div>
            <h5>智能分析</h5>
            <p class="mb-0">强大的数据统计与可视化分析功能</p>
          </div>
        </div>
      </div>
    </div>
    <div class="col-lg-6">
      <div class="system-overview">
        <h3><i class="fas fa-calendar-check me-2"></i>近期动态</h3>
        <div class="overview-item">
          <div class="overview-icon">
            <i class="fas fa-sync"></i>
          </div>
          <div>
            <h5>系统更新至v2.5.0</h5>
            <p class="mb-0 text-muted">2023-10-15</p>
            <p class="mb-0">新增成绩分析报告导出功能</p>
          </div>
        </div>
        <div class="overview-item">
          <div class="overview-icon">
            <i class="fas fa-bell"></i>
          </div>
          <div>
            <h5>新学期数据导入</h5>
            <p class="mb-0 text-muted">2023-09-01</p>
            <p class="mb-0">已完成2023级新生数据批量导入</p>
          </div>
        </div>
        <div class="overview-item">
          <div class="overview-icon">
            <i class="fas fa-tools"></i>
          </div>
          <div>
            <h5>系统维护通知</h5>
            <p class="mb-0 text-muted">2023-08-25</p>
            <p class="mb-0">本周六凌晨1:00-3:00系统维护升级</p>
          </div>
        </div>
        <div class="overview-item">
          <div class="overview-icon">
            <i class="fas fa-graduation-cap"></i>
          </div>
          <div>
            <h5>毕业季数据归档</h5>
            <p class="mb-0 text-muted">2023-07-10</p>
            <p class="mb-0">2023届毕业生数据已归档完毕</p>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- 页脚 -->
<footer class="footer">
  <div class="container">
    <div class="row">
      <div class="col-lg-4 mb-4 mb-lg-0">
        <h4><i class="fas fa-graduation-cap me-2"></i>学生信息管理系统</h4>
        <p class="mt-3">高效、安全、易用的学生信息管理解决方案，为教育机构提供全方位的数字化管理支持。</p>
        <div class="mt-4">
          <a href="#" class="text-light me-3"><i class="fab fa-facebook-f fa-lg"></i></a>
          <a href="#" class="text-light me-3"><i class="fab fa-twitter fa-lg"></i></a>
          <a href="#" class="text-light me-3"><i class="fab fa-linkedin-in fa-lg"></i></a>
          <a href="#" class="text-light"><i class="fab fa-github fa-lg"></i></a>
        </div>
      </div>
      <div class="col-lg-2 col-md-4 mb-4 mb-md-0">
        <h5>快速链接</h5>
        <ul class="list-unstyled">
          <li class="mb-2"><a href="${pageContext.request.contextPath}/home" class="text-light">首页</a></li>
          <li class="mb-2"><a href="${pageContext.request.contextPath}/students" class="text-light">学生管理</a></li>
          <li class="mb-2"><a href="${pageContext.request.contextPath}/courses" class="text-light">课程管理</a></li>
          <li class="mb-2"><a href="${pageContext.request.contextPath}/grades" class="text-light">成绩管理</a></li>
        </ul>
      </div>
      <div class="col-lg-3 col-md-4 mb-4 mb-md-0">
        <h5>相关资源</h5>
        <ul class="list-unstyled">
          <li class="mb-2"><a href="#" class="text-light">帮助文档</a></li>
          <li class="mb-2"><a href="#" class="text-light">视频教程</a></li>
          <li class="mb-2"><a href="#" class="text-light">API文档</a></li>
          <li class="mb-2"><a href="#" class="text-light">系统状态</a></li>
        </ul>
      </div>
      <div class="col-lg-3 col-md-4">
        <h5>联系我们</h5>
        <ul class="list-unstyled">
          <li class="mb-2"><i class="fas fa-map-marker-alt me-2"></i> 北京市海淀区</li>
          <li class="mb-2"><i class="fas fa-phone me-2"></i> (010) 1234-5678</li>
          <li class="mb-2"><i class="fas fa-envelope me-2"></i> support@edusys.com</li>
          <li class="mb-2"><i class="fas fa-clock me-2"></i> 周一至周五: 9:00-18:00</li>
        </ul>
      </div>
    </div>
    <hr class="my-4 bg-light">
    <div class="row">
      <div class="col-md-6 text-center text-md-start">
        <p class="mb-0">© 2023 学生信息管理系统. 保留所有权利.</p>
      </div>
      <div class="col-md-6 text-center text-md-end">
        <p class="mb-0">
          <a href="#" class="text-light me-3">隐私政策</a>
          <a href="#" class="text-light me-3">使用条款</a>
          <a href="#" class="text-light">Cookie政策</a>
        </p>
      </div>
    </div>
  </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
/**
 * 管理员首页JavaScript功能
 * 包含用户信息显示、数据刷新、交互效果等功能
 */
document.addEventListener('DOMContentLoaded', function() {
    console.log('管理员首页加载完成');
    
    // 检查用户登录状态
    checkLoginStatus();
    
    // 初始化页面功能
    initializePage();
    
    // 设置定时刷新统计数据
    setInterval(refreshStatistics, 30000); // 每30秒刷新一次
});

/**
 * 检查用户登录状态
 */
function checkLoginStatus() {
    fetch('${pageContext.request.contextPath}/api/check-login')
        .then(response => response.json())
        .then(data => {
            if (!data.loggedIn) {
                // 如果未登录，重定向到登录页面
                window.location.href = '${pageContext.request.contextPath}/login';
            } else {
                console.log('用户已登录:', data.username);
                updateUserInfo(data);
            }
        })
        .catch(error => {
            console.error('检查登录状态失败:', error);
        });
}

/**
 * 更新用户信息显示
 */
function updateUserInfo(userData) {
    // 更新导航栏用户信息
    const userSpan = document.querySelector('.d-none.d-md-block span');
    const userSmall = document.querySelector('.d-none.d-md-block small');
    
    if (userSpan) userSpan.textContent = userData.realName || userData.username;
    if (userSmall) userSmall.textContent = '管理员';
    
    // 更新下拉菜单用户信息
    const dropdownName = document.querySelector('.dropdown .fw-bold');
    const dropdownEmail = document.querySelector('.dropdown .small');
    
    if (dropdownName) dropdownName.textContent = userData.realName || userData.username;
    if (dropdownEmail) dropdownEmail.textContent = userData.email || '';
}

/**
 * 初始化页面功能
 */
function initializePage() {
    // 添加统计卡片悬停效果
    const statCards = document.querySelectorAll('.stats-container');
    statCards.forEach(card => {
        card.addEventListener('mouseenter', function() {
            this.style.transform = 'translateY(-5px)';
        });
        
        card.addEventListener('mouseleave', function() {
            this.style.transform = 'translateY(0)';
        });
    });
    
    // 添加功能卡片点击效果
    const featureCards = document.querySelectorAll('.feature-card');
    featureCards.forEach(card => {
        card.addEventListener('click', function() {
            const link = this.querySelector('a.btn-primary');
            if (link) {
                window.location.href = link.href;
            }
        });
    });
}

/**
 * 刷新统计数据
 */
function refreshStatistics() {
    console.log('刷新统计数据...');
    
    // 这里可以添加AJAX请求来刷新统计数据
    // 目前使用静态数据，实际项目中应该从后端获取最新数据
    
    // 模拟数据更新
    const statNumbers = document.querySelectorAll('.stat-number');
    statNumbers.forEach((number, index) => {
        if (index < 3) { // 只更新前三个统计数据
            const currentValue = parseInt(number.textContent);
            const newValue = currentValue + Math.floor(Math.random() * 5);
            number.textContent = newValue;
        }
    });
}

/**
 * 显示通知消息
 */
function showNotification(message, type = 'info') {
    const alertClass = type === 'success' ? 'alert-success' : 
                      type === 'error' ? 'alert-danger' : 'alert-info';
    
    const alertHtml = `
        <div class="alert ${alertClass} alert-dismissible fade show position-fixed" 
             style="top: 20px; right: 20px; z-index: 9999;" role="alert">
            ${message}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    `;
    
    document.body.insertAdjacentHTML('beforeend', alertHtml);
    
    // 3秒后自动消失
    setTimeout(() => {
        const alert = document.querySelector('.alert');
        if (alert) {
            alert.remove();
        }
    }, 3000);
}

/**
 * 导出系统报告
 */
function exportSystemReport() {
    showNotification('正在生成系统报告...', 'info');
    
    // 模拟导出过程
    setTimeout(() => {
        showNotification('系统报告导出成功！', 'success');
    }, 2000);
}

/**
 * 系统维护模式切换
 */
function toggleMaintenanceMode() {
    const isMaintenance = confirm('确定要切换系统维护模式吗？');
    if (isMaintenance) {
        showNotification('系统已进入维护模式', 'warning');
    }
}
</script>
</body>
</html>