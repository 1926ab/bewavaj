<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.library.awa.model.Book" %>
<%@ page import="com.library.awa.model.Student" %>
<%@ page import="com.library.awa.model.BorrowRecord" %>
<%@ page import="com.library.awa.repository.BookRepository" %>
<%@ page import="com.library.awa.repository.StudentRepository" %>
<%@ page import="com.library.awa.repository.BorrowRecordRepository" %>
<%
  request.setCharacterEncoding("UTF-8");
  BookRepository bookRepo = new BookRepository();
  StudentRepository studentRepo = new StudentRepository();
  BorrowRecordRepository borrowRecordRepo = new BorrowRecordRepository();

  List<Book> books = bookRepo.getAllBooks();
  List<BorrowRecord> borrowRecords = borrowRecordRepo.getAllBorrowRecords();
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>管理员后台 - 图书管理系统</title>
  <style>
    body {
      font-family: 'Arial', sans-serif;
      margin: 0;
      padding: 0;
      background-color: #f5f5f5;
    }
    .header {
      background-color: #2c3e50;
      color: white;
      padding: 15px 20px;
      display: flex;
      justify-content: space-between;
      align-items: center;
    }
    .logout-btn {
      background-color: #e74c3c;
      color: white;
      border: none;
      padding: 8px 15px;
      border-radius: 4px;
      cursor: pointer;
    }
    .logout-btn:hover {
      background-color: #c0392b;
    }
    .container {
      max-width: 1100px;
      margin: 30px auto;
      background: #fff;
      border-radius: 8px;
      box-shadow: 0 2px 5px rgba(0,0,0,0.1);
      padding: 20px;
    }
    h3 {
      border-left: 5px solid #3498db;
      padding-left: 10px;
    }
    table {
      width: 100%;
      border-collapse: collapse;
      margin-top: 15px;
    }
    th, td {
      padding: 12px 10px;
      border-bottom: 1px solid #ddd;
      text-align: left;
    }
    th {
      background-color: #f2f2f2;
    }
    tr:hover {
      background-color: #f5f5f5;
    }
    .action-btn {
      padding: 5px 10px;
      margin-right: 5px;
      border: none;
      border-radius: 3px;
      cursor: pointer;
    }
    .edit-btn {
      background-color: #3498db;
      color: white;
    }
    .delete-btn {
      background-color: #e74c3c;
      color: white;
    }
    .submit-btn {
      background-color: #2ecc71;
      color: white;
      padding: 10px 15px;
      border: none;
      border-radius: 4px;
      cursor: pointer;
    }
  </style>
</head>
<body>
<div class="header">
  <h2>管理员后台 - 图书管理系统</h2>
  <form method="post" action="index.jsp" style="margin:0;">
    <% session.invalidate(); %>
    <button type="submit" class="logout-btn">退出登录</button>
  </form>
</div>
<div class="container">
  <h3>图书信息</h3>
  <table>
    <thead>
    <tr>
      <th>ID</th>
      <th>书名</th>
      <th>作者</th>
      <th>价格</th>
      <th>库存</th>
      <th>分类</th>
    </tr>
    </thead>
    <tbody>
    <% if (books == null || books.isEmpty()) { %>
    <tr>
      <td colspan="6" style="text-align: center;">暂无图书数据</td>
    </tr>
    <% } else {
      for (Book book : books) {
    %>
    <tr>
      <td><%= book.getId() %></td>
      <td><%= book.getTitle() %></td>
      <td><%= book.getAuthor() %></td>
      <td>¥<%= String.format("%.2f", book.getPrice()) %></td>
      <td><%= book.getQuantity() %></td>
      <td><%= book.getCategory() %></td>
    </tr>
    <%   }
    } %>
    </tbody>
  </table>

  <h3>学生借阅记录</h3>
  <table>
    <thead>
    <tr>
      <th>学生ID</th>
      <th>学生姓名</th>
      <th>图书ID</th>
      <th>借阅时间</th>
      <th>归还时间</th>
    </tr>
    </thead>
    <tbody>
    <% if (borrowRecords == null || borrowRecords.isEmpty()) { %>
    <tr>
      <td colspan="5" style="text-align: center;">暂无借阅记录</td>
    </tr>
    <% } else {
      for (BorrowRecord record : borrowRecords) {
    %>
    <tr>
      <td><%= record.getStudentId() %></td>
      <td><%= studentRepo.getStudentNameById(record.getStudentId()) %></td>
      <td><%= record.getBookId() %></td>
      <td><%= record.getBorrowDate() %></td>
      <td><%= record.getReturnDate() == null ? "未归还" : record.getReturnDate() %></td>
    </tr>
    <%   }
    } %>
    </tbody>
  </table>

  <h3>管理图书入口</h3>
  <form method="get" action="manageBooks.jsp">
    <button type="submit" class="submit-btn">进入管理图书</button>
  </form>
</div>
</body>
</html>