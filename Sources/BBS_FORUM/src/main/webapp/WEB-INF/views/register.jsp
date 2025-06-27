<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="en">
<head>
  <meta charset="utf-8"/>
  <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
  <title>注册</title>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet"/>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap" rel="stylesheet"/>
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
      position: relative;
      padding: 40px;
      flex: 1;
      display: flex;
      flex-direction: column;
      justify-content: center;
    }
    .back-btn {
      position: absolute;
      top: 20px;
      right: 20px;
      background: none;
      border: none;
      font-size: 20px;
      cursor: pointer;
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
      margin-bottom:7px;
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
    .next-btn, .register-btn {
      background-color: #FF6B6B;
      color: white;
      border: none;
      padding: 10px;
      border-radius: 5px;
      font-size: 16px;
      cursor: pointer;
      margin-top: 15px;
      margin-bottom: 20px;
    }
    .next-btn:hover, .register-btn:hover {
      background-color: #FF4B4B;
    }
    .verification-code {
      display: flex;
      align-items: center;
      gap: 10px;
    }
    .verification-code input {
      flex: 1;
      margin-right: 10px;
    }
    .timer {
      font-size: 14px;
      color: #FF6B6B;
      margin-left: 10px;
    }

    .error-message {
      color: red;
      font-size: 0.8em;
      margin-top: 10px;
    }
  </style>
</head>


<body>
<div class="container">
  <div class="left">
    <img   width="380" height="420"src="${pageContext.request.contextPath}/resources/images/blog_login.jpg" />
  </div>
  <div class="right">
    <h2>注册</h2>
    <button class="back-btn" onclick="showStep1()" ><i class="fas fa-arrow-left"></i></button>
    <form id="registrationForm" action="register" method="post">
      <div id="step1">
        <div class="input-group">
          <label for="name">用户名</label>
          <input id="name" name="username" type="text" placeholder="请输入用户名"  />
        </div>
        <div class="input-group">
          <label for="email">账号</label>
          <input id="email" type="email" name="email" placeholder="请输入QQ邮箱"  />
          <span class="error-message" id="emailError"></span>
        </div>
        <button type="button" class="next-btn" onclick="showStep2()">下一步</button>
      </div>
      <div id="step2" style="display: none;">

        <div class="input-group">
          <label for="password">密码</label>
          <input id="password" type="password" name="password" placeholder="请输入密码" />
          <span class="error-message" id="passwordError"></span>
        </div>
        <div class="input-group">
          <label for="confirm-password">重新输入密码</label>
          <input id="confirm-password" type="password"/>
          <span class="error-message" id="confirmPasswordError"></span>
        </div>
        <button class="register-btn" type="submit">注册</button>
      </div>
    </form>
  </div>
</div>

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
<script>
  // 获取当前页面的URL参数向alert返回值
  function getUrlParams(url = window.location.href) {
    const search = new URL(url).search;
    const params = new URLSearchParams(search);
    return alert(params.get('msg'));
  }




  function showStep2() {
    document.getElementById('step1').style.display = 'none';
    document.getElementById('step2').style.display = 'block';
  }
  function showStep1() {

    //判断段step1是否显示
    if (document.getElementById('step2').style.display === 'none') {
      // 跳转到登录 (替换当前页面)
      window.location.replace("login") ;
    }else {
      document.getElementById('step1').style.display = 'block';
      document.getElementById('step2').style.display = 'none';
    }

  }

</script>
</body>
</html>
