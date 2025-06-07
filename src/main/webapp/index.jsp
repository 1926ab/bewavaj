<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.library.awa.dao.impl.StudentDaoImpl" %>
<%@ page import="com.library.awa.dao.impl.AdminDaoImpl" %>
<!DOCTYPE html>
<html>
<head>
    <title>图书管理系统</title>
    <style>
        /* 页面样式 */
        body {
            margin: 0;
            padding: 0;
            background-image: url('background.jpg');
            background-size: cover;
            background-position: center;
            font-family: Arial, sans-serif;
        }
        .container {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }
        .login-box {
            background-color: rgba(255, 255, 255, 0.8);
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            text-align: center;
            width: 300px;
        }
        .login-box h1 {
            margin-bottom: 20px;
            font-size: 24px;
        }
        .login-box form {
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .login-box input, .login-box select, .login-box button, .login-box a {
            display: block;
            margin: 10px auto;
            padding: 10px;
            font-size: 16px;
            width: 80%;
            border-radius: 5px;
            border: 1px solid #ccc;
        }
        .login-box button {
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
        }
        .login-box button:hover {
            background-color: #45a049;
        }
        .login-box a {
            color: #007BFF;
            text-decoration: none;
        }
        .login-box a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="login-box">
        <h1>图书管理系统</h1>
        <form method="post">
            <label for="login-type">选择登录类型:</label>
            <select name="loginType" id="login-type" required>
                <option value="admin">管理员登录</option>
                <option value="student">学生借阅登录</option>
            </select>
            <input type="text" name="username" placeholder="账号" required>
            <input type="password" name="password" placeholder="密码" required>
            <button type="submit">登录</button>
        </form>
        <a href="register.jsp">注册学生借阅账号</a>
    </div>
</div>

<%-- 登录逻辑 --%>
<%
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String loginType = request.getParameter("loginType");
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if ("admin".equals(loginType)) {
            AdminDaoImpl adminDao = new AdminDaoImpl();
            if (adminDao.validateAdminLogin(username, password)) {
                response.sendRedirect("admin.jsp"); // 登录成功，跳转到管理员页面
            } else {
                out.println("<script>alert('管理员登录失败，请检查账号或密码');</script>");
            }
        } else if ("student".equals(loginType)) {
            StudentDaoImpl studentDao = new StudentDaoImpl(); // 替换为 StudentDaoImpl
            if (studentDao.validateStudentLogin(username, password)) { // 调用 validateStudentLogin
                response.sendRedirect("student.jsp"); // 登录成功，跳转到学生页面
            } else {
                out.println("<script>alert('学生登录失败，请检查账号或密码');</script>");
            }
        }
    }
%>
</body>
</html>