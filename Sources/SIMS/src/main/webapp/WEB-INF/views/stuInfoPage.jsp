<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>学生信息管理系统 - 学生管理</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.min.css">
  <style>
    :root {
      --primary-color: #3498db;
      --secondary-color: #2c3e50;
      --accent-color: #1abc9c;
      --light-color: #ecf0f1;
      --dark-color: #34495e;
      --danger-color: #e74c3c;
      --warning-color: #f39c12;
      --success-color: #2ecc71;
    }

    body {
      background-color: #f8f9fa;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      height: 100vh;
      overflow-x: hidden;
    }

    .sidebar {
      background: linear-gradient(180deg, var(--secondary-color), var(--dark-color));
      color: white;
      min-height: 100vh;
      box-shadow: 3px 0 10px rgba(0,0,0,0.1);
      position: fixed;
      z-index: 100;
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
      background: linear-gradient(90deg, var(--primary-color), var(--accent-color));
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

    .btn-danger {
      background: linear-gradient(90deg, var(--danger-color), #c0392b);
      border: none;
      border-radius: 8px;
      padding: 8px 20px;
      font-weight: 500;
    }

    .btn-warning {
      background: linear-gradient(90deg, var(--warning-color), #e67e22);
      border: none;
      border-radius: 8px;
      padding: 8px 20px;
      font-weight: 500;
    }

    .table-container {
      background: white;
      border-radius: 12px;
      box-shadow: 0 5px 15px rgba(0,0,0,0.08);
      overflow: hidden;
    }

    .table thead {
      background: linear-gradient(90deg, var(--primary-color), var(--accent-color));
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
      background-color: rgba(52, 152, 219, 0.05);
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
      color: var(--primary-color);
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
      border-color: var(--primary-color);
      box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.2);
    }

    .stats-card {
      text-align: center;
      padding: 20px;
    }

    .stats-card i {
      font-size: 2.5rem;
      margin-bottom: 15px;
      background: linear-gradient(45deg, var(--primary-color), var(--accent-color));
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
      color: var(--primary-color);
    }

    .pagination .page-item.active .page-link {
      background: linear-gradient(90deg, var(--primary-color), var(--accent-color));
      border: none;
    }

    .user-avatar {
      width: 40px;
      height: 40px;
      border-radius: 50%;
      object-fit: cover;
      border: 2px solid var(--accent-color);
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
      background: var(--primary-color);
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
        <a class="nav-link active" href="${pageContext.request.contextPath}/students">
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
  <div class="header">
    <div>
      <h4 class="mb-0"><i class="fas fa-user-graduate me-2 text-primary"></i>学生信息管理</h4>
      <nav aria-label="breadcrumb" class="d-inline-block mt-1">
        <ol class="breadcrumb bg-transparent p-0 m-0">
          <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home">首页</a></li>
          <li class="breadcrumb-item active" aria-current="page">学生管理</li>
        </ol>
      </nav>
    </div>
    <div class="d-flex align-items-center">
      <div class="search-box me-3">
        <i class="fas fa-search"></i>
        <input type="text" class="form-control" placeholder="搜索学生...">
      </div>
      <div class="dropdown">
        <button class="btn btn-light dropdown-toggle" type="button" data-bs-toggle="dropdown">
          <i class="fas fa-bell"></i>
          <span class="badge bg-danger">3</span>
        </button>
        <ul class="dropdown-menu dropdown-menu-end">
          <li><a class="dropdown-item" href="#">新学生注册通知</a></li>
          <li><a class="dropdown-item" href="#">系统更新通知</a></li>
          <li><a class="dropdown-item" href="#">成绩录入提醒</a></li>
        </ul>
      </div>
    </div>
  </div>

  <!-- 统计卡片 -->
  <div class="row">
    <div class="col-md-3">
      <div class="card stats-card">
        <i class="fas fa-users"></i>
        <div class="number">${statistics.totalStudents}</div>
        <div class="label">总学生数</div>
      </div>
    </div>
    <div class="col-md-3">
      <div class="card stats-card">
        <i class="fas fa-user-plus"></i>
        <div class="number">${statistics.newStudentsThisMonth}</div>
        <div class="label">本月新增</div>
      </div>
    </div>
    <div class="col-md-3">
      <div class="card stats-card">
        <i class="fas fa-male"></i>
        <div class="number">${statistics.maleStudents}</div>
        <div class="label">男学生</div>
      </div>
    </div>
    <div class="col-md-3">
      <div class="card stats-card">
        <i class="fas fa-female"></i>
        <div class="number">${statistics.femaleStudents}</div>
        <div class="label">女学生</div>
      </div>
    </div>
  </div>

  <!-- 操作区域 -->
  <div class="row">
    <div class="col-md-12">
      <div class="card">
        <div class="card-header d-flex justify-content-between align-items-center">
          <span>学生信息管理</span>
          <div>
            <button class="btn btn-light me-2" onclick="exportStudents()">
              <i class="fas fa-download me-1"></i> 导出
            </button>
            <button class="btn btn-light me-2" onclick="importStudents()">
              <i class="fas fa-upload me-1"></i> 导入
            </button>
            <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addStudentModal">
              <i class="fas fa-plus me-1"></i> 添加学生
            </button>
          </div>
        </div>
        <div class="card-body">
          <!-- 搜索和筛选条件 -->
          <form method="get" action="${pageContext.request.contextPath}/students" class="row mb-4">
            <div class="col-md-3">
              <label class="form-label">学生姓名</label>
              <input type="text" class="form-control" name="name" value="${searchName}" placeholder="请输入学生姓名">
            </div>
            <div class="col-md-3">
              <label class="form-label">性别</label>
              <select class="form-select" name="gender">
                <option value="">全部性别</option>
                <option value="M" ${searchGender == 'M' ? 'selected' : ''}>男</option>
                <option value="F" ${searchGender == 'F' ? 'selected' : ''}>女</option>
              </select>
            </div>
            <div class="col-md-3">
              <label class="form-label">每页显示</label>
              <select class="form-select" name="size" onchange="this.form.submit()">
                <option value="10" ${pageSize == 10 ? 'selected' : ''}>10条</option>
                <option value="20" ${pageSize == 20 ? 'selected' : ''}>20条</option>
                <option value="50" ${pageSize == 50 ? 'selected' : ''}>50条</option>
              </select>
            </div>
            <div class="col-md-3 d-flex align-items-end">
              <button type="submit" class="btn btn-primary me-2">
                <i class="fas fa-search me-1"></i> 搜索
              </button>
              <a href="${pageContext.request.contextPath}/students" class="btn btn-secondary">
                <i class="fas fa-refresh me-1"></i> 重置
              </a>
            </div>
          </form>

          <!-- 学生信息表格 -->
          <div class="table-responsive">
            <table class="table table-hover align-middle">
              <thead>
              <tr>
                <th width="50">#</th>
                <th>学号</th>
                <th>姓名</th>
                <th>性别</th>
                <th>出生日期</th>
                <th>联系方式</th>
                <th>家庭住址</th>
                <th width="120">操作</th>
              </tr>
              </thead>
              <tbody>
                <c:forEach items="${students}" var="student" varStatus="status">
                    <tr>
                        <td>${(currentPage - 1) * pageSize + status.count}</td>
                        <td>${student.studentId}</td>
                        <td>${student.name}</td>
                        <td>
                            <span class="badge ${student.gender == 'M' ? 'bg-primary' : 'bg-danger'}">
                                ${student.gender == 'M' ? '男' : '女'}
                            </span>
                        </td>
                        <td>${student.birthDate}</td>
                        <td>${student.phone}</td>
                        <td>${student.address}</td>
                        <td>
                            <button class="btn btn-sm btn-outline-primary action-btn" data-bs-toggle="modal"
                                    data-bs-target="#editStudentModal"
                                    data-id="${student.studentId}"
                                    data-name="${student.name}"
                                    data-gender="${student.gender}"
                                    data-birthdate="${student.birthDate}"
                                    data-phone="${student.phone}"
                                    data-address="${student.address}">
                                <i class="fas fa-edit"></i>
                            </button>
                            <a href="${pageContext.request.contextPath}/students/delete/${student.studentId}"
                               class="btn btn-sm btn-outline-danger action-btn"
                               onclick="return confirm('确定要删除这位学生吗？')">
                                <i class="fas fa-trash-alt"></i>
                            </a>
                        </td>
                    </tr>
                </c:forEach>
              </tbody>
            </table>
          </div>

          <!-- 分页导航 -->
          <c:if test="${totalPages > 1}">
            <nav aria-label="学生信息分页">
              <ul class="pagination justify-content-center">
                <!-- 上一页 -->
                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                  <a class="page-link" href="${pageContext.request.contextPath}/students?page=${currentPage - 1}&size=${pageSize}&name=${searchName}&gender=${searchGender}">
                    <i class="fas fa-chevron-left"></i> 上一页
                  </a>
                </li>
                
                <!-- 页码 -->
                <c:forEach begin="1" end="${totalPages}" var="pageNum">
                  <c:choose>
                    <c:when test="${pageNum == currentPage}">
                      <li class="page-item active">
                        <span class="page-link">${pageNum}</span>
                      </li>
                    </c:when>
                    <c:when test="${pageNum <= 3 || pageNum > totalPages - 2 || (pageNum >= currentPage - 1 && pageNum <= currentPage + 1)}">
                      <li class="page-item">
                        <a class="page-link" href="${pageContext.request.contextPath}/students?page=${pageNum}&size=${pageSize}&name=${searchName}&gender=${searchGender}">${pageNum}</a>
                      </li>
                    </c:when>
                    <c:when test="${pageNum == 4 && currentPage > 5}">
                      <li class="page-item disabled">
                        <span class="page-link">...</span>
                      </li>
                    </c:when>
                    <c:when test="${pageNum == totalPages - 3 && currentPage < totalPages - 4}">
                      <li class="page-item disabled">
                        <span class="page-link">...</span>
                      </li>
                    </c:when>
                  </c:choose>
                </c:forEach>
                
                <!-- 下一页 -->
                <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                  <a class="page-link" href="${pageContext.request.contextPath}/students?page=${currentPage + 1}&size=${pageSize}&name=${searchName}&gender=${searchGender}">
                    下一页 <i class="fas fa-chevron-right"></i>
                  </a>
                </li>
              </ul>
            </nav>
            
            <!-- 分页信息 -->
            <div class="text-center text-muted">
              显示第 ${(currentPage - 1) * pageSize + 1} 到 ${currentPage * pageSize > totalCount ? totalCount : currentPage * pageSize} 条，
              共 ${totalCount} 条记录
            </div>
          </c:if>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- 添加学生模态框 -->
<div class="modal fade" id="addStudentModal" tabindex="-1">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header" style="background: linear-gradient(90deg, var(--primary-color), var(--accent-color)); color: white;">
        <h5 class="modal-title"><i class="fas fa-user-plus me-2"></i>添加新学生</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form:form modelAttribute="student" action="${pageContext.request.contextPath}/students/add" method="post">
          <div class="row mb-3">
            <div class="col-md-6">
              <label class="form-label">学号 <span class="text-danger">*</span></label>
              <form:input path="studentId" cssClass="form-control" placeholder="请输入学号" required="true"/>
            </div>
            <div class="col-md-6">
              <label class="form-label">姓名 <span class="text-danger">*</span></label>
              <form:input path="name" cssClass="form-control" placeholder="请输入学生姓名" required="true"/>
            </div>
          </div>

          <div class="row mb-3">
            <div class="col-md-6">
                <label class="form-label">性别 <span class="text-danger">*</span></label>
                <div>
                    <div class="form-check form-check-inline">
                        <form:radiobutton path="gender" id="add-gender-male" value="男" cssClass="form-check-input" checked="checked"/>
                        <label class="form-check-label" for="add-gender-male">男</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <form:radiobutton path="gender" id="add-gender-female" value="女" cssClass="form-check-input"/>
                        <label class="form-check-label" for="add-gender-female">女</label>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
              <label class="form-label">出生日期 <span class="text-danger">*</span></label>
              <div class="input-group">
                <form:input path="birthDate" cssClass="form-control datepicker" placeholder="选择日期" required="true"/>
                <span class="input-group-text"><i class="fas fa-calendar"></i></span>
              </div>
            </div>
          </div>
          <div class="row mb-3">
              <div class="col-md-6">
                  <label class="form-label">联系方式</label>
                  <form:input path="phone" cssClass="form-control" placeholder="请输入联系方式"/>
              </div>
              <div class="col-md-6">
                  <label class="form-label">家庭住址</label>
                  <form:input path="address" cssClass="form-control" placeholder="请输入家庭住址"/>
              </div>
          </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">关闭</button>
                <button type="submit" class="btn btn-primary">保存学生</button>
            </div>
        </form:form>
      </div>
    </div>
  </div>
</div>

<!-- 编辑学生模态框 -->
<div class="modal fade" id="editStudentModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header" style="background: linear-gradient(90deg, var(--primary-color), var(--accent-color)); color: white;">
                <h5 class="modal-title"><i class="fas fa-user-edit me-2"></i>编辑学生信息</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form:form modelAttribute="student" action="${pageContext.request.contextPath}/students/update" method="post">
                    <form:hidden path="studentId" id="edit-student-id"/>
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label class="form-label">姓名 <span class="text-danger">*</span></label>
                            <form:input path="name" id="edit-name" cssClass="form-control" required="true"/>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">性别 <span class="text-danger">*</span></label>
                            <div>
                                <div class="form-check form-check-inline">
                                    <form:radiobutton path="gender" id="edit-gender-male" value="男" cssClass="form-check-input"/>
                                    <label class="form-check-label" for="edit-gender-male">男</label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <form:radiobutton path="gender" id="edit-gender-female" value="女" cssClass="form-check-input"/>
                                    <label class="form-check-label" for="edit-gender-female">女</label>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label class="form-label">出生日期 <span class="text-danger">*</span></label>
                            <div class="input-group">
                                <form:input path="birthDate" id="edit-birthdate" cssClass="form-control datepicker" required="true"/>
                                <span class="input-group-text"><i class="fas fa-calendar"></i></span>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">联系方式</label>
                            <form:input path="phone" id="edit-phone" cssClass="form-control"/>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-md-12">
                            <label class="form-label">家庭住址</label>
                            <form:input path="address" id="edit-address" cssClass="form-control"/>
                        </div>
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
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/locales/bootstrap-datepicker.zh-CN.min.js"></script>

<script>
$(document).ready(function() {
    // 初始化日期选择器
    $('.datepicker').datepicker({
        format: 'yyyy-mm-dd',
        language: 'zh-CN',
        autoclose: true,
        todayHighlight: true
    });

    // 编辑学生模态框数据填充
    $('#editStudentModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget);
        var modal = $(this);
        
        // 先填充所有数据
        modal.find('#edit-student-id').val(button.data('id'));
        modal.find('#edit-name').val(button.data('name'));
        modal.find('#edit-phone').val(button.data('phone'));
        modal.find('#edit-address').val(button.data('address'));
        
        // 设置性别单选按钮 - 根据实际数据设置
        var gender = button.data('gender');
        if (gender === '男' || gender === 'M') {
            modal.find('#edit-gender-male').prop('checked', true);
            modal.find('#edit-gender-female').prop('checked', false);
        } else if (gender === '女' || gender === 'F') {
            modal.find('#edit-gender-male').prop('checked', false);
            modal.find('#edit-gender-female').prop('checked', true);
        }
        
        // 最后设置日期，避免触发datepicker重新初始化
        var birthdateInput = modal.find('#edit-birthdate');
        birthdateInput.val(button.data('birthdate'));
        
        // 如果日期选择器已经初始化，则更新日期
        if (birthdateInput.hasClass('datepicker')) {
            birthdateInput.datepicker('update', button.data('birthdate'));
        }
    });

    // 实时搜索功能
    var searchTimer;
    $('input[name="name"]').on('input', function() {
        clearTimeout(searchTimer);
        var searchTerm = $(this).val();
        
        if (searchTerm.length >= 2) {
            searchTimer = setTimeout(function() {
                performSearch(searchTerm);
            }, 500);
        }
    });

    // 学生ID唯一性检查
    $('#studentId').on('blur', function() {
        var studentId = $(this).val();
        if (studentId) {
            checkStudentId(studentId);
        }
    });

    // 电话号码唯一性检查
    $('#phone').on('blur', function() {
        var phone = $(this).val();
        if (phone) {
            checkPhone(phone);
        }
    });

    // 显示操作结果消息
    var urlParams = new URLSearchParams(window.location.search);
    var success = urlParams.get('success');
    var error = urlParams.get('error');
    
    if (success) {
        showMessage('操作成功！', 'success');
    }
    if (error) {
        showMessage('操作失败：' + error, 'error');
    }

    // 移动端菜单切换
    $('#mobileMenuBtn').click(function() {
        $('#sidebar').toggleClass('active');
    });
});

// 执行搜索
function performSearch(searchTerm) {
    $.get('${pageContext.request.contextPath}/students/search', {name: searchTerm})
        .done(function(data) {
            updateSearchResults(data);
        })
        .fail(function() {
            console.log('搜索失败');
        });
}

// 更新搜索结果
function updateSearchResults(students) {
    var tbody = $('table tbody');
    tbody.empty();
    
    students.forEach(function(student, index) {
        var genderText = student.gender === 'M' ? '男' : '女';
        var genderClass = student.gender === 'M' ? 'bg-primary' : 'bg-danger';
        
        var row = `
            <tr>
                <td>${index + 1}</td>
                <td>${student.studentId}</td>
                <td>${student.name}</td>
                <td><span class="badge ${genderClass}">${genderText}</span></td>
                <td>${student.birthDate}</td>
                <td>${student.phone}</td>
                <td>${student.address}</td>
                <td>
                    <button class="btn btn-sm btn-outline-primary action-btn" data-bs-toggle="modal"
                            data-bs-target="#editStudentModal"
                            data-id="${student.studentId}"
                            data-name="${student.name}"
                            data-gender="${student.gender}"
                            data-birthdate="${student.birthDate}"
                            data-phone="${student.phone}"
                            data-address="${student.address}">
                        <i class="fas fa-edit"></i>
                    </button>
                    <a href="${pageContext.request.contextPath}/students/delete/${student.studentId}"
                       class="btn btn-sm btn-outline-danger action-btn"
                       onclick="return confirm('确定要删除这位学生吗？')">
                        <i class="fas fa-trash-alt"></i>
                    </a>
                </td>
            </tr>
        `;
        tbody.append(row);
    });
}

// 检查学生ID唯一性
function checkStudentId(studentId) {
    $.get('${pageContext.request.contextPath}/students/check/' + studentId)
        .done(function(exists) {
            if (exists) {
                $('#studentId').addClass('is-invalid');
                $('#studentId').next('.invalid-feedback').text('学生ID已存在');
            } else {
                $('#studentId').removeClass('is-invalid').addClass('is-valid');
                $('#studentId').next('.invalid-feedback').text('');
            }
        });
}

// 检查电话号码唯一性
function checkPhone(phone) {
    $.get('${pageContext.request.contextPath}/students/check-phone/' + phone)
        .done(function(exists) {
            if (exists) {
                $('#phone').addClass('is-invalid');
                $('#phone').next('.invalid-feedback').text('电话号码已存在');
            } else {
                $('#phone').removeClass('is-invalid').addClass('is-valid');
                $('#phone').next('.invalid-feedback').text('');
            }
        });
}

// 导出学生信息
function exportStudents() {
    var searchParams = new URLSearchParams(window.location.search);
    var exportUrl = '${pageContext.request.contextPath}/students/export?' + searchParams.toString();
    
    // 创建临时下载链接
    var link = document.createElement('a');
    link.href = exportUrl;
    link.download = '学生信息_' + new Date().toISOString().slice(0, 10) + '.xlsx';
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
    
    showMessage('导出功能开发中...', 'info');
}

// 导入学生信息
function importStudents() {
    // 创建文件输入元素
    var input = document.createElement('input');
    input.type = 'file';
    input.accept = '.xlsx,.xls,.csv';
    input.onchange = function(e) {
        var file = e.target.files[0];
        if (file) {
            uploadFile(file);
        }
    };
    input.click();
}

// 上传文件
function uploadFile(file) {
    var formData = new FormData();
    formData.append('file', file);
    
    $.ajax({
        url: '${pageContext.request.contextPath}/students/import',
        type: 'POST',
        data: formData,
        processData: false,
        contentType: false,
        success: function(response) {
            showMessage('导入成功！', 'success');
            setTimeout(function() {
                location.reload();
            }, 1500);
        },
        error: function() {
            showMessage('导入失败，请检查文件格式', 'error');
        }
    });
}

// 显示消息
function showMessage(message, type) {
    var alertClass = type === 'success' ? 'alert-success' : 
                    type === 'error' ? 'alert-danger' : 'alert-info';
    
    var alertHtml = `
        <div class="alert ${alertClass} alert-dismissible fade show" role="alert">
            ${message}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    `;
    
    // 在页面顶部显示消息
    $('.main-content').prepend(alertHtml);
    
    // 3秒后自动消失
    setTimeout(function() {
        $('.alert').fadeOut();
    }, 3000);
}

// 刷新统计数据
function refreshStatistics() {
    $.get('${pageContext.request.contextPath}/students/statistics')
        .done(function(data) {
            $('.stats-card .number').each(function(index) {
                var values = [data.totalStudents, data.newStudentsThisMonth, data.maleStudents, data.femaleStudents];
                $(this).text(values[index]);
            });
        });
}

// 页面加载完成后刷新统计数据
$(document).ready(function() {
    refreshStatistics();
});
</script>
</body>
</html>