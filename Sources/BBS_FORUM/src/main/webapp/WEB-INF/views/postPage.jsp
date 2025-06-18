<%--
  Created by IntelliJ IDEA.
  User: 爱锅粥粥
  Date: 2025/6/18
  Time: 13:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>我的文章 - BBS论坛</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+SC:wght@400;500;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #4361ee;
            --primary-dark: #3a56d4;
            --secondary: #ff5a5f;
            --secondary-dark: #e04b53;
            --accent: #ff69b4;
            --text-primary: #2d3748;
            --text-secondary: #718096;
            --bg-light: #f8fafc;
            --bg-white: #ffffff;
            --border: #e2e8f0;
            --success: #10b981;
            --warning: #f59e0b;
            --danger: #ef4444;
            --shadow-sm: 0 2px 4px rgba(0, 0, 0, 0.05);
            --shadow-md: 0 4px 6px -1px rgba(0, 0, 0, 0.05), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
            --radius: 8px;
            --radius-sm: 4px;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Noto Sans SC', -apple-system, BlinkMacSystemFont, sans-serif;
            background-color: var(--bg-light);
            color: var(--text-primary);
            line-height: 1.6;
        }

        /* 头部导航 */
        .forum-header {
            background: linear-gradient(135deg, var(--primary), #3a0ca3);
            color: white;
            padding: 0.8rem 0;
            box-shadow: var(--shadow-md);
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .header-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 15px;
        }

        .logo {
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 1.4rem;
            font-weight: 700;
            color: white;
            text-decoration: none;
        }

        .logo img {
            height: 40px;
            width: 40px;
            border-radius: 50%;
            object-fit: cover;
            box-shadow: 0 0 0 2px white;
        }

        .nav-links {
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
            justify-content: center;
        }

        .nav-links a {
            color: rgba(255, 255, 255, 0.9);
            text-decoration: none;
            font-weight: 500;
            transition: color 0.2s;
            padding: 0.5rem;
            position: relative;
            font-size: 0.95rem;
        }

        .nav-links a:hover {
            color: white;
        }

        .nav-links a.active {
            color: white;
            font-weight: 600;
        }

        .nav-links a::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 0;
            height: 2px;
            background: white;
            transition: width 0.3s ease;
        }

        .nav-links a:hover::after {
            width: 100%;
        }

        .search-bar {
            display: flex;
            flex: 1;
            max-width: 250px;
            min-width: 150px;
        }

        .search-bar input {
            flex: 1;
            padding: 0.7rem 1rem;
            border: none;
            border-radius: var(--radius-sm) 0 0 var(--radius-sm);
            font-size: 0.95rem;
        }

        .search-bar button {
            background-color: var(--secondary);
            border: none;
            color: white;
            padding: 0 1.2rem;
            border-radius: 0 var(--radius-sm) var(--radius-sm) 0;
            cursor: pointer;
            transition: background-color 0.2s;
        }

        .search-bar button:hover {
            background-color: var(--secondary-dark);
        }

        /* 用户控制区 */
        .user-controls {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .user-profile {
            display: flex;
            align-items: center;
            gap: 0.8rem;
            position: relative;
            cursor: pointer;
        }

        .user-avatar {
            height: 40px;
            width: 40px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid white;
            box-shadow: var(--shadow-sm);
        }

        .user-name {
            color: white;
            font-weight: 500;
        }

        .post-btn {
            background-color: white;
            color: var(--primary);
            border: none;
            padding: 0.6rem 1.2rem;
            border-radius: var(--radius-sm);
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            cursor: pointer;
            transition: all 0.2s;
            text-decoration: none;
        }

        .post-btn:hover {
            background-color: rgba(255, 255, 255, 0.9);
            transform: translateY(-1px);
        }

        .profile-menu {
            position: absolute;
            top: 100%;
            right: 0;
            background-color: white;
            border-radius: var(--radius-sm);
            box-shadow: var(--shadow-md);
            min-width: 180px;
            z-index: 100;
            overflow: hidden;
            display: none;
            margin-top: 10px;
        }

        .profile-menu.show {
            display: block;
        }

        .profile-menu a {
            display: block;
            padding: 0.8rem 1.2rem;
            text-decoration: none;
            color: var(--text-primary);
            font-size: 0.95rem;
            transition: all 0.2s;
            border-bottom: 1px solid var(--border);
        }

        .profile-menu a:last-child {
            border-bottom: none;
        }

        .profile-menu a:hover {
            background-color: var(--bg-light);
            color: var(--primary);
        }

        /* 主内容区 */
        .main-container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 20px;
            display: grid;
            grid-template-columns: 1fr;
            gap: 2rem;
        }

        @media (min-width: 992px) {
            .main-container {
                grid-template-columns: 3fr 1fr;
            }
        }

        /* 内容区 */
        .content-section {
            background-color: var(--bg-white);
            border-radius: var(--radius);
            box-shadow: var(--shadow-sm);
            overflow: hidden;
        }

        .section-header {
            padding: 1.2rem 1.5rem;
            background-color: #f9fafb;
            border-bottom: 1px solid var(--border);
            display: flex;
            align-items: center;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 1rem;
        }

        .section-title {
            font-size: 1.25rem;
            font-weight: 600;
            color: var(--text-primary);
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .section-title i {
            color: var(--accent);
        }

        /* 文章管理样式 */
        .post-manage-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 1rem;
            margin-bottom: 1.5rem;
        }

        .post-count {
            font-weight: 500;
            color: var(--text-secondary);
        }

        .post-filter {
            display: flex;
            gap: 0.8rem;
            flex-wrap: wrap;
        }

        .filter-btn {
            padding: 0.5rem 1rem;
            border-radius: var(--radius-sm);
            border: 1px solid var(--border);
            background-color: white;
            color: var(--text-secondary);
            font-weight: 500;
            cursor: pointer;
            transition: all 0.2s;
        }

        .filter-btn:hover, .filter-btn.active {
            background-color: var(--primary);
            color: white;
            border-color: var(--primary);
        }

        .action-buttons {
            display: flex;
            gap: 0.8rem;
            flex-wrap: wrap;
        }

        .action-btn {
            padding: 0.5rem 1rem;
            border-radius: var(--radius-sm);
            border: none;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.2s;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .new-post-btn {
            background-color: var(--primary);
            color: white;
        }

        .new-post-btn:hover {
            background-color: var(--primary-dark);
        }

        .bulk-action-btn {
            background-color: var(--bg-white);
            border: 1px solid var(--border);
            color: var(--text-primary);
        }

        .bulk-action-btn:hover {
            background-color: #f1f5f9;
        }

        /* 文章表格 */
        .post-table {
            width: 100%;
            border-collapse: collapse;
        }

        .post-table th {
            text-align: left;
            padding: 1rem;
            background-color: #f9fafb;
            border-bottom: 1px solid var(--border);
            color: var(--text-secondary);
            font-weight: 600;
        }

        .post-table td {
            padding: 1rem;
            border-bottom: 1px solid var(--border);
            vertical-align: middle;
        }

        .post-table tbody tr {
            transition: background-color 0.2s;
        }

        .post-table tbody tr:hover {
            background-color: #f9fafb;
        }

        .post-checkbox {
            width: 20px;
            height: 20px;
            cursor: pointer;
        }

        .post-title-cell {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .post-cover {
            flex-shrink: 0;
            width: 60px;
            height: 40px;
            border-radius: var(--radius-sm);
            overflow: hidden;
            background-color: #f1f1f1;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #ccc;
        }

        .post-cover img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .post-title-wrapper {
            flex: 1;
        }

        .post-title {
            font-weight: 500;
            margin-bottom: 0.3rem;
            color: var(--text-primary);
        }

        .post-excerpt {
            font-size: 0.9rem;
            color: var(--text-secondary);
            display: -webkit-box;
            -webkit-line-clamp: 1;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .post-status {
            padding: 0.25rem 0.7rem;
            border-radius: 50px;
            font-size: 0.8rem;
            font-weight: 500;
        }

        .status-draft {
            background-color: #fef3c7;
            color: var(--warning);
        }

        .status-published {
            background-color: #dcfce7;
            color: var(--success);
        }

        .post-meta-item {
            display: flex;
            align-items: center;
            gap: 0.4rem;
            font-size: 0.9rem;
            color: var(--text-secondary);
        }

        .post-actions {
            display: flex;
            gap: 0.5rem;
        }

        .action-icon {
            width: 36px;
            height: 36px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.2s;
        }

        .edit-action {
            background-color: #e0f2fe;
            color: var(--primary);
        }

        .edit-action:hover {
            background-color: #bae6fd;
        }

        .delete-action {
            background-color: #fee2e2;
            color: var(--danger);
        }

        .delete-action:hover {
            background-color: #fecaca;
        }

        /* 移动端卡片视图 */
        .mobile-post-list {
            display: none;
            flex-direction: column;
            gap: 1rem;
        }

        .mobile-post-card {
            background-color: var(--bg-white);
            border-radius: var(--radius-sm);
            box-shadow: var(--shadow-sm);
            padding: 1rem;
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }

        .mobile-post-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .mobile-post-title {
            font-weight: 500;
            color: var(--text-primary);
            flex: 1;
        }

        .mobile-post-cover {
            width: 100%;
            height: 160px;
            border-radius: var(--radius-sm);
            overflow: hidden;
            background-color: #f1f1f1;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #ccc;
        }

        .mobile-post-cover img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .mobile-post-meta {
            display: flex;
            flex-wrap: wrap;
            gap: 1rem;
            font-size: 0.9rem;
            color: var(--text-secondary);
        }

        .mobile-post-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 1rem;
        }

        .mobile-post-actions {
            display: flex;
            gap: 0.5rem;
        }

        /* 侧边栏 */
        .sidebar {
            display: grid;
            gap: 1.5rem;
        }

        .widget {
            background-color: var(--bg-white);
            border-radius: var(--radius);
            box-shadow: var(--shadow-sm);
            overflow: hidden;
        }

        .widget-header {
            padding: 1rem 1.5rem;
            background-color: #f9fafb;
            border-bottom: 1px solid var(--border);
            font-size: 1.1rem;
            font-weight: 600;
            color: var(--text-primary);
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .widget-content {
            padding: 1.5rem;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 1rem;
        }

        .stat-card {
            background-color: #f8fafc;
            border-radius: var(--radius-sm);
            padding: 1rem;
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center;
        }

        .stat-value {
            font-size: 1.8rem;
            font-weight: 700;
            color: var(--primary);
            margin: 0.5rem 0;
        }

        .stat-label {
            font-size: 0.9rem;
            color: var(--text-secondary);
        }

        .quick-actions {
            display: flex;
            flex-direction: column;
            gap: 0.8rem;
        }

        .quick-action-btn {
            display: flex;
            align-items: center;
            gap: 0.8rem;
            padding: 0.8rem 1rem;
            background-color: #f8fafc;
            border-radius: var(--radius-sm);
            text-decoration: none;
            color: var(--text-primary);
            transition: all 0.2s;
        }

        .quick-action-btn:hover {
            background-color: #e5f3ff;
            color: var(--primary);
        }

        .quick-action-btn i {
            width: 24px;
            height: 24px;
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: #e0f2fe;
            border-radius: 50%;
            color: var(--primary);
        }

        /* 页脚 */
        .footer {
            background-color: var(--bg-white);
            padding: 2rem 20px;
            text-align: center;
            border-top: 1px solid var(--border);
            margin-top: 2rem;
        }

        .footer p {
            color: var(--text-secondary);
            font-size: 0.9rem;
        }

        /* 响应式设计 */
        @media (max-width: 768px) {
            .header-container {
                flex-direction: column;
                align-items: stretch;
            }

            .nav-links {
                order: 3;
                justify-content: flex-start;
                overflow-x: auto;
                padding-bottom: 5px;
                margin-top: 10px;
            }

            .search-bar {
                order: 4;
                margin-top: 10px;
            }

            .user-controls {
                order: 2;
                justify-content: flex-end;
            }

            .post-table {
                display: none;
            }

            .mobile-post-list {
                display: flex;
            }

            .post-manage-header {
                flex-direction: column;
                align-items: flex-start;
            }

            .post-filter {
                width: 100%;
                overflow-x: auto;
                padding-bottom: 5px;
            }
        }

        @media (max-width: 576px) {
            .section-header {
                flex-direction: column;
                align-items: flex-start;
            }
        }
    </style>
</head>
<body>
<!-- 头部导航 -->
<header class="forum-header">
    <div class="header-container">
        <a href="#" class="logo">
            <img alt="Logo" src="https://storage.googleapis.com/a1aa/image/VjQYiiPK2c51Blh2a9ixpR4nZVO3GeJ4b6twzmeF0FEeBzynA.jpg" />
            <span>BBS论坛</span>
        </a>

        <nav class="nav-links">
            <a href="${pageContext.request.contextPath}/post/home" class="active">首页</a>
            <a href="#">待拓展</a>
            <a href="#">待拓展</a>
            <a href="#">待拓展</a>
        </nav>

        <c:if test="${false}">
            <div class="search-bar">
                <input type="text" placeholder="搜索内容..." />
                <button><i class="fas fa-search"></i></button>
            </div>
        </c:if>

        <div class="user-controls">
            <c:choose>
                <c:when test="${empty sessionScope.user}">
                    <div class="auth-buttons">
                        <a href="${pageContext.request.contextPath}/user/login" class="auth-btn login-btn">登录</a>
                        <a href="${pageContext.request.contextPath}/user/register" class="auth-btn register-btn">注册</a>
                    </div>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/post/toAddPost" class="post-btn">
                        <i class="fas fa-plus"></i> 发布文章
                    </a>
                    <div class="user-profile" id="user-profile">
                        <img class="user-avatar" id="user-avatar"
                             src="${sessionScope.user.avatarUrl != null && sessionScope.user.avatarUrl !='' ? sessionScope.user.avatarUrl : 'https://ui-avatars.com/api/?name=' += sessionScope.user.username += '&background=random'}"
                             alt="用户头像" />
                        <span class="user-name" id="user-name">${sessionScope.user.username}</span>

                        <div class="profile-menu" id="profile-menu">
                            <a href="${pageContext.request.contextPath}/user/post">
                                <i class="fas fa-folder"></i> 我的文章
                            </a>
                            <a href="${pageContext.request.contextPath}/user/profile">
                                <i class="fas fa-user-circle"></i> 个人资料
                            </a>
                            <a href="${pageContext.request.contextPath}/reply/home">
                                <i class="fas-solid fa-envelope"></i> 我的留言
                            </a>
                            </a>
                            <a href="${pageContext.request.contextPath}/user/settings">
                                <i class="fas fa-cog"></i> 设置
                            </a>
                            <a href="${pageContext.request.contextPath}/user/logout">
                                <i class="fas fa-sign-out-alt"></i> 登出
                            </a>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</header>
<!-- 主内容区 -->
<div class="main-container">
    <!-- 左侧内容区 -->
    <div class="content-section">
        <div class="section-header">
            <h2 class="section-title">
                <i class="fas fa-file-alt"></i> 我的文章
            </h2>
            <div class="post-count">
                共 8 篇文章
            </div>
        </div>

        <div class="post-manage-header">
            <div class="action-buttons">
                <button class="action-btn new-post-btn">
                    <i class="fas fa-plus"></i> 新建文章
                </button>
                <button class="action-btn bulk-action-btn">
                    <i class="fas fa-trash-alt"></i> 批量删除
                </button>
                <button class="action-btn bulk-action-btn">
                    <i class="fas fa-file-export"></i> 导出
                </button>
            </div>

            <div class="post-filter">
                <button class="filter-btn active">全部文章</button>
                <button class="filter-btn">已发布</button>
                <button class="filter-btn">草稿</button>
                <button class="filter-btn">热门</button>
            </div>
        </div>

        <!-- 桌面端表格视图 -->
        <table class="post-table">
            <thead>
            <tr>
                <th style="width: 40px"><input type="checkbox" class="post-checkbox"></th>
                <th>文章标题</th>
                <th style="width: 120px">状态</th>
                <th style="width: 150px">发布时间</th>
                <th style="width: 100px">操作</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td><input type="checkbox" class="post-checkbox"></td>
                <td>
                    <div class="post-title-cell">
                        <div class="post-cover">
                            <img src="https://storage.googleapis.com/a1aa/image/0O3NJCVNOD5iDZ71ihxDQgy1P6f5eqcGWHuOlCoA4kYAhZ5TA.jpg" alt="文章封面">
                        </div>
                        <div class="post-title-wrapper">
                            <div class="post-title">VMOS Pro v2.9.5安卓虚拟机安装与使用教程</div>
                            <div class="post-excerpt">详细讲解如何在安卓设备上安装和使用VMOS Pro虚拟机</div>
                        </div>
                    </div>
                </td>
                <td><span class="post-status status-published">已发布</span></td>
                <td>
                    <div class="post-meta-item">
                        <i class="far fa-calendar"></i> 2023-11-15
                    </div>
                </td>
                <td>
                    <div class="post-actions">
                        <div class="action-icon edit-action">
                            <i class="fas fa-edit"></i>
                        </div>
                        <div class="action-icon delete-action">
                            <i class="fas fa-trash-alt"></i>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td><input type="checkbox" class="post-checkbox"></td>
                <td>
                    <div class="post-title-cell">
                        <div class="post-cover">
                            <i class="fas fa-image fa-lg"></i>
                        </div>
                        <div class="post-title-wrapper">
                            <div class="post-title">2024年最佳安卓应用推荐TOP10</div>
                            <div class="post-excerpt">精选2024年最值得安装的安卓应用，提升您的手机使用体验</div>
                        </div>
                    </div>
                </td>
                <td><span class="post-status status-published">已发布</span></td>
                <td>
                    <div class="post-meta-item">
                        <i class="far fa-calendar"></i> 2023-11-08
                    </div>
                </td>
                <td>
                    <div class="post-actions">
                        <div class="action-icon edit-action">
                            <i class="fas fa-edit"></i>
                        </div>
                        <div class="action-icon delete-action">
                            <i class="fas fa-trash-alt"></i>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td><input type="checkbox" class="post-checkbox"></td>
                <td>
                    <div class="post-title-cell">
                        <div class="post-cover">
                            <img src="https://storage.googleapis.com/a1aa/image/0O3NJCVNOD5iDZ71ihxDQgy1P6f5eqcGWHuOlCoA4kYAhZ5TA.jpg" alt="文章封面">
                        </div>
                        <div class="post-title-wrapper">
                            <div class="post-title">ChatGPT 4.0 最新汉化版下载与使用教程</div>
                            <div class="post-excerpt">最新ChatGPT 4.0汉化版安装指南及使用技巧分享</div>
                        </div>
                    </div>
                </td>
                <td><span class="post-status status-published">已发布</span></td>
                <td>
                    <div class="post-meta-item">
                        <i class="far fa-calendar"></i> 2023-10-25
                    </div>
                </td>
                <td>
                    <div class="post-actions">
                        <div class="action-icon edit-action">
                            <i class="fas fa-edit"></i>
                        </div>
                        <div class="action-icon delete-action">
                            <i class="fas fa-trash-alt"></i>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td><input type="checkbox" class="post-checkbox"></td>
                <td>
                    <div class="post-title-cell">
                        <div class="post-cover">
                            <i class="fas fa-image fa-lg"></i>
                        </div>
                        <div class="post-title-wrapper">
                            <div class="post-title">Stream 视频平台汉化指南与资源分享</div>
                            <div class="post-excerpt">如何汉化Stream视频平台并获取优质资源</div>
                        </div>
                    </div>
                </td>
                <td><span class="post-status status-draft">草稿</span></td>
                <td>
                    <div class="post-meta-item">
                        <i class="far fa-calendar"></i> 2023-10-18
                    </div>
                </td>
                <td>
                    <div class="post-actions">
                        <div class="action-icon edit-action">
                            <i class="fas fa-edit"></i>
                        </div>
                        <div class="action-icon delete-action">
                            <i class="fas fa-trash-alt"></i>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td><input type="checkbox" class="post-checkbox"></td>
                <td>
                    <div class="post-title-cell">
                        <div class="post-cover">
                            <img src="https://storage.googleapis.com/a1aa/image/0O3NJCVNOD5iDZ71ihxDQgy1P6f5eqcGWHuOlCoA4kYAhZ5TA.jpg" alt="文章封面">
                        </div>
                        <div class="post-title-wrapper">
                            <div class="post-title">Solid Explorer 文件管理器专业版功能详解</div>
                            <div class="post-excerpt">全面解析Solid Explorer专业版的功能和使用技巧</div>
                        </div>
                    </div>
                </td>
                <td><span class="post-status status-published">已发布</span></td>
                <td>
                    <div class="post-meta-item">
                        <i class="far fa-calendar"></i> 2023-10-05
                    </div>
                </td>
                <td>
                    <div class="post-actions">
                        <div class="action-icon edit-action">
                            <i class="fas fa-edit"></i>
                        </div>
                        <div class="action-icon delete-action">
                            <i class="fas fa-trash-alt"></i>
                        </div>
                    </div>
                </td>
            </tr>
            </tbody>
        </table>

        <!-- 移动端卡片视图 -->
        <div class="mobile-post-list">
            <div class="mobile-post-card">
                <div class="mobile-post-header">
                    <input type="checkbox" class="post-checkbox">
                    <span class="post-status status-published">已发布</span>
                </div>
                <div class="mobile-post-title">VMOS Pro v2.9.5安卓虚拟机安装与使用教程</div>
                <div class="mobile-post-cover">
                    <img src="https://storage.googleapis.com/a1aa/image/0O3NJCVNOD5iDZ71ihxDQgy1P6f5eqcGWHuOlCoA4kYAhZ5TA.jpg" alt="文章封面">
                </div>
                <div class="mobile-post-meta">
                    <div class="post-meta-item">
                        <i class="far fa-calendar"></i> 2023-11-15
                    </div>
                    <div class="post-meta-item">
                        <i class="far fa-eye"></i> 1.2k
                    </div>
                    <div class="post-meta-item">
                        <i class="far fa-comment"></i> 24
                    </div>
                </div>
                <div class="mobile-post-footer">
                    <div class="mobile-post-actions">
                        <div class="action-icon edit-action">
                            <i class="fas fa-edit"></i>
                        </div>
                        <div class="action-icon delete-action">
                            <i class="fas fa-trash-alt"></i>
                        </div>
                    </div>
                </div>
            </div>

            <div class="mobile-post-card">
                <div class="mobile-post-header">
                    <input type="checkbox" class="post-checkbox">
                    <span class="post-status status-draft">草稿</span>
                </div>
                <div class="mobile-post-title">Stream 视频平台汉化指南与资源分享</div>
                <div class="mobile-post-cover">
                    <i class="fas fa-image fa-3x"></i>
                </div>
                <div class="mobile-post-meta">
                    <div class="post-meta-item">
                        <i class="far fa-calendar"></i> 2023-10-18
                    </div>
                    <div class="post-meta-item">
                        <i class="far fa-eye"></i> 0
                    </div>
                    <div class="post-meta-item">
                        <i class="far fa-comment"></i> 0
                    </div>
                </div>
                <div class="mobile-post-footer">
                    <div class="mobile-post-actions">
                        <div class="action-icon edit-action">
                            <i class="fas fa-edit"></i>
                        </div>
                        <div class="action-icon delete-action">
                            <i class="fas fa-trash-alt"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- 分页控件 -->
        <div class="pagination">
            <a href="#">
                <i class="fas fa-chevron-left"></i>
            </a>
            <span>1</span>
            <a href="#">2</a>
            <a href="#">3</a>
            <a href="#">
                <i class="fas fa-chevron-right"></i>
            </a>
        </div>
    </div>

    <!-- 侧边栏 -->
    <div class="sidebar">
        <!-- 用户统计 -->
        <div class="widget">
            <div class="widget-header">
                <i class="fas fa-chart-line"></i> 文章统计
            </div>
            <div class="widget-content">
                <div class="stats-grid">
                    <div class="stat-card">
                        <i class="fas fa-file-alt fa-2x" style="color: #4361ee;"></i>
                        <div class="stat-value">8</div>
                        <div class="stat-label">总文章数</div>
                    </div>
                    <div class="stat-card">
                        <i class="fas fa-eye fa-2x" style="color: #10b981;"></i>
                        <div class="stat-value">4.8K</div>
                        <div class="stat-label">总阅读量</div>
                    </div>
                    <div class="stat-card">
                        <i class="fas fa-comment fa-2x" style="color: #f59e0b;"></i>
                        <div class="stat-value">124</div>
                        <div class="stat-label">总评论数</div>
                    </div>
                    <div class="stat-card">
                        <i class="fas fa-heart fa-2x" style="color: #ef4444;"></i>
                        <div class="stat-value">326</div>
                        <div class="stat-label">总点赞数</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- 快捷操作 -->
        <div class="widget">
            <div class="widget-header">
                <i class="fas fa-bolt"></i> 快捷操作
            </div>
            <div class="widget-content">
                <div class="quick-actions">
                    <a href="#" class="quick-action-btn">
                        <i class="fas fa-plus"></i>
                        <span>新建文章</span>
                    </a>
                    <a href="#" class="quick-action-btn">
                        <i class="fas fa-folder-open"></i>
                        <span>管理草稿</span>
                    </a>
                    <a href="#" class="quick-action-btn">
                        <i class="fas fa-chart-bar"></i>
                        <span>文章分析</span>
                    </a>
                    <a href="#" class="quick-action-btn">
                        <i class="fas fa-cog"></i>
                        <span>发布设置</span>
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- 页脚 -->
<footer class="footer">
    <p>Copyright © 2025 Powered by BBS论坛</p>
</footer>

<script>
    // 用户菜单切换
    document.getElementById('user-profile').addEventListener('click', function(e) {
        e.stopPropagation();
        const menu = document.getElementById('profile-menu');
        menu.classList.toggle('show');
    });

    // 点击页面其他区域关闭菜单
    document.addEventListener('click', function(e) {
        const menu = document.getElementById('profile-menu');
        if (menu.classList.contains('show')) {
            menu.classList.remove('show');
        }
    });

    // 阻止菜单内部点击事件冒泡
    document.getElementById('profile-menu').addEventListener('click', function(e) {
        e.stopPropagation();
    });

    // 筛选按钮切换
    document.querySelectorAll('.filter-btn').forEach(button => {
        button.addEventListener('click', function() {
            document.querySelectorAll('.filter-btn').forEach(btn => {
                btn.classList.remove('active');
            });
            this.classList.add('active');
        });
    });

    // 操作按钮提示
    document.querySelectorAll('.action-icon').forEach(icon => {
        icon.addEventListener('click', function(e) {
            e.stopPropagation();
            const action = this.classList.contains('edit-action') ? '编辑' : '删除';
            alert(`您点击了${action}操作`);
        });
    });

    // 表格行点击事件
    document.querySelectorAll('.post-table tbody tr').forEach(row => {
        row.addEventListener('click', function(e) {
            if (!e.target.closest('.post-checkbox') && !e.target.closest('.action-icon')) {
                alert('进入文章编辑页面');
            }
        });
    });
</script>
</body>
</html>
