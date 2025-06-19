<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Add New Project</title>

  <!-- Bootstrap CSS and Icons -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

  <style>
    /* General Layout */
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
      padding: 20px;
      margin-left: 0;
      transition: margin-left 0.3s ease-in-out;
    }

    .main-content.shifted {
      margin-left: 250px;
    }

    /* Light & Dark Theme */
    body.light-theme {
      background-color: #f4f6fa;
      color: #212529;
    }

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
      z-index: 1;
    }

    .main-header h4 {
      position: absolute;
      left: 50%;
      transform: translateX(-50%);
      margin: 0;
      font-size: 20px;
    }

    .toggle-sidebar-btn {
      font-size: 26px;
      background: none;
      border: none;
      cursor: pointer;
      color: white;
    }

    /* Sidebar */
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

    .sidebar button,
    .sidebar a {
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

    /* Card Title Theme Support */
    body.light-theme .card-title {
      color: #212529;
    }

    body.dark-theme .card-title {
      color: #f1f1f1;
    }

    /* User Profile Image */
    .user-info img {
      border-radius: 50%;
    }

    /* Responsive Hiding Username */
    @media (max-width: 768px) {
      .main-content.shifted,
      .main-header.shifted {
        margin-left: 0;
      }
      .user-info span {
        display: none;
      }
    }

    /* Sidebar Overlay */
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

    /* Footer */
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

    body.dark-theme footer {
      background-color: #1a1a1a;
      color: #f1f1f1;
    }

    /* Form container for centering form */
    .form-container {
      max-width: 600px;
      margin: 30px auto 0;
    }

    .error-message {
      color: #dc3545;
      font-size: 0.8rem;
      margin-top: 2px;
      display: block;
    }
  </style>
</head>
<body class="light-theme">

<!-- Header -->
<div class="main-header">
  <div class="d-flex align-items-center gap-3">
    <button class="toggle-sidebar-btn" id="toggleSidebarBtn">&#9776;</button>
    <h4 class="m-0">Task Manager Dashboard</h4>
  </div>

  <div class="d-flex align-items-center gap-3">
    <!-- Theme toggle -->
    <div class="form-check form-switch text-light m-0">
      <input class="form-check-input" type="checkbox" id="themeSwitch">
      <label class="form-check-label" for="themeSwitch">Dark Mode</label>
    </div>

    <!-- User info display -->
    <div class="d-flex align-items-center gap-2 user-info">
      <img src="https://cdn-icons-png.flaticon.com/512/149/149071.png" alt="User" width="32" height="32" />
      <span id="usernameDisplay">${user.firstName} ${user.lastName}</span>
    </div>

    <!-- Logout -->
    <a href="LogoutController" class="btn btn-sm btn-outline-light">
      <i class="bi bi-box-arrow-right"></i> Logout
    </a>
  </div>
</div>

<!-- Sidebar Navigation -->
<div class="sidebar" id="taskManagerSidebar">
  <h5 class="mb-4">Task Manager</h5>
  <div>
    <a href="AdminIndexController" class="btn btn-outline-light mb-2">🏠 Home</a>
    <a href="Signup.jsp" class="btn btn-outline-light mb-2">➕ Add User</a>
    <a href="ListUserController" class="btn btn-outline-light mb-2">📋 List Users</a>
    <a class="btn btn-outline-light mb-2">📁 Add Project</a>
    <a href="NewTaskAController" class="btn btn-outline-light">📝 New Task</a>
    <a href="ListAllProjectsController" class="btn btn-outline-light">📃 List All Projects</a>
    <a href="ReportController" class="btn btn-outline-light mb-2">📊 Reports</a>
  </div>
</div>

<!-- Sidebar Overlay -->
<div id="sidebarOverlay" class="sidebar-overlay"></div>

<!-- Page Content -->
<div class="page-wrapper">
  <div class="main-content" id="mainContent">
    <h2>Add New Project</h2>
    <div class="form-container">
      <form action="AddProjectController" method="post">
        <!-- Title Input -->
        <div class="mb-3">
          <label for="projectTitle" class="form-label">Project Title</label>
          <input type="text" class="form-control" id="projectTitle" name="title" value="${title}">
          <span class="error-message">${titleError}</span>
        </div>

        <!-- Description Input -->
        <div class="mb-3">
          <label for="projectDescription" class="form-label">Project Description</label>
          <textarea class="form-control" id="projectDescription" name="description" rows="4">${description}</textarea>
        </div>

        <!-- Submit -->
        <button type="submit" class="btn btn-primary">Create Project</button>
      </form>
    </div>
  </div>

  <!-- Footer -->
  <footer>
    &copy; 2025 Task Manager. All rights reserved.
  </footer>
</div>

<!-- JS Logic -->
<script>
  const sidebar = document.getElementById('taskManagerSidebar');
  const mainContent = document.getElementById('mainContent');
  const toggleSidebarBtn = document.getElementById('toggleSidebarBtn');
  const sidebarOverlay = document.getElementById('sidebarOverlay');

  // Load theme preference from local storage
  window.addEventListener('DOMContentLoaded', () => {
    const isDark = localStorage.getItem('theme') === 'dark';
    document.body.classList.toggle('dark-theme', isDark);
    document.body.classList.toggle('light-theme', !isDark);
    document.getElementById('themeSwitch').checked = isDark;
  });

  // Theme switch toggle handler
  document.getElementById('themeSwitch').addEventListener('change', function () {
    const isDark = this.checked;
    document.body.classList.toggle('dark-theme', isDark);
    document.body.classList.toggle('light-theme', !isDark);
    localStorage.setItem('theme', isDark ? 'dark' : 'light');
  });

  // Sidebar toggle functionality
  function toggleSidebar() {
    const isOpen = sidebar.classList.toggle('open');
    mainContent.classList.toggle('shifted', isOpen);
    sidebarOverlay.classList.toggle('active', isOpen);
  }

  toggleSidebarBtn.addEventListener('click', toggleSidebar);
  sidebarOverlay.addEventListener('click', toggleSidebar);
</script>

</body>
</html>
