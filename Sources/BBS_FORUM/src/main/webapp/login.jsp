<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>
        登录
    </title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&amp;display=swap" rel="stylesheet"/>
    <style>
        body {
            margin: 0;
            font-family: 'Inter', sans-serif;
            background-color: #FDECE4;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;

        }
        .container {
            background-color: white;
            border-radius: 20px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            display: flex;
            overflow: hidden;
            max-width: 900px;
            width: 100%;
            height: 544px;
        }
        .left {
            background-color: #FDECE4;
            padding: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            flex: 1;
            overflow: hidden; /* 隐藏溢出的部分 */

        }
        .left img {
            border-radius: 7%;
            width: 100%; /* 图片宽度占满盒子 */
            height: 100%; /* 图片高度占满盒子 */
            object-fit: cover; /* 保持宽高比，覆盖整个容器 */
        }
        .right {
            padding: 40px;
            flex: 1;
            display: flex;
            flex-direction: column;

            justify-content: center;
        }
        .right h2 {
            font-size: 24px;
            font-weight: 600;
            margin-bottom: 20px;
        }
        .input-group {
            margin-bottom: 20px;
        }
        .input-group label {
            display: block;
            font-size: 14px;
            margin-bottom: 5px;
        }
        .input-group input {
            width: 100%;
            padding: 10px;
            border: 1px solid #E0E0E0;
            border-radius: 5px;
            font-size: 14px;
        }
        .input-group input:focus {
            outline: none;
            border-color: #FF6B6B;
        }
        .forgot-password {
            text-align: right;
            margin-bottom: 20px;
        }
        .forgot-password a,span{
            color: #FF6B6B;
            text-decoration: none;
            font-size: 12px;
        }
        .login-btn {
            background-color: #FF6B6B;
            color: white;
            border: none;
            padding: 10px;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            margin-bottom: 20px;
        }
        .login-btn:hover {
            background-color: #FF4B4B;
        }
        .or {
            text-align: center;
            margin-bottom: 20px;
            font-size: 14px;
            color: #B0B0B0;
        }
        .social-login {
            display: flex;
            justify-content: center;
            gap: 10px;
            margin-bottom: 20px;
            padding: 3px;
        }
        .social-login a {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 40px;
            height: 40px;
            border: 1px solid #E0E0E0;
            border-radius: 50%;
            text-decoration: none;
            color: #B0B0B0;
            font-size: 18px;
        }
        .social-login a:hover{
            background-color: #72b5ff;
        }
        .signup {
            text-align: center;
            font-size: 14px;
        }
        .signup a {
            color: #FF6B6B;
            text-decoration: none;
        }

    </style>
</head>
<body>
<%-- 错误信息回显--%>
<c:if test="${not empty msg}">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function() {
            // 显示提示消息
            if(!$.trim('${msg}') == ''){
                alert('${msg}');
            }

        });
    </script>
</c:if>

<div class="container">
    <div class="left">
        <img  width="380" height="420" src="${pageContext.request.contextPath}/resources/images/blog_login.jpg" />
    </div>
    <div class="right">
        <h2>
            登录
        </h2>
        <form action="user/login" method="post">
            <div class="input-group">
                <label for="email">
                    账号
                </label>
                <input id="email" type="email" name="email" value=""  placeholder="请输入QQ邮箱"/>
            </div>
            <div class="input-group">
                <label for="password">
                    密码
                </label>
                <input id="password" type="password" name="password" value="" placeholder="请输入密码"/>
            </div>
            <div class="forgot-password">
                <a href="#">
                    忘记密码?
                </a>
            </div>
            <button class="login-btn">
                登录
            </button>
            <div class="or">
                选择其他方式登录
            </div>
            <div class="social-login">
                <a href="#">
                    <i class="fab fa-google">
                    </i>
                </a>
                <a href="#">
                    <i class="fab fa-facebook-f">
                    </i>
                </a>
                <a href="#">
                    <i class="fab fa-apple">
                    </i>
                </a>
            </div>
            <div class="signup">
                没有账户?
                <a href="user/register">
                    请注册
                </a>
            </div>
        </form>
    </div>
</div>
</body>
</html>