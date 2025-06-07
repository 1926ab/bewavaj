<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.library.awa.model.Book, com.library.awa.dao.impl.BorrowRecordDAOImpl" %>
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
      <th>剩余库存</th>
      <th>操作</th>
    </tr>
    </thead>
    <tbody>
    <%
      // 初始化 DAO 实例
      BorrowRecordDAOImpl borrowRecordDAO = new BorrowRecordDAOImpl();
      String studentId = (String) session.getAttribute("studentId");
      boolean hasBorrowed = false;

      try {
        // 检查学生是否已借阅其他书籍
        hasBorrowed = borrowRecordDAO.hasActiveBorrow(studentId);
      } catch (Exception e) {
        e.printStackTrace();
      }

      List<Book> books = null;
      try {
        // 获取当前库存大于 0 的书籍
        books = borrowRecordDAO.getAvailableBooks();
      } catch (Exception e) {
        e.printStackTrace();
      }

      if (books == null || books.isEmpty()) {
    %>
    <tr>
      <td colspan="5">暂无可借书籍</td>
    </tr>
    <%
    } else {
      for (Book book : books) {
    %>
    <tr>
      <td><%= book.getId() %></td>
      <td><%= book.getTitle() %></td>
      <td><%= book.getAuthor() %></td>
      <td><%= book.getQuantity() %></td>
      <td>
        <% if (hasBorrowed) { %>
        <button class="borrow-btn" disabled>每名学生最多同时借阅一本图书，请归还后再借阅</button>
        <% } else if (book.getQuantity() > 0) { %>
        <form method="post">
          <input type="hidden" name="bookId" value="<%= book.getId() %>">
          <button type="submit" class="borrow-btn">借阅</button>
        </form>
        <% } else { %>
        <button class="borrow-btn" disabled>不可借阅</button>
        <% } %>
      </td>
    </tr>
    <%
        }
      }
    %>
    </tbody>
  </table>

  <%-- 处理借阅逻辑 --%>
  <%
    String bookId = request.getParameter("bookId");
    if (bookId != null && !hasBorrowed) {
      try {
        // 添加借阅记录
        borrowRecordDAO.addBorrowRecord(new com.library.awa.model.BorrowRecord(studentId, bookId));
        out.println("<script>alert('借阅成功！'); location.reload();</script>");
      } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>alert('借阅失败，请稍后再试！');</script>");
      }
    }
  %>
</div>
</body>
</html>