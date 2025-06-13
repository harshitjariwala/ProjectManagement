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
    body {
      margin: 0;
      padding: 0;
      min-height: 100vh;
      display: flex;
      flex-direction: column;
    }

    body.light-theme {
      background-color: #f4f6fa;
      color: #212529;
    }

    body.dark-theme {
      background-color: #121212;
      color: #f1f1f1;
    }

    .main-header {
      height: 60px;
      background-color: #243447;
      color: white;
      display: flex;
      align-items: center;
      justify-content: space-between;
      padding: 0 20px;
      flex-shrink: 0;
    }

    .main-header h4 {
      margin: 0;
      font-size: 20px;
    }

    .page-wrapper {
      flex: 1;
      display: flex;
      flex-direction: column;
      padding: 20px;
    }

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

    .welcome-message {
      font-size: 24px;
      font-weight: 500;
      margin-top: 20px;
    }

    .form-switch {
      font-size: 14px;
    }

    .user-info img {
      border-radius: 50%;
    }
    html, body {
      height: 100%;
      margin: 0;
    }

    .page-wrapper {
      min-height: 100vh;
      display: flex;
      flex-direction: column;
    }

    .main-content {
      flex: 1;
    }

    body.light-theme {
      background-color: #f4f6fa;
      color: #212529;
    }

    body.dark-theme {
      background-color: #121212;
      color: #f1f1f1;
    }

    .main-header {
      height: 60px;
      background-color: #243447;
      color: white;
      display: flex;
      align-items: center;
      justify-content: space-between;
      padding: 0 20px;
      position: relative;
      z-index: 1;
    }

    .main-header h4 {
      position: absolute;
      left: 50%;
      transform: translateX(-50%);
      margin: 0;
      font-size: 20px;
      white-space: nowrap;
    }

    .toggle-sidebar-btn {
      font-size: 26px;
      background: none;
      border: none;
      cursor: pointer;
      z-index: 2000;
      color: white;
    }

    .sidebar {
      position: fixed;
      top: 0;
      left: 0;
      width: 250px;
      height: 100%;
      background-color: #2d3e50;
      color: white;
      padding: 20px;
      overflow-y: auto;
      transform: translateX(-100%);
      transition: transform 0.3s ease-in-out;
      z-index: 1000;
      display: flex;
      flex-direction: column;
    }

    .sidebar.open {
      transform: translateX(0);
    }

    .sidebar a,
    .sidebar button {
      margin-bottom: 10px;
      width: 100%;
      text-align: left;
      color: white;
      border-color: #ffffff33;
    }

    body.light-theme .sidebar {
      background-color: #e9ecef;
      color: #212529;
    }

    body.light-theme .sidebar .btn {
      color: #212529;
      border-color: #adb5bd;
    }

    .main-content {
      padding: 20px;
      margin-left: 0;
      transition: margin-left 0.3s ease-in-out;
    }

    .main-content.shifted {
      margin-left: 250px;
    }

    .card {
      background-color: inherit;
      border: 1px solid rgba(255, 255, 255, 0.1);
    }

    .table th, .table td {
      vertical-align: middle;
    }

    .table-responsive {
      margin-top: 10px;
    }

    body.dark-theme .table {
      background-color: #1e1e1e;
      color: #eaeaea;
      border-color: #444;
    }

    body.dark-theme .table th,
    body.dark-theme .table td {
      background-color: #1e1e1e;
      color: #eaeaea;
      border-color: #444;
    }

    body.dark-theme .table-primary {
      background-color: #2b4c73 !important;
      color: #ffffff;
    }

    .btn-action {
      font-size: 14px;
      padding: 4px 8px;
    }

    .btn-view {
      color: #0d6efd;
    }

    .btn-update {
      color: #198754;
    }

    .btn-delete {
      color: #dc3545;
    }

    .btn-action:hover {
      text-decoration: underline;
      cursor: pointer;
    }

    .project-title-link {
      text-decoration: none;
      font-weight: bold;
    }

    .project-title-link:hover {
      text-decoration: underline;
    }

    footer {
      padding: 10px 20px;
      background-color: #243447;
      color: white;
      text-align: center;
    }

    body.light-theme footer {
      background-color: #e9ecef;
      color: #212529;
    }

    .sidebar-overlay {
      position: fixed;
      top: 0;
      left: 0;
      width: 100vw;
      height: 100vh;
      background-color: rgba(0, 0, 0, 0.4);
      z-index: 999;
      opacity: 0;
      visibility: hidden;
      transition: opacity 0.3s ease-in-out;
    }

    .sidebar-overlay.active {
      opacity: 1;
      visibility: visible;
    }
    
    .btn-new-task {
  padding: 6px 12px;
  font-size: 14px;
  font-weight: 500;
  border-radius: 4px;
  border: 1px solid transparent;
  display: inline-block;
  transition: all 0.2s ease-in-out;
  text-decoration: none;
}

/* Light Theme */
body.light-theme .btn-new-task {
  background-color: #0d6efd;
  color: #ffffff;
  border-color: #0d6efd;
}

body.light-theme .btn-new-task:hover {
  background-color: #0b5ed7;
  border-color: #0a58ca;
  color: #ffffff;
}

/* Dark Theme */
body.dark-theme .btn-new-task {
  background-color: #1f6feb;
  color: #ffffff;
  border-color: #1f6feb;
}

body.dark-theme .btn-new-task:hover {
  background-color: #1158c7;
  border-color: #0e4bab;
  color: #ffffff;
}

.no-tasks-message {
  font-size: 16px;
  font-weight: 500;
  padding: 10px 0;
  margin-bottom: 10px;
}

/* Light Theme */
body.light-theme .no-tasks-message {
  color: #6c757d; /* Bootstrap's text-muted color */
}

/* Dark Theme */
body.dark-theme .no-tasks-message {
  color: #adb5bd;
}
  
  .main-header {
  height: 60px;
  background-color: #243447;
  color: white;
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0 20px;
  flex-shrink: 0;
  position: relative;
}

.main-header .header-title {
  position: absolute;
  left: 50%;
  transform: translateX(-50%);
  margin: 0;
  font-size: 20px;
  white-space: nowrap;
}

.main-header .header-right {
  margin-left: auto;
  display: flex;
  align-items: center;
  gap: 15px;
}
    .error-box {
      padding: 30px;
      border: 1px solid #ccc;
      display: inline-block;
      background-color: white;
    }
    h1 {
      color: #dc3545;
    }
    a {
      color: #0d6efd;
      text-decoration: none;
    }
    a:hover {
      text-decoration: underline;
    }
    html, body {
  margin: 0 !important;
  padding: 0 !important;
  height: 100%;
}

.page-wrapper {
  margin: 0 !important;
  padding: 0 !important;
  display: flex;
  flex-direction: column;
  min-height: 100vh;
}

.main-header, footer {
  margin: 0 !important;
  padding: 0 20px;
  width: 100%;
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