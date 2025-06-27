<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>学生信息管理系统 - 登录/注册</title>
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        :root {
            --primary: #4361ee;
            --primary-dark: #3a56d4;
            --secondary: #7209b7;
            --light: #f8f9fa;
            --dark: #212529;
            --gray: #6c757d;
            --success: #4cc9f0;
            --border-radius: 12px;
            --box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            --transition: all 0.3s ease;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Nunito', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
            color: var(--dark);
            line-height: 1.6;
        }

        .container {
            width: 100%;
            max-width: 900px;
            display: flex;
            flex-direction: column;
            background: white;
            border-radius: var(--border-radius);
            overflow: hidden;
            box-shadow: var(--box-shadow);
            min-height: 550px;
        }

        /* 欢迎区域样式 */
        .welcome-section {
            background: linear-gradient(to right, var(--primary), var(--secondary));
            color: white;
            padding: 40px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .welcome-section::before {
            content: "";
            position: absolute;
            width: 300px;
            height: 300px;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.1);
            top: -100px;
            left: -100px;
        }

        .welcome-section::after {
            content: "";
            position: absolute;
            width: 200px;
            height: 200px;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.08);
            bottom: -80px;
            right: -80px;
        }

        .logo {
            font-size: 2.5rem;
            margin-bottom: 20px;
            z-index: 1;
        }

        .logo i {
            background: white;
            color: var(--primary);
            width: 70px;
            height: 70px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 15px;
        }

        .welcome-section h1 {
            font-size: 2rem;
            margin-bottom: 15px;
            z-index: 1;
        }

        .welcome-section p {
            max-width: 350px;
            opacity: 0.9;
            z-index: 1;
        }

        /* 表单区域样式 */
        .form-container {
            padding: 40px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .form-header {
            text-align: center;
            margin-bottom: 30px;
        }

        .form-header h2 {
            font-size: 1.8rem;
            color: var(--dark);
            margin-bottom: 8px;
        }

        .form-header p {
            color: var(--gray);
        }

        .form-group {
            margin-bottom: 20px;
            position: relative;
        }

        .form-group i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--gray);
            font-size: 18px;
        }

        .form-control {
            width: 100%;
            padding: 14px 14px 14px 45px;
            border: 2px solid #e9ecef;
            border-radius: var(--border-radius);
            font-size: 16px;
            transition: var(--transition);
            font-family: inherit;
        }

        .form-control:focus {
            border-color: var(--primary);
            outline: none;
            box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.2);
        }

        .password-toggle {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            background: none;
            border: none;
            color: var(--gray);
            cursor: pointer;
            font-size: 18px;
        }

        .remember-forgot {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }

        .remember {
            display: flex;
            align-items: center;
        }

        .remember input {
            margin-right: 8px;
            accent-color: var(--primary);
        }

        .forgot-password {
            color: var(--primary);
            text-decoration: none;
            transition: var(--transition);
        }

        .forgot-password:hover {
            color: var(--primary-dark);
            text-decoration: underline;
        }

        .btn {
            display: block;
            width: 100%;
            padding: 14px;
            background: var(--primary);
            color: white;
            border: none;
            border-radius: var(--border-radius);
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            font-family: inherit;
        }

        .btn:hover {
            background: var(--primary-dark);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(67, 97, 238, 0.3);
        }

        .btn-secondary {
            background: var(--secondary);
        }

        .btn-secondary:hover {
            background: #5f0b9d;
        }

        .divider {
            display: flex;
            align-items: center;
            margin: 25px 0;
            color: var(--gray);
        }

        .divider::before,
        .divider::after {
            content: "";
            flex: 1;
            height: 1px;
            background: #e9ecef;
        }

        .divider span {
            padding: 0 15px;
            font-size: 14px;
        }

        .social-login {
            display: flex;
            gap: 15px;
            margin-bottom: 25px;
        }

        .social-btn {
            flex: 1;
            padding: 12px;
            border: 1px solid #e9ecef;
            border-radius: var(--border-radius);
            background: white;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            cursor: pointer;
            transition: var(--transition);
        }

        .social-btn:hover {
            border-color: var(--primary);
            background: #f8f9ff;
        }

        .social-btn i {
            font-size: 18px;
        }

        .switch-form {
            text-align: center;
            margin-top: 20px;
            color: var(--gray);
        }

        .switch-form a {
            color: var(--primary);
            text-decoration: none;
            font-weight: 600;
            margin-left: 5px;
            transition: var(--transition);
        }

        .switch-form a:hover {
            text-decoration: underline;
        }

        /* 响应式布局 */
        @media (min-width: 768px) {
            .container {
                flex-direction: row;
                min-height: 600px;
            }

            .welcome-section {
                width: 45%;
                padding: 50px;
            }

            .form-container {
                width: 55%;
                padding: 50px;
            }
        }

        @media (max-width: 767px) {
            .welcome-section {
                padding: 30px 20px;
            }

            .form-container {
                padding: 30px 20px;
            }

            .social-login {
                flex-direction: column;
            }
        }

        /* 动画效果 */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .form-header, .form-group, .remember-forgot, .btn, .social-login, .switch-form {
            animation: fadeIn 0.5s ease forwards;
        }

        .form-group:nth-child(2) { animation-delay: 0.1s; }
        .form-group:nth-child(3) { animation-delay: 0.2s; }
        .remember-forgot { animation-delay: 0.3s; }
        .btn { animation-delay: 0.4s; }
        .social-login { animation-delay: 0.5s; }
        .switch-form { animation-delay: 0.6s; }

        /* 表单切换效果 */
        #registerForm {
            display: none;
        }


        /* 错误信息显示*/
        .error-message {
            color: #e74c3c;
            background: #fdeded;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 20px;
            text-align: center;
            font-size: 14px;
            animation: shake 0.5s;
        }

        .success-message {
            color: #2ecc71;
            background: #edf7ed;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 20px;
            text-align: center;
            font-size: 14px;
        }

        @keyframes shake {
            0%, 100% {transform: translateX(0);}
            20%, 60% {transform: translateX(-5px);}
            40%, 80% {transform: translateX(5px);}
        }
    </style>
