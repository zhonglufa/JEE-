<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${post.title} - BBS论坛</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+SC:wght@400;500;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #4361ee;
            --primary-dark: #3a56d4;
            --secondary: #ff5a5f;
            --secondary-dark: #e04b53;
            --text-primary: #2d3748;
            --text-secondary: #718096;
            --bg-light: #f8fafc;
            --bg-white: #ffffff;
            --border: #e2e8f0;
            --success: #10b981;
            --shadow-sm: 0 1px 3px rgba(0, 0, 0, 0.05), 0 1px 2px rgba(0, 0, 0, 0.1);
            --shadow-md: 0 4px 6px -1px rgba(0, 0, 0, 0.05), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
            --shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.05), 0 4px 6px -2px rgba(0, 0, 0, 0.03);
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

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
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

            .post-meta {
                gap: 1rem;
            }

            .post-footer {
                flex-direction: column;
                gap: 1rem;
                align-items: flex-start;
            }

            .comment-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 0.75rem;
            }

            .comment-content {
                padding-left: 0;
                padding-top: 0.75rem;
            }

            .comment-author {
                width: 100%;
            }
        }

        @media (max-width: 480px) {
            .post-actions {
                width: 100%;
                justify-content: space-between;
                gap: 0.5rem;
            }

            .action-btn {
                padding: 0.5rem;
                font-size: 0.85rem;
            }

            .action-btn span {
                display: none;
            }
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










        /* 主内容区域 */
        .post-detail {
            background-color: var(--bg-white);
            border-radius: var(--radius);
            box-shadow: var(--shadow-sm);
            overflow: hidden;
            margin-bottom: 2rem;
        }

        .post-header {
            padding: 1.5rem;
            border-bottom: 1px solid var(--border);
            background-color: #f9fafb;
        }

        .post-title {
            font-size: 1.75rem;
            font-weight: 700;
            margin-bottom: 0.75rem;
            color: var(--text-primary);
            line-height: 1.3;
        }

        .post-meta {
            display: flex;
            gap: 1.5rem;
            color: var(--text-secondary);
            font-size: 0.9rem;
            align-items: center;
            flex-wrap: wrap;
        }

        .post-meta-item {
            display: flex;
            align-items: center;
            gap: 0.4rem;
        }

        .post-content {
            padding: 1.5rem;
            font-size: 1.05rem;
            line-height: 1.8;
            color: var(--text-primary);
        }

        .post-content p {
            margin-bottom: 1.2rem;
        }

        .post-image {
            max-width: 100%;
            height: auto;
            margin: 1.5rem 0;
            border-radius: var(--radius-sm);
            box-shadow: var(--shadow-sm);
            display: block;
        }

        .post-footer {
            padding: 1.2rem 1.5rem;
            border-top: 1px solid var(--border);
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #f9fafb;
        }

        .post-actions {
            display: flex;
            gap: 1rem;
        }

        .action-btn {
            background: none;
            border: none;
            color: var(--text-secondary);
            display: flex;
            align-items: center;
            gap: 0.4rem;
            padding: 0.5rem 1rem;
            border-radius: 50px;
            cursor: pointer;
            transition: all 0.2s;
            font-weight: 500;
        }

        .action-btn:hover {
            background-color: #edf2f7;
            color: var(--primary);
        }

        .action-btn.liked {
            color: var(--secondary);
        }

        /* 评论区域 */
        .comment-section {
            background-color: var(--bg-white);
            border-radius: var(--radius);
            box-shadow: var(--shadow-sm);
            overflow: hidden;
            padding: 0;
        }

        .section-header {
            padding: 1.25rem 1.5rem;
            background-color: #f9fafb;
            border-bottom: 1px solid var(--border);
            font-size: 1.25rem;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .comment-form {
            padding: 1.5rem;
            border-bottom: 1px solid var(--border);
        }

        .form-group {
            margin-bottom: 1rem;
        }

        .form-control {
            width: 100%;
            padding: 0.85rem;
            border: 1px solid var(--border);
            border-radius: var(--radius-sm);
            font-family: inherit;
            font-size: 1rem;
            transition: border-color 0.2s, box-shadow 0.2s;
            resize: vertical;
            min-height: 120px;
        }

        .form-control:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(66, 153, 225, 0.15);
        }

        .btn {
            background-color: var(--primary);
            color: white;
            border: none;
            padding: 0.75rem 1.75rem;
            border-radius: var(--radius-sm);
            font-size: 1rem;
            font-weight: 500;
            cursor: pointer;
            transition: background-color 0.2s, transform 0.1s;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .btn:hover {
            background-color: var(--primary-dark);
        }

        .btn:active {
            transform: translateY(1px);
        }

        .btn-secondary {
            background-color: var(--secondary);
        }

        .btn-secondary:hover {
            background-color: var(--secondary-dark);
        }

        /* 评论列表 */
        .comments-list {
            list-style: none;
            padding: 0;
        }

        .comment-item {
            padding: 1.5rem;
            border-bottom: 1px solid var(--border);
            transition: background-color 0.2s;
        }

        .comment-item:last-child {
            border-bottom: none;
        }

        .comment-item:hover {
            background-color: #f9fafb;
        }

        .comment-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 0.75rem;
        }

        .comment-author {
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .avatar {
            width: 36px;
            height: 36px;
            border-radius: 50%;
            background: linear-gradient(45deg, var(--primary), #4895ef);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
            font-size: 0.9rem;
        }

        .author-info {
            display: flex;
            flex-direction: column;
        }

        .author-name {
            font-weight: 600;
            color: var(--text-primary);
        }

        .comment-date {
            font-size: 0.85rem;
            color: var(--text-secondary);
        }

        .comment-actions {
            display: flex;
            gap: 0.75rem;
        }

        .comment-action {
            background: none;
            border: none;
            color: var(--text-secondary);
            cursor: pointer;
            font-size: 0.9rem;
            transition: color 0.2s;
            padding: 0.25rem;
        }

        .comment-action:hover {
            color: var(--primary);
        }

        .comment-action.delete:hover {
            color: var(--secondary);
        }

        .comment-content {
            padding-left: 50px;
            color: var(--text-primary);
            line-height: 1.7;
        }

        .empty-state {
            padding: 3rem 1.5rem;
            text-align: center;
            color: var(--text-secondary);
        }

        .empty-state i {
            font-size: 3rem;
            margin-bottom: 1rem;
            opacity: 0.5;
        }

        .empty-state p {
            font-size: 1.1rem;
        }






        /* 新增回复区域样式 */
        .replies-list {
            list-style: none;
            padding-left: 50px;
            margin-top: 1rem;
            display: none; /* 默认隐藏回复列表 */
        }

        .replies-list.show {
            display: block; /* 显示回复列表 */
            animation: fadeIn 0.3s ease;
        }

        .reply-item {
            background-color: #f9fafb;
            border-radius: var(--radius-sm);
            padding: 1rem;
            margin-bottom: 0.75rem;
            position: relative;
            transition: all 0.3s ease;
            border-left: 3px solid var(--primary);
        }

        .reply-item:hover {
            background-color: #f1f5f9;
            transform: translateX(5px);
        }

        .reply-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 0.5rem;
        }

        .reply-author {
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .reply-avatar {
            width: 28px;
            height: 28px;
            border-radius: 50%;
            background: linear-gradient(45deg, var(--primary), #4895ef);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 500;
            font-size: 0.8rem;
        }

        .reply-author-name {
            font-weight: 600;
            color: var(--text-primary);
            font-size: 0.9rem;
        }

        .reply-date {
            font-size: 0.75rem;
            color: var(--text-secondary);
        }

        .reply-content {
            color: var(--text-primary);
            line-height: 1.6;
            font-size: 0.95rem;
            padding-left: 36px;
        }

        .reply-form, .reply-to-reply-form {
            margin-top: 1rem;
            padding: 1rem;
            background-color: #f8fafc;
            border-radius: var(--radius-sm);
            border: 1px solid var(--border);
            display: none; /* 初始隐藏 */
            animation: fadeIn 0.3s ease;
        }

        .reply-form.show, .reply-to-reply-form.show {
            display: block; /* 显示回复表单 */
        }

        .reply-form textarea, .reply-to-reply-form textarea {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid var(--border);
            border-radius: var(--radius-sm);
            font-family: inherit;
            font-size: 0.95rem;
            resize: vertical;
            min-height: 80px;
            transition: border-color 0.2s, box-shadow 0.2s;
        }

        .reply-form textarea:focus, .reply-to-reply-form textarea:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(66, 153, 225, 0.15);
        }

        .reply-form-actions {
            display: flex;
            justify-content: flex-end;
            gap: 0.5rem;
            margin-top: 0.75rem;
        }

        .reply-form-btn {
            padding: 0.5rem 1rem;
            border-radius: var(--radius-sm);
            font-size: 0.9rem;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.2s;
            display: inline-flex;
            align-items: center;
            gap: 0.4rem;
        }

        .reply-submit {
            background-color: var(--primary);
            color: white;
            border: none;
        }

        .reply-submit:hover {
            background-color: var(--primary-dark);
        }

        .reply-cancel {
            background-color: transparent;
            border: 1px solid var(--border);
            color: var(--text-secondary);
        }

        .reply-cancel:hover {
            background-color: #edf2f7;
        }

        .show-replies {
            display: flex;
            align-items: center;
            gap: 0.4rem;
            color: var(--primary);
            font-size: 0.85rem;
            margin-top: 0.5rem;
            cursor: pointer;
            padding: 0.3rem 0;
            width: fit-content;
        }

        .show-replies:hover {
            text-decoration: underline;
        }

        .show-replies i {
            transition: transform 0.3s;
        }

        .show-replies .fa-chevron-down {
            transform: rotate(0deg);
        }

        .show-replies .fa-chevron-up {
            transform: rotate(180deg);
        }

        /* 动画效果 */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* 响应式调整 */
        @media (max-width: 768px) {
            .replies-list {
                padding-left: 20px;
            }

            .reply-content {
                padding-left: 0;
            }

            .reply-item {
                border-left: 2px solid var(--primary);
                padding: 0.75rem;
            }
        }

        @media (max-width: 480px) {
            .replies-list {
                padding-left: 10px;
            }

            .reply-form, .reply-to-reply-form {
                padding: 0.75rem;
            }

            .reply-form-actions {
                flex-direction: column;
            }

            .reply-form-btn {
                width: 100%;
                justify-content: center;
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
<div class="container">
    <div class="post-detail" data-post-id="${post.postId}">
        <!-- 文章头部 -->
        <div class="post-header">
            <h1 class="post-title">${post.title}</h1>
            <div class="post-meta">
                <div class="post-meta-item">
                    <i class="fas fa-user"></i>
                    <span>作者: 技术达人</span>
                </div>
                <div class="post-meta-item">
                    <i class="far fa-clock"></i>
                    <span><fmt:formatDate value="${post.createdAt}" pattern="yyyy-MM-dd HH:mm" /></span>
                </div>
                <div class="post-meta-item">
                    <i class="fas fa-eye"></i>
                    <span>${post.views}次浏览</span>
                </div>
                <div class="post-meta-item">
                    <i class="fas fa-comments"></i>
                    <span>${post.commentCount}条评论</span>
                </div>
            </div>
        </div>

        <!-- 文章内容 -->
        <div class="post-content">
            <c:if test="${not empty post.coverImage}">
                <img class="post-image" src="data:image/jpeg;base64,${post.coverImage}" alt="文章封面">
            </c:if>
          <p>${post.content}</p>
        </div>

        <!-- 文章底部 -->
        <div class="post-footer">
            <div class="post-actions">
                <button class="action-btn">
                    <i class="far fa-thumbs-up"></i>
                    <span>点赞 (${post.likes})</span>
                </button>
                <button class="action-btn">
                    <i class="far fa-bookmark"></i>
                    <span>收藏</span>
                </button>
                <button class="action-btn">
                    <i class="fas fa-share-alt"></i>
                    <span>分享</span>
                </button>
            </div>
            <div class="post-tags">
                <span class="tag">#论坛设计</span>
                <span class="tag">#Java开发</span>
                <span class="tag">#SpringBoot</span>
            </div>
        </div>
    </div>

    <!-- 评论区域 -->
    <div class="comment-section">
        <div class="section-header">
            <i class="far fa-comments"></i>
            <span>评论 (${post.commentCount})</span>
        </div>

        <!-- 评论表单 -->
        <form class="comment-form" action="${pageContext.request.contextPath}/comment/add" method="post">
            <input type="hidden"  name="postId" value="${post.postId}">
            <div class="form-group">
                <textarea class="form-control" name="content" required placeholder="分享你的想法..."></textarea>
            </div>
            <button type="submit" class="btn btn-secondary">
                <i class="fas fa-paper-plane"></i> 发表评论
            </button>
        </form>

        <!-- 评论列表 -->
        <ul class="comments-list">
            <c:choose>
                <c:when test="${not empty comments}">
                    <c:forEach items="${comments}" var="comment">
            <li class="comment-item" data-comment-id="${comment.commentId}">
                <div class="comment-header">
                    <div class="comment-author">
                        <div class="avatar">${comment.userName.substring(0,1)}</div>
                        <div class="author-info">
                            <div class="author-name">${comment.userName}对${post.title}说:</div>
                            <div class="comment-date"><fmt:formatDate value="${post.createdAt}" pattern="yyyy-MM-dd HH:mm" /></div>
                        </div>
                    </div>
                    <div class="comment-actions">
                        <c:if test="${sessionScope.user.userId == comment.userId}">
                        <button class="comment-action delete" title="删除评论">
                            <input type="hidden"  id="isUserComment-${comment.commentId}" value="${sessionScope.user.userId ==  comment.userId}"/>
                            <i class="fas fa-trash-alt"></i>
                        </button>
                        </c:if>
                        <button class="comment-action" title="回复">
                            <i class="fas fa-reply"></i>
                        </button>
                    </div>
                </div>
                <div class="comment-content">${comment.content}</div>

                <!-- 回复列表 -->
                <div class="show-replies" data-comment-id="${comment.commentId}">
                    <i class="fas fa-chevron-down"></i>
                    <span>查看回复 (${fn:length(replyMap[comment.commentId])})</span>
                </div>
                <ul class="replies-list" id="replies-${comment.commentId}">
                    <c:choose>
                        <c:when test="${not empty replyMap[comment.commentId]}">
                            <c:forEach items="${replyMap[comment.commentId]}" var="reply">
                    <li class="reply-item" data-reply-id="${reply.replyId}">
                        <div class="reply-header">
                            <div class="reply-author">
                                <div class="reply-avatar">${reply.userName.substring(0,1)}</div>

                                <div>
                                    <div class="reply-author-name">${reply.userName}对${userMap.get(reply.parentReplyId).username}说:</div>
                                    <div class="reply-date"><fmt:formatDate value="${reply.createdAt}" pattern="yyyy-MM-dd HH:mm" /></div>
                                </div>
                            </div>
                            <div class="comment-actions">
                                <c:if test="${sessionScope.user.userId == reply.getUserId()}">
                                <button class="comment-action delete" title="删除回复">
                                    <input type="hidden"  id="isUserComment-${reply.replyId}" value="${sessionScope.user.userId == reply.getUserId()}">
                                    <i class="fas fa-trash-alt"></i>
                                </button>
                                </c:if>
                                <button class="comment-action" title="回复">
                                    <i class="fas fa-reply"></i>
                                </button>
                            </div>
                        </div>
                        <div class="reply-content">${reply.content}</div>
                        <!-- 回复回复的表单 -->
                        <div class="reply-to-reply-form" id="reply-to-reply-form-${reply.replyId}">
                            <form action="${pageContext.request.contextPath}/reply/add" method="post">
                                <input type="hidden" name="commentId" value="${comment.commentId}">
                                <input type="hidden"  name="postId" value="${post.postId}">
                                <!-- 当前回复的userId -->
                                <input type="hidden" name="parentReplyId" value="${reply.userId}">
                                <textarea name="content" placeholder="回复${reply.userName}..." required></textarea>
                                <div class="reply-form-actions">
                                    <button type="button" class="reply-form-btn reply-cancel" data-reply-id="${reply.replyId}">取消</button>
                                    <button type="submit" class="reply-form-btn reply-submit">
                                        <i class="fas fa-paper-plane"></i> 发表回复
                                    </button>
                                </div>
                            </form>
                        </div>
                    </li>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <li class="reply-item">暂无回复</li>
                        </c:otherwise>
                    </c:choose>
                </ul>
                <!-- 对评论进行回复表单 -->
                <div class="reply-form" id="reply-form-${comment.commentId}">
                    <form action="${pageContext.request.contextPath}/reply/add" method="post">
                        <input type="hidden" name="commentId" value="${comment.commentId}">
                        <input type="hidden" name="postId" value="${post.postId}">
                        <input type="hidden" name="parentReplyId" value="${comment.userId}">
                        <textarea name="content" placeholder="回复${comment.userName}..." required></textarea>
                        <div class="reply-form-actions">
                            <button type="button" class="reply-form-btn reply-cancel" data-comment-id="${comment.commentId}">取消</button>
                            <button type="submit" class="reply-form-btn reply-submit">
                                <i class="fas fa-paper-plane"></i> 发表回复
                            </button>
                        </div>
                    </form>
                </div>
            </li>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <i class="far fa-comment-dots"></i>
                        <p>还没有评论，快来发表第一条评论吧！</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </ul>
    </div>
</div>
<!-- 页脚 -->
<footer class="footer">
    <p>Copyright © 2025 Powered by BBS论坛</p>
</footer>
<script>
    // 点赞功能
    document.querySelectorAll('.action-btn').forEach(button => {
        button.addEventListener('click', function() {
            if (this.classList.contains('liked')) {
                this.classList.remove('liked');
                const icon = this.querySelector('i');
                if (icon) {
                    icon.className = 'far fa-thumbs-up';
                }
            } else {
                this.classList.add('liked');
                const icon = this.querySelector('i');
                if (icon) {
                    icon.className = 'fas fa-thumbs-up';
                }
            }
        });
    });

    // 评论框自动聚焦
    const commentTextarea = document.querySelector('.comment-form textarea');
    if (commentTextarea) {
        commentTextarea.focus();
    }

    // 删除按钮点击事件
    document.querySelectorAll('.comment-action.delete').forEach(button => {
        button.addEventListener('click', function() {

            const commentItem = this.closest('.comment-item, .reply-item'); // 获取当前评论或回复项
            // 获取评论或回复的ID
            const itemId = commentItem.getAttribute('data-comment-id') || commentItem.getAttribute('data-reply-id');
            const itemType = commentItem.classList.contains('comment-item') ? 'comment' : 'reply';
           // 判断当前用户是否是该评论或回复的作者
            const isUserComment = document.getElementById("isUserComment-"+itemId).value === "true";

            // const postIdInput = document.querySelector("input[name='postId']");
            // const postId = postIdInput ? postIdInput.value : null;  // 获取帖子ID
            // console.log("帖子id"+postId);

            //获取 Web 应用的上下文路径
            const contextPath = "${pageContext.request.contextPath}";
            console.log("上下文"+contextPath);

            if (isUserComment) {
                if (confirm('确定要删除这条内容吗？')) {

                    // 发送删除请求
                    fetch(contextPath+"/"+itemType+"/delete/"+itemId, {
                        method: 'DELETE',
                        headers: {
                            'Content-Type': 'application/json'
                        },
                        body: JSON.stringify({})
                    })
                        .then(response => {
                        if (!response.ok) {
                            // 即使不是 ok，也尝试读取错误信息
                            return response.text().then(text => {
                                throw new Error(`服务器返回错误: ${text}`);
                            });
                        }
                        return response.text(); // 因为你返回的是 text/plain 类型
                    })
                        .then(message => {
                            console.log("删除成功:", message);
                            commentItem.style.opacity = '0';
                            setTimeout(() => {
                                commentItem.remove();
                            }, 300);
                        })
                        .catch(error => {
                            console.error('删除失败:', error);
                            alert('删除失败，请稍后重试:'+error.message);
                        });
                }
            } else {
                alert('您只能删除自己的评论或回复！');
            }
        });
    });





    // 回复按钮点击事件 - 处理一级回复和二级回复
    document.querySelectorAll('.comment-action').forEach(button => {
        if (button.querySelector('i').classList.contains('fa-reply')) {
            button.addEventListener('click', function(event) {
                event.stopPropagation(); // 阻止事件冒泡

                // 隐藏所有回复表单
                document.querySelectorAll('.reply-form, .reply-to-reply-form').forEach(form => {
                    form.classList.remove('show');
                });

                // 判断点击的是评论回复按钮还是回复的回复按钮
                const replyItem = this.closest('.reply-item');
                const commentItem = this.closest('.comment-item');

                if (replyItem) {
                    // 二级回复 - 回复的回复
                    const replyId = replyItem.getAttribute('data-reply-id');
                    const form = document.getElementById("reply-to-reply-form-"+replyId);
                    if (form) {
                        form.classList.add('show');
                        const textarea = form.querySelector('textarea');
                        setTimeout(() => textarea.focus(), 100);
                    }
                } else if (commentItem) {
                    // 一级回复 - 评论的回复
                    const commentId = commentItem.getAttribute('data-comment-id');
                    const form = document.getElementById("reply-form-"+commentId);
                    if (form) {
                        form.classList.add('show');
                        const textarea = form.querySelector('textarea');
                        setTimeout(() => textarea.focus(), 100);
                    }
                }
            });
        }
    });

    // 取消回复按钮功能
    document.querySelectorAll('.reply-cancel').forEach(button => {
        button.addEventListener('click', function() {
            const form = this.closest('.reply-form, .reply-to-reply-form');
            if (form) {
                form.classList.remove('show');
                const textarea = form.querySelector('textarea');
                if (textarea) {
                    // 清空文本
                    textarea.value = '';
                }
            }
        });
    });

    // 展开/收起回复功能
    document.querySelectorAll('.show-replies').forEach(button => {
        button.addEventListener('click', function() {
            const commentId = this.getAttribute('data-comment-id');
            const repliesList = document.getElementById("replies-"+commentId);
            const icon = this.querySelector('i');

            if (repliesList) {
                repliesList.classList.toggle('show');

                // 更新箭头方向
                if (repliesList.classList.contains('show')) {
                    icon.classList.replace('fa-chevron-down', 'fa-chevron-up');
                } else {
                    icon.classList.replace('fa-chevron-up', 'fa-chevron-down');
                }
            }
        });
    });
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


</script>

</body>
</html>