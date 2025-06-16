<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>BBS论坛</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+SC:wght@400;700&amp;display=swap" rel="stylesheet"/>
    <style>
        body {
            font-family: 'Noto Sans SC', sans-serif;
            background-color: #f5f7f9;
            margin: 0;
            padding: 0;
        }
        .header {
            background-color: #fff;
            padding: 10px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid #e5e5e5;
        }
        .header .logo {
            display: flex;
            align-items: center;
        }
        .header .logo img {
            height: 40px;
            margin-right: 10px;
        }
        .header .nav {
            display: flex;
            align-items: center;
        }
        .header .nav a {
            margin: 0 10px;
            color: #333;
            text-decoration: none;
        }
        .header .search {
            display: flex;
            align-items: center;
        }
        .header .search input {
            padding: 5px;
            border: 1px solid #e5e5e5;
            border-radius: 3px;
        }
        .header .search button {
            background-color: #ff5a5f;
            border: none;
            color: #fff;
            padding: 5px 10px;
            margin-left: 5px;
            border-radius: 3px;
        }

        .navList {
            background-color: #ffffff;
            padding: 10px 20px;
            border-bottom: 1px solid #e5e5e5;
            margin-bottom: 20px;
        }
        .navList span {
            color: #ff69b4;
            font-size: 14px;
            margin-right: 10px;
        }
        .navList a {
            color: #666666;
            font-size: 14px;
            margin-right: 20px;
            text-decoration: none;
        }
        .main {
            display: flex;
            flex-wrap: wrap;
            padding: 20px;
        }
        .main .content {
            flex: 3;
            margin-right: 20px;
            width: 100%;
        }

        .card {
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            display: flex;
            padding: 20px;
            margin-bottom: 20px;
        }
        .card img {
            border-radius: 10px;
            margin-right: 20px;
        }
        .card-content {
            flex: 1;
        }
        .card-title {
            font-size: 18px;
            font-weight: bold;
            margin: 0;
        }
        .card-description {
            font-size: 14px;
            color: #666666;
            margin: 10px 0;
        }
        .card-tags {
            display: flex;
            align-items: center;
            margin-bottom: 10px;
        }
        .card-tags span {
            background-color: #ff8c00;
            color: #ffffff;
            border-radius: 5px;
            padding: 2px 5px;
            font-size: 12px;
            margin-right: 10px;
        }
        .card-tags a {
            background-color: #e5f3ff;
            color: #007bff;
            border-radius: 5px;
            padding: 2px 5px;
            font-size: 12px;
            text-decoration: none;
            margin-right: 10px;
        }
        .card-footer {
            display: flex;
            align-items: center;
            font-size: 12px;
            color: #999999;
        }
        .card-footer i {
            margin-right: 5px;
        }
        .card-footer span {
            margin-right: 10px;
        }

        .main .sidebar {
            flex: 1;
            width: 100%;
        }
        .main .sidebar .widget {
            background-color: #fff;
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 5px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        }
        .main .sidebar .widget img {
            width: 100%;
            border-radius: 5px;
        }
        .main .sidebar .widget .widget-title {
            font-size: 16px;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .main .sidebar .widget .widget-content {
            font-size: 14px;
        }
        .footer {
            background-color: #fff;
            padding: 20px;
            text-align: center;
            border-top: 1px solid #e5e5e5;
        }
        .footer p {
            margin: 0;
            font-size: 14px;
            color: #999;
        }
        @media (min-width: 768px) {
            .main {
                flex-direction: row;
            }
            .main .content {
                margin-right: 20px;
                width: auto;
            }
            .main .sidebar {
                width: auto;
            }
        }

        /*登录css */
        .list-box > li {
            position: relative;
            display: inline-block;
        }
        .list-box>li+li:before {
            content: '';
            width: 1px;
            height: 1.1em;
            position: absolute;
            display: inline-block;
            background: #424040;
            left: -1px;
            top: 50%;
            opacity: .2!important;
            transform: translateY(-50%);
        }
        li>a{
            text-decoration: none;
            padding: 0 5px;
            color: #181818;
        }
        li>a:hover{
            color: red;
        }

        .navbar-right>ul{
            list-style: none;
            display: flex;
        }

        .profile {
            display: flex;
            align-items: center;
            cursor: pointer;
        }

        .profile img {
            border-radius: 50%;
            margin-right: 10px;
        }

        #profile-menu {
            position: absolute;
            right: 0;
            background-color: #fff;
            border: 1px solid #e5e5e5;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            z-index: 1000;
        }

        #profile-menu ul {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        #profile-menu ul li {
            padding: 10px 20px;
        }

        #profile-menu ul li a {
            text-decoration: none;
            color: #333;
        }

        #profile-menu ul li a:hover {
            color: #ff5a5f;
        }

    </style>