</head>
<body>
<div class="container">
    <!-- 欢迎区域 -->
    <div class="welcome-section">
        <div class="logo">
            <i class="fas fa-graduation-cap"></i>
            <h1>学生信息管理系统</h1>
        </div>
        <p>高效管理学生信息、课程与成绩数据的专业平台</p>
    </div>

    <!-- 登录/注册表单区域 -->
    <div class="form-container">
        <c:if test="${not empty error}">
            <div class="error-message">
                <i class="fas fa-exclamation-circle"></i> ${error}
            </div>
        </c:if>

        <c:if test="${not empty registerSuccess}">
            <div class="success-message">
                <i class="fas fa-check-circle"></i> ${registerSuccess}
            </div>
        </c:if>

        <!-- 登录表单 -->

        <form id="loginForm" method="POST" action="${pageContext.request.contextPath}/login">

            <div class="form-header">
                <h2>欢迎回来</h2>
                <p>请登录您的账户继续使用</p>
            </div>

            <div class="form-group">
                <i class="fas fa-user"></i>
                <input type="text" class="form-control" placeholder="用户名或邮箱" name="username" required>
            </div>

            <div class="form-group">
                <i class="fas fa-lock"></i>
                <input type="password" class="form-control" placeholder="密码" id="loginPassword" name="password" required>
                <button type="button" class="password-toggle" onclick="togglePassword('loginPassword')">
                    <i class="fas fa-eye"></i>
                </button>
            </div>

            <div class="remember-forgot">
                <div class="remember">
                    <input type="checkbox" id="remember">
                    <label for="remember">记住我</label>
                </div>
                <a href="#" class="forgot-password">忘记密码?</a>
            </div>

            <button type="submit" class="btn">登录</button>

            <div class="divider">
                <span>或使用其他方式登录</span>
            </div>

            <div class="social-login">
                <button type="button" class="social-btn">
                    <i class="fab fa-google"></i> Google
                </button>
                <button type="button" class="social-btn">
                    <i class="fab fa-microsoft"></i> Microsoft
                </button>
            </div>

            <div class="switch-form">
                还没有账户? <a href="#" onclick="showRegisterForm()">立即注册</a>
            </div>
        </form>

        <!-- 注册表单 -->

        <form id="registerForm" method="POST" action="${pageContext.request.contextPath}/register">

            <div class="form-header">
                <h2>创建账户</h2>
                <p>注册新账户开始使用系统</p>
            </div>

            <div class="form-group">
                <i class="fas fa-user"></i>
                <input type="text" class="form-control" placeholder="用户名" name="username" required>
            </div>

            <div class="form-group">
                <i class="fas fa-envelope"></i>
                <input type="email" class="form-control" placeholder="邮箱地址" name="email" required>
            </div>

            <div class="form-group">
                <i class="fas fa-lock"></i>
                <input type="password" class="form-control" placeholder="密码" id="registerPassword" name="password" required>
                <button type="button" class="password-toggle" onclick="togglePassword('registerPassword')">
                    <i class="fas fa-eye"></i>
                </button>
            </div>

            <div class="form-group">
                <i class="fas fa-lock"></i>
                <input type="password" class="form-control" placeholder="确认密码" name="confirmPassword" id="confirmPassword" required>
                <button type="button" class="password-toggle" onclick="togglePassword('confirmPassword')">
                    <i class="fas fa-eye"></i>
                </button>
            </div>

            <div class="form-group">
                <i class="fas fa-id-card"></i>
                <input type="text" class="form-control" placeholder="真实姓名" name="realName" required>
            </div>

            <button type="submit" class="btn btn-secondary">注册</button>

            <div class="switch-form">
                已有账户? <a href="#" onclick="showLoginForm()">立即登录</a>
            </div>
        </form>
    </div>
</div>
<script>
    // 切换登录/注册表单
    function showRegisterForm() {
        document.getElementById('loginForm').style.display = 'none';
        document.getElementById('registerForm').style.display = 'block';
    }

    function showLoginForm() {
        document.getElementById('registerForm').style.display = 'none';
        document.getElementById('loginForm').style.display = 'block';
    }

    // 切换密码可见性
    function togglePassword(inputId) {
        const passwordInput = document.getElementById(inputId);
        const toggleButton = passwordInput.nextElementSibling;

        if (passwordInput.type === 'password') {
            passwordInput.type = 'text';
            toggleButton.innerHTML = '<i class="fas fa-eye-slash"></i>';
        } else {
            passwordInput.type = 'password';
            toggleButton.innerHTML = '<i class="fas fa-eye"></i>';
        }
    }


</script>
</body>
</html>