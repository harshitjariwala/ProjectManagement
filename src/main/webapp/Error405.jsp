<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>User Dashboard</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
  <style>
  /* Base layout and reset */
  html, body {
    margin: 0;
    padding: 0;
    height: 100%;
  }

  body {
    display: flex;
    flex-direction: column;
    min-height: 100vh;
  }

  /* Light Theme */
  body.light-theme {
    background-color: #f4f6fa;
    color: #212529;
  }

  /* Dark Theme */
  body.dark-theme {
    background-color: #121212;
    color: #f1f1f1;
  }

  /* Header */
  .main-header {
    height: 60px;
    background-color: #243447;
    color: white;
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 0 20px;
    position: relative;
    flex-shrink: 0;
  }

  .main-header .header-title {
    position: absolute;
    left: 50%;
    transform: translateX(-50%);
    margin: 0;
    font-size: 20px;
    white-space: nowrap;
  }

  .header-right {
    display: flex;
    align-items: center;
    gap: 15px;
  }

  /* Footer */
  footer {
    background-color: #243447;
    color: white;
    text-align: center;
    padding: 10px 20px;
  }

  body.light-theme footer {
    background-color: #e9ecef;
    color: #212529;
  }

  /* Page Wrapper */
  .page-wrapper {
    display: flex;
    flex-direction: column;
    flex: 1;
    margin: 0;
    padding: 0;
  }

  /* Main Content */
  .main-content {
    flex: 1;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    padding: 20px;
  }

  /* Error Box */
  .error-box {
    padding: 30px;
    border: 1px solid #ccc;
    background-color: white;
    text-align: center;
  }

  .error-box h1 {
    color: #dc3545; /* Bootstrap's danger color */
    margin-bottom: 10px;
  }

  .error-box p {
    color: black;
  }

  .error-box a {
    color: #0d6efd; /* Bootstrap's primary color */
    text-decoration: none;
  }

  .error-box a:hover {
    text-decoration: underline;
  }
</style>
</head>
<body class="light-theme">
  <div class="page-wrapper d-flex flex-column min-vh-100">
    <header class="main-header">
      <h4 class="header-title">User Dashboard</h4>
      <div class="header-right">
        <div class="form-check form-switch text-light">
          <input class="form-check-input" type="checkbox" id="themeSwitch">
          <label class="form-check-label" for="themeSwitch">Dark Mode</label>
        </div>
      </div>
    </header>

    <main class="main-content d-flex flex-column justify-content-center align-items-center flex-grow-1">
      <div class="error-box text-center">
        <h1>405 - Method Not Allowed</h1>
        <p style="color:black">This method is not allowed for the requested URL.</p>
        <a href="Login.jsp">Return to Login Page</a>
      </div>
    </main>

    <footer class="mt-auto">
      &copy; 2025 Task Manager. All rights reserved.
    </footer>
  </div>
  <script>
    // Theme persistence on load
    window.addEventListener('DOMContentLoaded', () => {
      const isDark = localStorage.getItem('theme') === 'dark';
      document.body.classList.toggle('dark-theme', isDark);
      document.body.classList.toggle('light-theme', !isDark);
      document.getElementById('themeSwitch').checked = isDark;
    });

    // Theme switch logic
    document.getElementById('themeSwitch').addEventListener('change', function () {
      const isDark = this.checked;
      document.body.classList.toggle('dark-theme', isDark);
      document.body.classList.toggle('light-theme', !isDark);
      localStorage.setItem('theme', isDark ? 'dark' : 'light');
    });
  </script>
</body>
</html>