</head>
<body>
<div class="header">
    <div class="logo">
        <img alt="Logo" height="40" src="https://storage.googleapis.com/a1aa/image/VjQYiiPK2c51Blh2a9ixpR4nZVO3GeJ4b6twzmeF0FEeBzynA.jpg" width="40"/>
        <span>落花爱看繁星</span>
    </div>
    <div class="nav">
        <a href="#">首页</a>
        <a href="#">安卓应用</a>
        <a href="#">stream汉化</a>
        <a href="#">ChatGPT汉化</a>
        <a href="#">专栏</a>
        <a href="#">友情链接</a>
    </div>
    <div class="search">
        <input placeholder="搜索内容" type="text"/>
        <button>搜索</button>
    </div>
    <c:choose>
        <c:when test="${empty sessionScope.user}">
            <ul class="list-box">
                <li><a href="${pageContext.request.contextPath}/user/login">登录</a></li>
                <li><a href="${pageContext.request.contextPath}/user/register">注册</a></li>
            </ul>
        </c:when>
        <c:otherwise>
            <div class="profile" id="user-profile" onclick="toggleProfileMenu()">
                <img id="user-avatar" height="40" width="40"
                     src="${sessionScope.user.avatarUrl != null && sessionScope.user.avatarUrl !='' ? sessionScope.user.avatarUrl :pageContext.request.contextPath}/resources/images/default-avatar.jpg" alt="User Avatar"/>
                <span id="user-name">${sessionScope.user.username}</span>
                <a href="${pageContext.request.contextPath}/post/toAddPost">发布文章</a>
            </div>
            <div id="profile-menu" style="display: none;">
                <ul>
                    <li><a href="${pageContext.request.contextPath}/user/profile">个人资料</a></li>
                    <li><a href="${pageContext.request.contextPath}/user/settings">设置</a></li>
                    <li><a href="${pageContext.request.contextPath}/user/logout">登出</a></li>
                </ul>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<div class="main">
    <div class="content">
        <div class="navList">
            <span>最新发布</span>
            <a href="#">排序</a>
            <a href="#">更新</a>
            <a href="#">浏览</a>
            <a href="#">点赞</a>
            <a href="#">评论</a>
        </div>

        <c:forEach var="post" items="${postList}">
            <div class="card" onclick="window.location.href='${pageContext.request.contextPath}/post/detail/${post.postId}'">
                <c:if test="${not empty post.coverImage}">
                    <img  height="80"  width="80" src="data:image/jpeg;base64,${post.coverImage}" alt="Post Cover"/>
                </c:if>
                <div class="card-content">
                    <div class="card-title">
                     ${post.title}
                    </div>
                    <div class="card-description">${post.content}</div>
                    <div class="card-tags">
                        <span>免费资源</span>
                        <a href="#">安卓应用</a>
                        <a href="#">文件管理</a>
                        <a href="#">Solid Explorer</a>
                    </div>
                    <div class="card-footer">
                        <i class="fas fa-heart"></i> 波仔
                        <span><i class="fas fa-clock"></i> 7个月前</span>
                        <span><i class="fas fa-comment"></i> 0</span>
                        <span><i class="fas fa-eye"></i> 83</span>
                        <span><i class="fas fa-thumbs-up"></i> 10</span>
                    </div>
                </div>
            </div>
        </c:forEach>

        <!-- 分页控件 -->
        <!-- 分页控件 -->
        <div class="pagination">
            <c:if test="${currentPage > 1}">
                <a href="${pageContext.request.contextPath}/post/home?page=${currentPage - 1}&pageSize=${pageSize}">上一页</a>
            </c:if>
            <c:forEach begin="1" end="${totalPages}" var="i">
                <c:choose>
                    <c:when test="${i == currentPage}">
                        <span>${i}</span>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/post/home?page=${i}&pageSize=${pageSize}">${i}</a>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
            <c:if test="${currentPage < totalPages}">
                <a href="${pageContext.request.contextPath}/post/home?page=${currentPage + 1}&pageSize=${pageSize}">下一页</a>
            </c:if>
        </div>
    </div>



    <div class="sidebar">
        <div class="widget">
            <div class="widget-title">最热文章</div>
            <div class="widget-content">
                <img alt="Top Post Image" height="200" src="https://storage.googleapis.com/a1aa/image/0O3NJCVNOD5iDZ71ihxDQgy1P6f5eqcGWHuOlCoA4kYAhZ5TA.jpg" width="300"/>
                <p>VMOS Pro v2.9.5安卓虚拟机...</p>
            </div>
        </div>
        <div class="widget">
            <div class="widget-title">文章推荐</div>
            <div class="widget-content">
                <p>文章1</p>
                <p>文章2</p>
                <p>文章3</p>
                <p>文章4</p>
            </div>
        </div>
        <div class="widget">
            <div class="widget-title">标签云</div>
            <div class="widget-content">
                <p>标签1 标签2 标签3 标签4 标签5 标签6 标签7 标签8 标签9 标签10</p>
            </div>
        </div>
    </div>
</div>
<div class="footer">
    <p>Copyright © 2024 网站名称 Powered by WordPress.</p>
</div>

<style>
    .pagination {
        display: flex;
        justify-content: center;
        margin-top: 20px;
    }
    .pagination a, .pagination span {
        padding: 8px 16px;
        margin: 0 4px;
        text-decoration: none;
        border: 1px solid #ddd;
        border-radius: 4px;
    }
    .pagination a:hover {
        background-color: #f1f1f1;
    }
    .pagination span {
        background-color: #4CAF50;
        color: white;
        border: none;
    }
</style>

<script>
    function toggleProfileMenu() {
        var menu = document.getElementById('profile-menu');
        menu.style.display = menu.style.display === 'none' ? 'block' : 'none';
    }
</script>
</body>
</html>