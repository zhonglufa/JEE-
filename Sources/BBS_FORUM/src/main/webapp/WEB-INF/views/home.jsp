<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>落花爱看繁星 - BBS论坛</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+SC:wght@400;500;700&display=swap" rel="stylesheet"/>
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

        /*.nav-links a.active::after {*/
        /*    content: '';*/
        /*    position: absolute;*/
        /*    bottom: 0;*/
        /*    left: 0.5rem;*/
        /*    width: calc(100% - 1rem);*/
        /*    height: 2px;*/
        /*    background: white;*/
        /*}*/
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

        .auth-buttons {
            display: flex;
            gap: 0.8rem;
        }

        .auth-btn {
            padding: 0.6rem 1rem;
            border-radius: var(--radius-sm);
            font-size: 0.9rem;
            font-weight: 500;
            text-decoration: none;
            transition: all 0.2s;
        }

        .login-btn {
            background-color: transparent;
            border: 1px solid rgba(255, 255, 255, 0.5);
            color: white;
        }

        .login-btn:hover {
            background-color: rgba(255, 255, 255, 0.1);
        }

        .register-btn {
            background-color: white;
            border: 1px solid white;
            color: var(--primary);
        }

        .register-btn:hover {
            background-color: rgba(255, 255, 255, 0.9);
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

        .filter-options {
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
        }

        .filter-btn {
            background: none;
            border: none;
            color: var(--text-secondary);
            font-size: 0.9rem;
            font-weight: 500;
            padding: 0.3rem 0.5rem;
            cursor: pointer;
            transition: color 0.2s;
            position: relative;
        }

        .filter-btn.active {
            color: var(--primary);
            font-weight: 600;
        }

        .filter-btn.active::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100%;
            height: 2px;
            background-color: var(--primary);
        }

        .post-list {
            list-style: none;
        }

        .post-card {
            padding: 1.5rem;
            border-bottom: 1px solid var(--border);
            transition: background-color 0.2s;
            cursor: pointer;
            display: flex;
            gap: 1.5rem;
        }

        .post-card:hover {
            background-color: #f9fafb;
        }

        .post-cover {
            flex-shrink: 0;
            width: 120px;
            height: 80px;
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
            transition: transform 0.3s;
        }

        .post-card:hover .post-cover img {
            transform: scale(1.05);
        }

        .post-content {
            flex: 1;
        }

        .post-title {
            font-size: 1.1rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
            color: var(--text-primary);
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .post-excerpt {
            font-size: 0.95rem;
            color: var(--text-secondary);
            margin-bottom: 0.8rem;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .post-meta {
            display: flex;
            flex-wrap: wrap;
            gap: 1rem;
            font-size: 0.85rem;
            color: var(--text-secondary);
        }

        .post-meta-item {
            display: flex;
            align-items: center;
            gap: 0.4rem;
        }

        .post-tags {
            display: flex;
            flex-wrap: wrap;
            gap: 0.5rem;
            margin-top: 0.5rem;
        }

        .post-tag {
            background-color: #e5f3ff;
            color: var(--primary);
            border-radius: 50px;
            padding: 0.25rem 0.8rem;
            font-size: 0.8rem;
            font-weight: 500;
        }

        .post-tag.hot {
            background-color: #ffe5e5;
            color: var(--secondary);
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

        .hot-post {
            display: flex;
            gap: 1rem;
            margin-bottom: 1.5rem;
        }

        .hot-post:last-child {
            margin-bottom: 0;
        }

        .hot-post-img {
            flex-shrink: 0;
            width: 80px;
            height: 60px;
            border-radius: var(--radius-sm);
            overflow: hidden;
            background-color: #f1f1f1;
        }

        .hot-post-img img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .hot-post-title {
            font-size: 0.95rem;
            font-weight: 500;
            margin-bottom: 0.3rem;
            color: var(--text-primary);
        }

        .hot-post-meta {
            font-size: 0.8rem;
            color: var(--text-secondary);
        }

        .recommended-list {
            list-style: none;
        }

        .recommended-item {
            padding: 0.8rem 0;
            border-bottom: 1px solid var(--border);
        }

        .recommended-item:last-child {
            border-bottom: none;
        }

        .recommended-item a {
            text-decoration: none;
            color: var(--text-primary);
            font-size: 0.95rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            transition: color 0.2s;
        }

        .recommended-item a:hover {
            color: var(--primary);
        }

        .recommended-item a::before {
            content: '•';
            color: var(--primary);
        }

        .tag-cloud {
            display: flex;
            flex-wrap: wrap;
            gap: 0.5rem;
        }

        .tag {
            background-color: #f1f5f9;
            color: var(--text-primary);
            border-radius: 50px;
            padding: 0.4rem 0.9rem;
            font-size: 0.85rem;
            text-decoration: none;
            transition: all 0.2s;
        }

        .tag:hover {
            background-color: var(--primary);
            color: white;
            transform: translateY(-2px);
        }

        /* 分页 */
        .pagination {
            display: flex;
            justify-content: center;
            padding: 1.5rem;
        }

        .pagination a, .pagination span {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 36px;
            height: 36px;
            margin: 0 4px;
            border-radius: 50%;
            text-decoration: none;
            font-size: 0.95rem;
            font-weight: 500;
            transition: all 0.2s;
        }

        .pagination a {
            color: var(--text-primary);
            background-color: var(--bg-white);
            border: 1px solid var(--border);
        }

        .pagination a:hover {
            background-color: var(--primary);
            color: white;
            border-color: var(--primary);
        }

        .pagination span {
            background-color: var(--primary);
            color: white;
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

            .post-card {
                flex-direction: column;
                gap: 1rem;
            }

            .post-cover {
                width: 100%;
                height: 160px;
            }
        }

        @media (max-width: 576px) {
            .section-header {
                flex-direction: column;
                align-items: flex-start;
            }

            .filter-options {
                width: 100%;
                overflow-x: auto;
                padding-bottom: 5px;
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


        <form action="${pageContext.request.contextPath}/post/home" method="get">
        <div class="search-bar">
                <input type="text" name="keyword" placeholder="搜索内容..." value="${param.keyword}" />
                <button type="submit"><i class="fas fa-search"></i></button>
        </div>
        </form>


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
                            <a href="${pageContext.request.contextPath}/user/post/${user.userId}">
                                <i class="fas fa-folder"></i> 我的文章
                            </a>
                            <a href="${pageContext.request.contextPath}/user/profile">
                                <i class="fas fa-user-circle"></i> 个人资料
                            </a>
                            <a href="${pageContext.request.contextPath}/reply/home">
                                <i class="fas-solid fa-envelope"></i> 我的留言
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
                <i class="fas fa-fire"></i> 最新发布
            </h2>
            <div class="filter-options">
                <button class="filter-btn active">最新</button>
                <button class="filter-btn">热门</button>
                <button class="filter-btn">推荐</button>
                <button class="filter-btn">浏览</button>
                <button class="filter-btn">点赞</button>
                <button class="filter-btn">评论</button>
            </div>
        </div>

        <ul class="post-list">
            <c:forEach var="post" items="${postList}">
                <li class="post-card" onclick="window.location.href='${pageContext.request.contextPath}/post/detail/${post.postId}'">
                    <div class="post-cover">
                        <c:choose>
                            <c:when test="${not empty post.coverImage}">
                                <img src="data:image/jpeg;base64,${post.coverImage}" alt="文章封面" />
                            </c:when>
                            <c:otherwise>
                                <i class="fas fa-image fa-2x"></i>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <div class="post-content">
                        <h3 class="post-title">${post.title}</h3>
                        <p class="post-excerpt">${post.content}</p>

                        <div class="post-meta">
                            <div class="post-meta-item">
                                <i class="fas fa-user"></i> 波仔
                            </div>
                            <div class="post-meta-item">
                                <i class="fas fa-clock"></i> 7个月前
                            </div>
                            <div class="post-meta-item">
                                <i class="fas fa-comment"></i> 0
                            </div>
                            <div class="post-meta-item">
                                <i class="fas fa-eye"></i> 83
                            </div>
                            <div class="post-meta-item">
                                <i class="fas fa-thumbs-up"></i> 10
                            </div>
                        </div>

                        <div class="post-tags">
                            <span class="post-tag">免费资源</span>
                            <span class="post-tag">安卓应用</span>
                            <span class="post-tag">文件管理</span>
                        </div>
                    </div>
                </li>
            </c:forEach>
        </ul>

        <!-- 分页控件 -->
        <div class="pagination">
            <c:if test="${currentPage > 1}">
                <a href="${pageContext.request.contextPath}/post/home?page=${currentPage - 1}&pageSize=${pageSize}&keyword=${param.keyword}">
                    <i class="fas fa-chevron-left"></i>
                </a>
            </c:if>

            <c:forEach begin="1" end="${totalPages}" var="i">
                <c:choose>
                    <c:when test="${i == currentPage}">
                        <span>${i}</span>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/post/home?page=${i}&pageSize=${pageSize}&keyword=${param.keyword}">${i}</a>
                    </c:otherwise>
                </c:choose>
            </c:forEach>

            <c:if test="${currentPage < totalPages}">
                <a href="${pageContext.request.contextPath}/post/home?page=${currentPage + 1}&pageSize=${pageSize}&keyword=${param.keyword}">
                    <i class="fas fa-chevron-right"></i>
                </a>
            </c:if>
        </div>
    </div>

    <!-- 侧边栏 -->
    <div class="sidebar">
        <!-- 最热文章 -->
        <div class="widget">
            <div class="widget-header">
                <i class="fas fa-chart-line"></i> 最热文章
            </div>
            <div class="widget-content">
                <div class="hot-post">
                    <div class="hot-post-img">
                        <img src="https://storage.googleapis.com/a1aa/image/0O3NJCVNOD5iDZ71ihxDQgy1P6f5eqcGWHuOlCoA4kYAhZ5TA.jpg" alt="热门文章">
                    </div>
                    <div>
                        <div class="hot-post-title">VMOS Pro v2.9.5安卓虚拟机...</div>
                        <div class="hot-post-meta">
                            <span><i class="fas fa-eye"></i> 1.2k</span>
                            <span><i class="fas fa-thumbs-up"></i> 245</span>
                        </div>
                    </div>
                </div>

                <div class="hot-post">
                    <div class="hot-post-img">
                        <img src="https://via.placeholder.com/80x60" alt="热门文章">
                    </div>
                    <div>
                        <div class="hot-post-title">Solid Explorer 文件管理器专业版</div>
                        <div class="hot-post-meta">
                            <span><i class="fas fa-eye"></i> 980</span>
                            <span><i class="fas fa-thumbs-up"></i> 187</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- 文章推荐 -->
        <div class="widget">
            <div class="widget-header">
                <i class="fas fa-star"></i> 文章推荐
            </div>
            <div class="widget-content">
                <ul class="recommended-list">
                    <li class="recommended-item">
                        <a href="#">ChatGPT 4.0 最新汉化版下载与使用教程</a>
                    </li>
                    <li class="recommended-item">
                        <a href="#">Stream 视频平台汉化指南与资源分享</a>
                    </li>
                    <li class="recommended-item">
                        <a href="#">2024年最佳安卓应用推荐TOP10</a>
                    </li>
                    <li class="recommended-item">
                        <a href="#">论坛新手指南：如何快速升级和获得积分</a>
                    </li>
                    <li class="recommended-item">
                        <a href="#">开发者专栏：从零开始学习Java编程</a>
                    </li>
                </ul>
            </div>
        </div>

        <!-- 标签云 -->
        <div class="widget">
            <div class="widget-header">
                <i class="fas fa-tags"></i> 标签云
            </div>
            <div class="widget-content">
                <div class="tag-cloud">
                    <a href="#" class="tag">安卓应用</a>
                    <a href="#" class="tag">汉化</a>
                    <a href="#" class="tag">ChatGPT</a>
                    <a href="#" class="tag">Stream</a>
                    <a href="#" class="tag">免费资源</a>
                    <a href="#" class="tag">文件管理</a>
                    <a href="#" class="tag">虚拟机</a>
                    <a href="#" class="tag">开发</a>
                    <a href="#" class="tag">教程</a>
                    <a href="#" class="tag">论坛</a>
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
</script>
</body>
</html>