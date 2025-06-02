<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.library.awa.model.Book, com.library.awa.repository.BookRepository" %>
<!DOCTYPE html>
<html>
<head>
  <title>学生借阅页面 - 图书管理系统</title>
  <style>
    /* 设置页面样式 */
    body {
      margin: 0;
      padding: 0;
      background-color: #f4f4f4;
      font-family: Arial, sans-serif;
    }
    .container {
      margin: 0 auto;
      padding: 20px;
      max-width: 800px;
      background-color: #fff;
      border-radius: 10px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    }
    h1 {
      text-align: center;
      color: #333;
    }
    .book-table {
      width: 100%;
      border-collapse: collapse;
      margin: 20px 0;
    }
    .book-table th, .book-table td {
      padding: 10px;
      border: 1px solid #ddd;
      text-align: center;
    }
    .book-table th {
      background-color: #4CAF50;
      color: white;
    }
    .book-table td {
      background-color: #f9f9f9;
    }
    .book-table tr:hover {
      background-color: #f1f1f1;
    }
    .borrow-btn {
      background-color: #007BFF;
      color: white;
      border: none;
      padding: 10px 15px;
      border-radius: 5px;
      cursor: pointer;
    }
    .borrow-btn:hover {
      background-color: #0056b3;
    }
  </style>
</head>
<body>
<div class="container">
  <h1>学生借阅页面</h1>
  <table class="book-table">
    <thead>
    <tr>
      <th>书籍编号</th>
      <th>书名</th>
      <th>作者</th>
      <th>是否可借阅</th>
      <th>剩余库存</th>
      <th>操作</th>
    </tr>
    </thead>
    <tbody>
    <%-- 动态加载图书数据 --%>
    <%
      BookRepository bookRepository = new BookRepository();
      List<Book> books = new ArrayList<>();
      try {
        books = bookRepository.getAllBooks(); // 从数据库加载所有图书信息
      } catch (Exception e) {
        out.println("<tr><td colspan='6'>无法加载图书信息，请稍后重试。</td></tr>");
      }

      for (Book book : books) {
    %>
    <tr>
      <td><%= book.getId() %></td>
      <td><%= book.getTitle() %></td>
      <td><%= book.getAuthor() %></td>
      <td><%= book.isAvailable() ? "可借阅" : "不可借阅" %></td>
      <td><%= book.getStock() %></td>
      <td>
        <% if (book.isAvailable() && book.getStock() > 0) { %>
        <form method="post" action="borrowBook.jsp">
          <input type="hidden" name="bookId" value="<%= book.getId() %>">
          <button type="submit" class="borrow-btn">借阅</button>
        </form>
        <% } else { %>
        <button class="borrow-btn" disabled>不可借阅</button>
        <% } %>
      </td>
    </tr>
    <% } %>
    </tbody>
  </table>
</div>
</body>
</html>