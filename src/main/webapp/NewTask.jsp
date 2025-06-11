<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored = "false"%>
<%@page import="bean.TaskBean"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Task Manager Dashboard</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet" />
  <style>
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
      margin-top: auto;
  width: 100%;
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
    
    form-wrapper {
   max-width: 800px;
   margin: 0 auto;
   padding: 20px;
   background-color: inherit;
   border-radius: 10px;
 }

 @media (max-width: 768px) {
   .main-content.shifted {
     margin-left: 0;
   }
 }
 
 .error-message {
  color: #dc3545; /* Bootstrap's danger color */
  font-size: 0.9rem;
  margin-top: 4px;
  display: block;
}
  </style>
</head>
<body class="light-theme">
<div class="page-wrapper d-flex flex-column">
<div class="main-header">
  <div class="d-flex align-items-center gap-3">
    <button class="toggle-sidebar-btn" id="toggleSidebarBtn">&#9776;</button>
    <h4 class="m-0">Task Manager Dashboard</h4>
  </div>
  <div class="d-flex align-items-center gap-3">
    <div class="form-check form-switch text-light m-0">
      <input class="form-check-input" type="checkbox" id="themeSwitch">
      <label class="form-check-label" for="themeSwitch">Dark Mode</label>
    </div>
    <div class="d-flex align-items-center gap-2 user-info">
      <img src="https://cdn-icons-png.flaticon.com/512/149/149071.png" alt="User" width="32" height="32" />
      <span id="usernameDisplay">${user.firstName} ${user.lastName}</span>
    </div>
  </div>
</div>

<div class="sidebar" id="taskManagerSidebar">
  <h5 class="mb-4">Task Manager</h5>
  <div>
    <a href="AdminIndexController" class="btn btn-outline-light">🏠 Home</a>
    <a href="Signup.jsp" class="btn btn-outline-light">➕ Add User</a>
    <a href="ListUserController" class="btn btn-outline-light">📋 List Users</a>
    <a href="AddProject.jsp" class="btn btn-outline-light">📁 Add Project</a>
    <a href="NewTaskAController" class="btn btn-outline-light">📝 New Task</a>
    <a href="ListProjectController" class="btn btn-outline-light">📃 List All Projects</a>
    <button class="btn btn-outline-light">📊 Reports</button>
  </div>
  <div class="mt-auto">
    <button class="btn btn-outline-light">🚪 Logout</button>
  </div>
</div>

<div id="sidebarOverlay" class="sidebar-overlay"></div>

<!-- Main Content -->
<!-- With this updated block -->
<div class="main-content" id="mainContent">
<c:if test="${projectList.size() > 0}">
  <div class="container">
    <div class="form-wrapper">
      <form action="NewTaskBController" method="post">
        <label class="form-label">Choose Project:</label>
        <select name="projectId" class="form-select mb-3">
          <c:forEach var="project" items="${projectList}">
            <option value="${project.projectId}" ${projectId == project.projectId?"selected":""}>${project.title}</option>
          </c:forEach>
        </select>

		<div class="mb3">
        <label class="form-label">Task Detail:</label>
        <input type="text" name="taskDetail" class="form-control">
        <span class="error-message">${taskDetailError}</span>
        </div>

        <label class="form-label">Assign By:</label>
        <select name="assignedBy" class="form-select mb-3">
          <c:forEach var="user" items="${userList}">
            <option value="${user.userId}" ${userId == user.userId || assignedBy == user.userId?"selected":""}>${user.firstName} ${user.lastName}</option>
          </c:forEach>
        </select>

        <label class="form-label">Assign To:</label>
        <select name="assignedTo" class="form-select mb-3">
          <c:forEach var="user" items="${userList}">
            <option value="${user.userId}" ${userId == user.userId || assignedTo == user.userId?"selected":""}>${user.firstName} ${user.lastName}</option>
          </c:forEach>
        </select>

        <label class="form-label">Remarks:</label>
        <input type="text" name="remarks" class="form-control mb-3" value="${remarks}">

        <button type="submit" class="btn btn-primary mt-2">Add Task</button>
      </form>
    </div>
  </div>
  </c:if>
  <c:if test="${empty projectList}">
    <div class="alert alert-info mt-4">
      <h5>No active projects found.</h5>
      <p>Please add a new project to start managing tasks.</p>
      <a href="AddProject.jsp" class="btn btn-primary mt-2">➕ Add Project</a>
    </div>
  </c:if>
</div>
</div>
  <footer>
    &copy; 2025 Task Manager. All rights reserved.
  </footer>

<script>
  const sidebar = document.getElementById('taskManagerSidebar');
  const mainContent = document.getElementById('mainContent');
  const toggleSidebarBtn = document.getElementById('toggleSidebarBtn');
  const sidebarOverlay = document.getElementById('sidebarOverlay');

  window.addEventListener('DOMContentLoaded', () => {
    const isDark = localStorage.getItem('theme') === 'dark';
    document.body.classList.toggle('dark-theme', isDark);
    document.body.classList.toggle('light-theme', !isDark);
    document.getElementById('themeSwitch').checked = isDark;
  });

  document.getElementById('themeSwitch').addEventListener('change', function () {
    const isDark = this.checked;
    document.body.classList.toggle('dark-theme', isDark);
    document.body.classList.toggle('light-theme', !isDark);
    localStorage.setItem('theme', isDark ? 'dark' : 'light');
  });

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
