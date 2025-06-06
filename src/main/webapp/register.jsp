<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.library.awa.service.StudentService" %>
<%@ page import="com.library.awa.model.Student" %>
<!DOCTYPE html>
<html>
<head>
    <title>学生注册</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            background-color: #f5f5f5;
            font-family: Arial, sans-serif;
        }
        .container {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }
        .register-box {
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            text-align: center;
            width: 300px;
        }
        .register-box h1 {
            margin-bottom: 20px;
            font-size: 24px;
        }
        .register-box form {
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .register-box input, .register-box button {
            display: block;
            margin: 10px auto;
            padding: 10px;
            font-size: 16px;
            width: 80%;
            border-radius: 5px;
            border: 1px solid #ccc;
        }
        .register-box button {
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
        }
        .register-box button:hover {
            background-color: #45a049;
        }
        .error-message {
            color: red;
            font-size: 14px;
            margin-top: 10px;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="register-box">
        <h1>学生注册</h1>
        <form method="post">
            <input type="text" name="name" placeholder="姓名" required>
            <input type="email" name="email" placeholder="邮箱" required>
            <input type="password" name="password" placeholder="密码" required>
            <button type="submit">注册</button>
        </form>
        <div class="error-message">
            <% if (request.getAttribute("errorMessage") != null) { %>
            <%= request.getAttribute("errorMessage") %>
            <% } %>
        </div>
    </div>
</div>

<%-- 注册逻辑 --%>
<%
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        StudentService studentService = new StudentService();
        Student student = new Student(name, email, password);

        try {
            if (studentService.registerStudent(student)) {
                out.println("<script>alert('注册成功，请登录'); window.location='index.jsp';</script>");
            } else {
                request.setAttribute("errorMessage", "注册失败，邮箱可能已被注册！");
                request.getRequestDispatcher("register.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "注册过程中发生错误：" + e.getMessage());
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
%>
</body>
</html>