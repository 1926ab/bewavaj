<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%--<%@ page import="com.example.model.Book" %>--%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>图书管理系统 - 管理员后台</title>
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
    .container {
      display: flex;
      min-height: calc(100vh - 60px);
    }
    .sidebar {
      width: 250px;
      background-color: #34495e;
      color: white;
      padding: 20px 0;
    }
    .sidebar ul {
      list-style: none;
      padding: 0;
      margin: 0;
    }
    .sidebar li {
      padding: 12px 20px;
      cursor: pointer;
      transition: background-color 0.3s;
    }
    .sidebar li:hover, .sidebar li.active {
      background-color: #2c3e50;
    }
    .main-content {
      flex: 1;
      padding: 20px;
    }
    .section {
      background-color: white;
      border-radius: 5px;
      box-shadow: 0 2px 5px rgba(0,0,0,0.1);
      padding: 20px;
      margin-bottom: 20px;
      display: none;
    }
    .section.active {
      display: block;
    }
    table {
      width: 100%;
      border-collapse: collapse;
      margin-top: 15px;
    }
    th, td {
      padding: 12px 15px;
      text-align: left;
      border-bottom: 1px solid #ddd;
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
    .form-group {
      margin-bottom: 15px;
    }
    .form-group label {
      display: block;
      margin-bottom: 5px;
      font-weight: bold;
    }
    .form-group input, .form-group select {
      width: 100%;
      padding: 8px;
      border: 1px solid #ddd;
      border-radius: 4px;
      box-sizing: border-box;
    }
    .submit-btn {
      background-color: #2ecc71;
      color: white;
      padding: 10px 15px;
      border: none;
      border-radius: 4px;
      cursor: pointer;
    }
    .search-box {
      display: flex;
      margin-bottom: 15px;
    }
    .search-box input {
      flex: 1;
      padding: 8px;
      border: 1px solid #ddd;
      border-radius: 4px 0 0 4px;
    }
    .search-box button {
      padding: 8px 15px;
      background-color: #3498db;
      color: white;
      border: none;
      border-radius: 0 4px 4px 0;
      cursor: pointer;
    }
  </style>
</head>
<body>
<div class="header">
  <h2>图书管理系统 - 管理员后台</h2>
  <form action="LogoutServlet" method="post">
    <button type="submit" class="logout-btn">退出登录</button>
  </form>
</div>

<div class="container">
  <div class="sidebar">
    <ul>
      <li class="active" onclick="showSection('add-book')">添加图书</li>
      <li onclick="showSection('manage-books')">管理图书</li>
      <li onclick="showSection('search-books')">查询图书</li>
    </ul>
  </div>

  <div class="main-content">
    <!-- 添加图书部分 -->
    <div id="add-book" class="section active">
      <h3>添加新图书</h3>
      <form action="AddBookServlet" method="post">
        <div class="form-group">
          <label for="bookId">图书ID:</label>
          <input type="text" id="bookId" name="bookId" required>
        </div>
        <div class="form-group">
          <label for="title">书名:</label>
          <input type="text" id="title" name="title" required>
        </div>
        <div class="form-group">
          <label for="author">作者:</label>
          <input type="text" id="author" name="author" required>
        </div>
        <div class="form-group">
          <label for="price">价格:</label>
          <input type="number" id="price" name="price" step="0.01" required>
        </div>
        <div class="form-group">
          <label for="quantity">库存数量:</label>
          <input type="number" id="quantity" name="quantity" required>
        </div>
        <div class="form-group">
          <label for="category">分类:</label>
          <select id="category" name="category">
            <option value="文学">文学</option>
            <option value="科技">科技</option>
            <option value="历史">历史</option>
            <option value="艺术">艺术</option>
            <option value="教育">教育</option>
          </select>
        </div>
        <button type="submit" class="submit-btn">添加图书</button>
      </form>
    </div>

    <!-- 管理图书部分 -->
    <div id="manage-books" class="section">
      <h3>图书管理</h3>
      <table>
        <thead>
        <tr>
          <th>ID</th>
          <th>书名</th>
          <th>作者</th>
          <th>价格</th>
          <th>库存</th>
          <th>分类</th>
          <th>操作</th>
        </tr>
        </thead>
<%--        <tbody>--%>
<%--        <%--%>
<%--          List<Book> books = (List<Book>) request.getAttribute("books");--%>
<%--          if (books != null) {--%>
<%--            for (Book book : books) {--%>
<%--        %>--%>
<%--        <tr>--%>
<%--          <td><%= book.getId() %></td>--%>
<%--          <td><%= book.getTitle() %></td>--%>
<%--          <td><%= book.getAuthor() %></td>--%>
<%--          <td>¥<%= String.format("%.2f", book.getPrice()) %></td>--%>
<%--          <td><%= book.getQuantity() %></td>--%>
<%--          <td><%= book.getCategory() %></td>--%>
<%--          <td>--%>
<%--            <button class="action-btn edit-btn" onclick="editBook('<%= book.getId() %>')">编辑</button>--%>
<%--            <button class="action-btn delete-btn" onclick="deleteBook('<%= book.getId() %>')">删除</button>--%>
<%--          </td>--%>
<%--        </tr>--%>
<%--        <%--%>
<%--          }--%>
<%--        } else {--%>
<%--        %>--%>
        <tr>
          <td colspan="7" style="text-align: center;">暂无图书数据</td>
        </tr>
<%--        <% } %>--%>
        </tbody>
      </table>
    </div>

    <!-- 查询图书部分 -->
    <div id="search-books" class="section">
      <h3>图书查询</h3>
      <div class="search-box">
        <input type="text" id="search-input" placeholder="输入书名、作者或分类...">
        <button onclick="searchBooks()">搜索</button>
      </div>
      <table id="search-results">
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
        <!-- 搜索结果将通过JavaScript动态加载 -->
        </tbody>
      </table>
    </div>
  </div>
</div>

<script>
  // 切换显示不同的部分
  function showSection(sectionId) {
    // 更新侧边栏活动状态
    document.querySelectorAll('.sidebar li').forEach(item => {
      item.classList.remove('active');
    });
    event.currentTarget.classList.add('active');

    // 更新内容区域显示
    document.querySelectorAll('.section').forEach(section => {
      section.classList.remove('active');
    });
    document.getElementById(sectionId).classList.add('active');
  }

  // 删除图书
  function deleteBook(bookId) {
    if (confirm('确定要删除这本图书吗？')) {
      window.location.href = 'DeleteBookServlet?bookId=' + bookId;
    }
  }

  // 编辑图书 - 这里可以跳转到编辑页面或显示编辑表单
  function editBook(bookId) {
    window.location.href = 'EditBookServlet?bookId=' + bookId;
  }

  // 搜索图书
  function searchBooks() {
    const query = document.getElementById('search-input').value.trim();
    if (query === '') {
      alert('请输入搜索内容');
      return;
    }

    // 这里可以使用AJAX从服务器获取搜索结果
    // 示例代码，实际项目中应该替换为真实的AJAX请求
    fetch('SearchBookServlet?query=' + encodeURIComponent(query))
            .then(response => response.json())
            .then(data => {
              const tbody = document.querySelector('#search-results tbody');
              tbody.innerHTML = '';

              if (data.length === 0) {
                tbody.innerHTML = '<tr><td colspan="6" style="text-align: center;">没有找到匹配的图书</td></tr>';
                return;
              }

              data.forEach(book => {
                const row = document.createElement('tr');
                row.innerHTML = `
                            <td>${book.id}</td>
                            <td>${book.title}</td>
                            <td>${book.author}</td>
                            <td>¥${book.price.toFixed(2)}</td>
                            <td>${book.quantity}</td>
                            <td>${book.category}</td>
                        `;
                tbody.appendChild(row);
              });
            })
            .catch(error => {
              console.error('搜索出错:', error);
              alert('搜索过程中出错');
            });
  }
</script>
</body>
</html>