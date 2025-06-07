<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.library.awa.dao.impl.BorrowRecordDAOImpl, com.library.awa.model.BorrowRecord" %>
<!DOCTYPE html>
<html>
<head>
  <title>管理员页面 - 图书管理系统</title>
  <style>
    /* 页面样式 */
    body {
      margin: 0;
      padding: 0;
      background-color: #f4f4f4;
      font-family: Arial, sans-serif;
    }
    .container {
      margin: 20px auto;
      padding: 20px;
      max-width: 1000px;
      background-color: #fff;
      border-radius: 10px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    }
    h1 {
      text-align: center;
      color: #333;
    }
    .record-table {
      width: 100%;
      border-collapse: collapse;
      margin: 20px 0;
    }
    .record-table th, .record-table td {
      padding: 12px;
      border: 1px solid #ddd;
      text-align: center;
    }
    .record-table th {
      background-color: #343a40;
      color: white;
    }
    .record-table td {
      background-color: #f9f9f9;
    }
    .record-table tr:hover {
      background-color: #f1f1f1;
    }
    .logout-btn {
      background-color: #dc3545;
      color: white;
      border: none;
      padding: 10px 20px;
      border-radius: 5px;
      cursor: pointer;
      float: right;
    }
    .logout-btn:hover {
      background-color: #c82333;
    }
  </style>
</head>
<body>
<div class="container">
  <h1>管理员页面</h1>

  <!-- 借阅记录 -->
  <h2>借阅记录</h2>
  <table class="record-table">
    <thead>
    <tr>
      <th>学生姓名</th>
      <th>书籍编号</th>
      <th>书籍名称</th>
    </tr>
    </thead>
    <tbody>
    <%-- 动态加载借阅记录 --%>
    <%
      BorrowRecordDAOImpl borrowRecordDAO = new BorrowRecordDAOImpl();
      List<BorrowRecord> borrowRecords = null;

      try {
        borrowRecords = borrowRecordDAO.getAllBorrowRecords(); // 获取借阅记录
      } catch (Exception e) {
        e.printStackTrace();
      }

      if (borrowRecords == null || borrowRecords.isEmpty()) {
    %>
    <tr>
      <td colspan="3">暂无借阅记录</td>
    </tr>
    <%
    } else {
      for (BorrowRecord record : borrowRecords) {
    %>
    <tr>
      <td><%= record.getStudentName() %></td>
      <td><%= record.getBookId() %></td>
      <td><%= record.getBookTitle() %></td>
    </tr>
    <%
        }
      }
    %>
    </tbody>
  </table>

  <!-- 退出登录按钮 -->
  <form method="post" action="index.jsp">
    <button type="submit" class="logout-btn">退出登录</button>
  </form>
</div>
</body>
</html>