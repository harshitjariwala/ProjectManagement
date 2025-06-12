<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Method Not Allowed</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #fff3cd;
      text-align: center;
      padding: 50px;
    }
    .error-box {
      padding: 30px;
      border: 1px solid #ffeeba;
      display: inline-block;
      background-color: white;
    }
    h1 {
      color: #856404;
    }
    a {
      color: #0d6efd;
      text-decoration: none;
    }
    a:hover {
      text-decoration: underline;
    }
  </style>
</head>
<body>
  <div class="error-box">
    <h1>405 - Method Not Allowed</h1>
    <p>This method is not allowed for the requested URL.</p>
    <a href="Login.jsp">Return to Login Page</a>
  </div>
</body>
</html>
