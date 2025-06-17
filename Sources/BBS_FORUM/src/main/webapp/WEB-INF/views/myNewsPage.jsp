<%--
  Created by IntelliJ IDEA.
  User: 爱锅粥粥
  Date: 2025/6/17
  Time: 15:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>留言管理 - BBS论坛</title>
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

    /* 留言管理区域 */
    .messages-section {
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

    .messages-actions {
      display: flex;
      gap: 0.75rem;
    }

    .action-btn {
      padding: 0.5rem 1rem;
      border-radius: var(--radius-sm);
      font-size: 0.9rem;
      font-weight: 500;
      cursor: pointer;
      transition: all 0.2s;
      display: inline-flex;
      align-items: center;
      gap: 0.4rem;
      border: 1px solid var(--border);
      background-color: white;
    }

    .action-btn:hover {
      background-color: #f1f5f9;
    }

    .action-btn.primary {
      background-color: var(--primary);
      color: white;
      border-color: var(--primary);
    }

    .action-btn.primary:hover {
      background-color: var(--primary-dark);
    }

    .messages-list {
      list-style: none;
      padding: 0;
    }

    .message-item {
      padding: 1.5rem;
      border-bottom: 1px solid var(--border);
      transition: background-color 0.2s;
    }

    .message-item:hover {
      background-color: #f9fafb;
    }

    .message-header {
      display: flex;
      justify-content: space-between;
      align-items: flex-start;
      margin-bottom: 0.75rem;
    }

    .message-meta {
      display: flex;
      flex-direction: column;
    }

    .message-author {
      font-weight: 600;
      color: var(--text-primary);
      margin-bottom: 0.25rem;
    }

    .message-post {
      font-size: 0.9rem;
      color: var(--text-secondary);
    }

    .message-post a {
      color: var(--primary);
      text-decoration: none;
    }

    .message-post a:hover {
      text-decoration: underline;
    }

    .message-date {
      font-size: 0.85rem;
      color: var(--text-secondary);
    }

    .message-actions {
      display: flex;
      gap: 0.75rem;
    }

    .message-action {
      background: none;
      border: none;
      color: var(--text-secondary);
      cursor: pointer;
      font-size: 0.9rem;
      transition: color 0.2s;
      padding: 0.25rem;
      width: 32px;
      height: 32px;
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
    }

    .message-action:hover {
      background-color: #f1f5f9;
    }

    .message-action.reply:hover {
      color: var(--primary);
    }

    .message-action.delete:hover {
      color: var(--secondary);
    }

    .message-content {
      padding: 0.75rem 0;
      color: var(--text-primary);
      line-height: 1.7;
      margin-bottom: 0.5rem;
    }

    /* 回复区域 */
    .reply-section {
      margin-top: 1rem;
      padding-top: 1rem;
      border-top: 1px dashed var(--border);
    }

    .reply-header {
      font-size: 0.95rem;
      font-weight: 600;
      margin-bottom: 0.75rem;
      color: var(--text-primary);
    }

    .reply-form {
      display: flex;
      flex-direction: column;
      gap: 0.75rem;
      margin-bottom: 1rem;
    }

    .reply-form textarea {
      width: 100%;
      padding: 0.85rem;
      border: 1px solid var(--border);
      border-radius: var(--radius-sm);
      font-family: inherit;
      font-size: 0.95rem;
      resize: vertical;
      min-height: 100px;
      transition: border-color 0.2s, box-shadow 0.2s;
    }

    .reply-form textarea:focus {
      outline: none;
      border-color: var(--primary);
      box-shadow: 0 0 0 3px rgba(66, 153, 225, 0.15);
    }

    .reply-actions {
      display: flex;
      gap: 0.75rem;
      justify-content: flex-end;
    }

    .reply-btn {
      padding: 0.65rem 1.25rem;
      border-radius: var(--radius-sm);
      font-size: 0.9rem;
      font-weight: 500;
      cursor: pointer;
      transition: all 0.2s;
      display: inline-flex;
      align-items: center;
      gap: 0.5rem;
      border: none;
    }

    .reply-submit {
      background-color: var(--primary);
      color: white;
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
      background-color: #f1f5f9;
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

    /* 空状态 */
    .empty-state {
      padding: 3rem;
      text-align: center;
      color: var(--text-secondary);
    }

    .empty-state i {
      font-size: 3rem;
      margin-bottom: 1rem;
      opacity: 0.3;
    }

    .empty-state p {
      font-size: 1.1rem;
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

      .user-controls {
        order: 2;
        justify-content: flex-end;
      }

      .message-header {
        flex-direction: column;
        gap: 0.75rem;
        align-items: flex-start;
      }

      .message-actions {
        width: 100%;
        justify-content: flex-end;
      }

      .replies-list {
        padding-left: 20px;
      }
    }

    @media (max-width: 480px) {
      .reply-actions {
        flex-direction: column;
      }

      .reply-btn {
        width: 100%;
        justify-content: center;
      }

      .replies-list {
        padding-left: 10px;
      }
    }
  </style>
</head>
<body>
<!-- 头部导航 -->
<header class="forum-header">
  <div class="header-container">
    <a href="${pageContext.request.contextPath}/" class="logo">
      <img alt="Logo" src="https://storage.googleapis.com/a1aa/image/VjQYiiPK2c51Blh2a9ixpR4nZVO3GeJ4b6twzmeF0FEeBzynA.jpg" />
      <span>BBS论坛</span>
    </a>

    <nav class="nav-links">
      <a href="${pageContext.request.contextPath}/post/home">首页</a>
      <a href="#">安卓应用</a>
      <a href="#">专栏</a>
      <a href="#">友情链接</a>
    </nav>

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
          </div>
        </c:otherwise>
      </c:choose>
    </div>
  </div>
</header>

<!-- 主内容区 -->
<div class="main-container">
  <!-- 留言管理区域 -->
  <div class="messages-section">
    <div class="section-header">
      <h2 class="section-title">
        <i class="fas fa-envelope"></i> 我的留言
      </h2>
      <div class="messages-actions">
        <button class="action-btn">
          <i class="fas fa-sync-alt"></i> 刷新
        </button>
        <button class="action-btn primary">
          <i class="fas fa-filter"></i> 筛选
        </button>
      </div>
    </div>

    <ul class="messages-list">
      <c:choose>
        <c:when test="${not empty messages}">
          <c:forEach var="message" items="${messages}">
            <li class="message-item" id="message-${message.replyId}">
              <div class="message-header">
                <div class="message-meta">
                  <div class="message-author">${message.userName}</div>
                  <div class="message-post">
                    在文章: <a href="${pageContext.request.contextPath}/post/detail/${message.postId}">${postMap.get(message.postId).getTitle()}</a>
                  </div>
                  <div class="message-date">${message.createdAt}</div>
                </div>
                <div class="message-actions">
                  <button class="message-action reply" title="回复" data-message-id="${message.replyId}">
                    <i class="fas fa-reply"></i>
                  </button>
                  <button class="message-action delete" title="删除" data-message-id="${message.replyId}">
                    <i class="fas fa-trash-alt"></i>
                  </button>
                </div>
              </div>
              <div class="message-content">
                  ${message.content}
              </div>

              <!-- 回复区域 -->
              <div class="reply-section" id="reply-section-${message.replyId}">
                <div class="reply-header">回复留言</div>
                <form class="reply-form" action="${pageContext.request.contextPath}/reply/add" method="post">
                  <input type="hidden" name="messageId" value="${message.replyId}">
                  <textarea name="content" placeholder="输入您的回复内容..." required></textarea>
                  <div class="reply-actions">
                    <button type="button" class="reply-btn reply-cancel" data-message-id="${message.replyId}">取消</button>
                    <button type="submit" class="reply-btn reply-submit">
                      <i class="fas fa-paper-plane"></i> 提交回复
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
            <p>您还没有任何留言记录</p>
            <p>参与论坛讨论后，您的留言将显示在这里</p>
          </div>
        </c:otherwise>
      </c:choose>
    </ul>
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
  <p>Copyright © 2025  Powered by BBS论坛</p>
</footer>

<script>
  // 回复按钮功能
  document.querySelectorAll('.message-action.reply').forEach(button => {
    button.addEventListener('click', function() {
      const messageId = this.getAttribute('data-message-id');
      const replySection = document.getElementById("reply-section-"+messageId);

      // 隐藏所有其他回复区域
      document.querySelectorAll('.reply-section').forEach(section => {
        if (section !== replySection) {
          section.style.display = 'none';
        }
      });

      // 切换当前回复区域
      if (replySection.style.display === 'block') {
        replySection.style.display = 'none';
      } else {
        replySection.style.display = 'block';
        // 滚动到回复区域
        replySection.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
      }
    });
  });

  // 取消回复按钮功能
  document.querySelectorAll('.reply-cancel').forEach(button => {
    button.addEventListener('click', function() {
      const messageId = this.getAttribute('data-message-id');
      const replySection = document.getElementById("reply-section-"+messageId);
      replySection.style.display = 'none';
    });
  });

  // 删除留言功能
  document.querySelectorAll('.message-action.delete').forEach(button => {
    button.addEventListener('click', function() {
      const messageId = this.getAttribute('data-message-id');
      const messageItem = document.getElementById("message-"+messageId);

      if (confirm('确定要删除这条留言吗？此操作不可撤销。')) {
        messageItem.style.opacity = '0';
        setTimeout(() => {
          messageItem.remove();
          // 这里可以添加AJAX请求到服务器删除留言
        }, 300);
      }
    });
  });

  // 页面加载时隐藏所有回复区域
  document.addEventListener('DOMContentLoaded', function() {
    document.querySelectorAll('.reply-section').forEach(section => {
      section.style.display = 'none';
    });
  });
</script>
</body>
</html>