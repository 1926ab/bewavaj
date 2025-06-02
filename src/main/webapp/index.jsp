<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>校园新闻发布系统 - 登录</title>
  <link rel="stylesheet" href="css/bootstrap.min.css">
</head>
<body>
<div class="container mt-5">
  <div class="row justify-content-center">
    <div class="col-md-6">
      <div class="card">
        <div class="card-header">
          <h4>用户登录</h4>
        </div>
        <div class="card-body">
          <form action="login" method="post">
            <div class="form-group">
              <label for="username">用户名</label>
              <input type="text" class="form-control" id="username" name="username" required>
            </div>
            <div class="form-group">
              <label for="password">密码</label>
              <input type="password" class="form-control" id="password" name="password" required>
            </div>
            <button type="submit" class="btn btn-primary">登录</button>
            <a href="register.jsp" class="btn btn-link">注册新用户</a>
          </form>
          <c:if test="${not empty error}">
            <div class="alert alert-danger mt-3">${error}</div>
          </c:if>
        </div>
      </div>
    </div>
  </div>
</div>
</body>
</html>
