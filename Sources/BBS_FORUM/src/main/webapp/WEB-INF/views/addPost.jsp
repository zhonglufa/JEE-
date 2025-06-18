<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>发布文章 - BBS论坛</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+SC:wght@400;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Noto Sans SC', sans-serif;
            background-color: #f5f7f9;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        .form-container {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        .form-group input,
        .form-group textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #e5e5e5;
            border-radius: 4px;
            font-size: 14px;
        }
        .form-group textarea {
            height: 200px;
            resize: vertical;
        }
        .form-group button {
            background-color: #ff5a5f;
            color: #fff;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            font-size: 14px;
            cursor: pointer;
        }
        .form-group button:hover {
            background-color: #e04b53;
        }
        .back-link {
            display: inline-block;
            margin-top: 10px;
            color: #666;
            text-decoration: none;
        }
        .back-link:hover {
            color: #ff5a5f;
        }
        @media (max-width: 768px) {
            .form-container {
                padding: 15px;
            }
            .form-group input,
            .form-group textarea {
                padding: 8px;
                font-size: 13px;
            }
            .form-group button {
                padding: 8px 16px;
                font-size: 13px;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="form-container">
        <h2>发布新文章</h2>
        <form action="addPost" method="post" enctype="multipart/form-data">
            <div class="form-group">
                <label for="title">标题</label>
                <input type="text" id="title" name="title" required placeholder="请输入文章标题">
            </div>
            <div class="form-group" >
                <label for="cover">封面图片</label>
<%--         accept限制类型       --%>
                <input type="file" id="cover" name="cover" accept="image/*">
                <!-- 新增图片预览 -->
                <img id="coverPreview" src="#" alt="封面预览" style="display: none; max-width: 100%; max-height: 200px; margin-top: 10px; border: 1px solid #ccc; border-radius: 4px;">
            </div>
            <div class="form-group">
                <label for="content">内容</label>
                <textarea id="content" name="content" required placeholder="请输入文章内容"></textarea>
            </div>
            <div class="form-group">
                <button type="submit">发布文章</button>
            </div>
        </form>
        <a href="home" class="back-link"><i class="fas fa-arrow-left"></i> 返回首页</a>
    </div>
</div>
</body>
<script>
    // 获取文件输入框（<input type="file" id="cover">）
    document.getElementById('cover').addEventListener('change', function (event) {
        // 获取用户选择的第一个文件
        const file = event.target.files[0];
        // 获取预览图片元素（<img id="coverPreview">）
        const preview = document.getElementById('coverPreview');

        // 如果用户选择了文件，并且文件类型是图片（如 image/jpeg、image/png 等）
        if (file && file.type.startsWith('image/')) {
            // 创建一个 FileReader 对象，用于读取文件内容
            const reader = new FileReader();

            // 定义 FileReader 的 onload 回调函数
            reader.onload = function (e) {
                // 将文件内容转换为 Data URL（Base64 编码），并赋值给预览图片的 src 属性
                preview.src = e.target.result;
                // 显示预览图片
                preview.style.display = 'block';
            };

            // 读取用户选择的文件，并将其转换为 Data URL
            reader.readAsDataURL(file);
        } else {
            // 如果没有选择文件，或者选择的文件不是图片，则隐藏预览图
            preview.style.display = 'none';
        }
    });

    // 文件上传前验证
    document.querySelector('form').addEventListener('submit', function(e) {
        const fileInput = document.getElementById('cover');
        if (fileInput.files.length > 0) {
            const file = fileInput.files[0];
            if (file.size > 50000) { // 50KB
                alert('图片大小不能超过50KB');
                e.preventDefault();
            }
            if (!file.type.startsWith('image/')) {
                alert('只能上传图片文件');
                e.preventDefault();
            }
        }
    });
</script>
</html>