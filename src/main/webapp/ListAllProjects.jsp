<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>List All Projects</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
  <style>
    html, body {
      height: 100%;
      margin: 0;
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
    }

    .main-header h4 {
      margin: 0 auto;
      font-size: 20px;
    }

    .toggle-sidebar-btn {
      font-size: 26px;
      background: none;
      border: none;
      color: white;
      cursor: pointer;
    }

    .sidebar {
      position: fixed;
      top: 0;
      left: 0;
      width: 250px;
      height: 100%;
      background-color: #2d3e50;
      color: white;
      display: flex;
      flex-direction: column;
      padding: 20px;
      transform: translateX(-100%);
      transition: transform 0.3s ease-in-out;
      z-index: 1000;
    }

    .sidebar.open {
      transform: translateX(0);
    }

    .sidebar a.btn, .sidebar button.btn {
      margin-bottom: 10px;
      text-align: left;
      width: 100%;
    }

    body.light-theme .sidebar {
      background-color: #e9ecef;
      color: #212529;
    }

    body.light-theme .sidebar a.btn {
      color: #212529;
      border-color: #adb5bd;
    }

    body.dark-theme .sidebar a.btn {
      color: #ffffff;
      border-color: rgba(255, 255, 255, 0.4);
    }

    .main-content {
      margin-left: 0;
      padding: 20px;
      transition: margin-left 0.3s ease-in-out;
      flex: 1;
    }

    .main-content.shifted {
      margin-left: 250px;
    }

    .page-wrapper {
      display: flex;
      flex-direction: column;
      min-height: 100vh;
    }

    footer {
      background-color: #243447;
      color: white;
      padding: 10px 20px;
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
      pointer-events: none;
      transition: opacity 0.3s ease-in-out;
    }

    .sidebar-overlay.active {
      opacity: 1;
      visibility: visible;
      pointer-events: all;
    }

    .btn-add-project {
      margin-top: 20px;
    }

    /* Dark Theme Table Styling */
    body.dark-theme .table {
      background-color: #1e1e1e;
      color: #eaeaea;
      border-color: #444;
    }

    body.dark-theme .table thead {
      background-color: #2c2c3c !important;
      color: #ffffff;
    }

    body.dark-theme .table-striped > tbody > tr:nth-of-type(odd) {
      background-color: rgba(255, 255, 255, 0.05);
    }

    body.dark-theme .table-striped > tbody > tr:hover {
      background-color: rgba(255, 255, 255, 0.1) ;
    }

    body.dark-theme .table-bordered th,
    body.dark-theme .table-bordered td {
      border-color: #444c56;
    }

    body.dark-theme .project-title-link {
      color: #7abaff;
      text-decoration: none;
    }

    body.dark-theme .project-title-link:hover {
      color: #90cfff;
      text-decoration: underline;
    }
    body.dark-theme .table th,
    body.dark-theme .table td {
      background-color: #1e1e1e;
      color: #eaeaea;
      border-color: #444;
    }
    body.dark-theme .table-primary {
      background-color: #2b4c73;	
      color: #ffffff;
    }
    
    body.light-theme .project-title-link {
      text-decoration: none;
    }

    body.light-theme .project-title-link:hover {
      text-decoration: underline;
    }
  </style>
</head>
<body class="light-theme">
<div class="main-header">
  <div class="d-flex align-items-center gap-3">
    <button class="toggle-sidebar-btn" id="toggleSidebarBtn">&#9776;</button>
  </div>
  <div class="d-flex align-items-center gap-3">
    <div class="form-check form-switch text-light">
      <input class="form-check-input" type="checkbox" id="themeSwitch">
      <label class="form-check-label" for="themeSwitch">Dark Mode</label>
    </div>
    <div class="d-flex align-items-center gap-2 user-info">
      <img src="https://cdn-icons-png.flaticon.com/512/149/149071.png" alt="User" width="32" height="32">
      <span id="usernameDisplay">${user.firstName} ${user.lastName}</span>
    </div>
    
    <a href="LogoutController" class="btn btn-sm btn-outline-light">
      <i class="bi bi-box-arrow-right"></i> Logout
	</a>
  </div>
</div>

<div class="sidebar" id="taskManagerSidebar">
  <h5 class="mb-4">Task Manager</h5>
  <div class="sidebar-links">
    <a href="AdminIndexController" class="btn btn-outline-light">🏠 Home</a>
    <a href="Signup.jsp" class="btn btn-outline-light">➕ Add User</a>
    <a href="ListUserController" class="btn btn-outline-light">📋 List Users</a>
    <a href="AddProject.jsp" class="btn btn-outline-light">📁 Add Project</a>
    <a class="btn btn-outline-light">📃 List All Projects</a>
    <a href="NewTaskAController" class="btn btn-outline-light">📝 New Task</a>
    <a href="ReportController" class="btn btn-outline-light">📊 Reports</a>
  </div>
</div>
<div id="sidebarOverlay" class="sidebar-overlay"></div>

<div class="page-wrapper">
  <div class="main-content" id="mainContent">
    <c:if test="${projectList.size() > 0}">
      <div class="table-responsive">
        <table class="table table-bordered table-striped">
          <thead class="table-primary">
            <tr>
              <th>Project ID</th>
              <th>Title</th>
              <th>Description</th>
              <th>Number of Tasks</th>
              <th>Active</th>
              <th>Actions</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="project" items="${projectList}">
              <tr>
                <td>${project.projectId}</td>
                <td>
                  <a href="ListProjectController?projectId=${project.projectId}" class="project-title-link">
                    📁 ${project.title}
                  </a>
                </td>
                <td>${project.description}</td>
                <td>${project.noOfTasks}</td>
                <td>${project.active ? 'Yes' : 'No'}</td>
                <td>
    <!-- If project is active, show Deactivate + Delete -->
    <c:if test="${project.active}">
      <a href="DeactivateProjectController?projectId=${project.projectId}" class="btn btn-warning btn-sm me-1">Deactivate</a>
      <a href="DeleteProjectController?projectId=${project.projectId}" class="btn btn-danger btn-sm">Delete</a>
    </c:if>

    <!-- If project is NOT active, show Activate + Delete -->
    <c:if test="${project.active == false}">
      <a href="ActivateProjectController?projectId=${project.projectId}" class="btn btn-success btn-sm me-1">Activate</a>
      <a href="DeleteProjectController?projectId=${project.projectId}" class="btn btn-danger btn-sm">Delete</a>
    </c:if>
</td>
                
              </tr>
            </c:forEach>
          </tbody>
        </table>
      </div>
    </c:if>

    <c:if test="${empty projectList}">
      <div class="alert alert-info mt-4">
        <h5>No active projects found.</h5>
        <p>Please add a new project to start managing tasks.</p>
        <a href="AddProject.jsp" class="btn btn-primary mt-2">➕ Add Project</a>
      </div>
    </c:if>

    <c:if test="${projectList.size() > 0}">
      <div class="text-center">
        <a href="AddProject.jsp" class="btn btn-success btn-add-project">Add Project</a>
      </div>
    </c:if>
  </div>

  <footer>
    &copy; 2025 Task Manager. All rights reserved.
  </footer>
</div>

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
	