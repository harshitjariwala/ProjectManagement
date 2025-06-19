<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Task Manager Dashboard</title>

  <!-- Bootstrap & Icons -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet" />

  <style>
    /* Reset and layout */
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

    /* Theme Colors */
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

    /* Sidebar */
    .toggle-sidebar-btn {
      font-size: 26px;
      background: none;
      border: none;
      cursor: pointer;
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

    .sidebar a, .sidebar button {
      margin-bottom: 10px;
      width: 100%;
      text-align: left;
      color: white;
    }

    body.light-theme .sidebar {
      background-color: #e9ecef;
      color: #212529;
    }

    body.light-theme .sidebar .btn {
      color: #212529;
    }

    /* Table & Cards */
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

    body.dark-theme .table, body.dark-theme .table th, body.dark-theme .table td {
      background-color: #1e1e1e;
      color: #eaeaea;
      border-color: #444;
    }

    body.dark-theme .table-primary {
      background-color: #2b4c73 !important;
    }

    /* Buttons */
    .btn-action {
      font-size: 14px;
      padding: 4px 8px;
    }

    .btn-view { color: #0d6efd; }
    .btn-update { color: #198754; }
    .btn-delete { color: #dc3545; }

    .btn-action:hover {
      text-decoration: underline;
      cursor: pointer;
    }

    /* Project link */
    .project-title-link {
      text-decoration: none;
      font-weight: bold;
    }

    .project-title-link:hover {
      text-decoration: underline;
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

    /* Overlay */
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

    /* New Task Button */
    .btn-new-task {
      padding: 6px 12px;
      font-size: 14px;
      font-weight: 500;
      border-radius: 4px;
      text-decoration: none;
    }

    body.light-theme .btn-new-task {
      background-color: #0d6efd;
      color: #fff;
    }

    body.light-theme .btn-new-task:hover {
      background-color: #0b5ed7;
    }

    body.dark-theme .btn-new-task {
      background-color: #1f6feb;
      color: #fff;
    }

    body.dark-theme .btn-new-task:hover {
      background-color: #1158c7;
    }

    .no-tasks-message {
      font-size: 16px;
      font-weight: 500;
      margin-bottom: 10px;
    }

    body.light-theme .no-tasks-message { color: #6c757d; }
    body.dark-theme .no-tasks-message { color: #adb5bd; }
    
    .project-description-box {
  
  padding: 12px 15px;
  margin-top: 10px;
  display: flex;
  justify-content: space-between;
  align-items: start;
  gap: 10px;
  flex-wrap: wrap;
}

body.dark-theme .project-description-box {
  background-color: rgba(18, 18, 18);
  color: #e0e0e0;
}

.project-description-box p {
  margin: 0;
  font-size: 15px;
  font-style: italic;
  line-height: 1.4;
  flex-grow: 1;
}

.project-description-box a.btn-outline-info {
	white-space: nowrap;
  font-weight: 500;
}body.light-theme .sidebar .btn {
      color: #212529;
      border-color: #adb5bd;
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
    <div class="form-check form-switch text-light m-0">
      <input class="form-check-input" type="checkbox" id="themeSwitch">
      <label class="form-check-label" for="themeSwitch">Dark Mode</label>
    </div>
    <div class="d-flex align-items-center gap-2 user-info">
      <img src="https://cdn-icons-png.flaticon.com/512/149/149071.png" alt="User" width="32" height="32" />
      <span>${user.firstName} ${user.lastName}</span>
    </div>
    <a href="LogoutController" class="btn btn-sm btn-outline-light">
      <i class="bi bi-box-arrow-right"></i> Logout
    </a>
  </div>
</div>

<!-- Sidebar -->
<div class="sidebar" id="taskManagerSidebar">
  <h5 class="mb-4">Task Manager</h5>
  <a class="btn btn-outline-light">🏠 Home</a>
  <a href="Signup.jsp" class="btn btn-outline-light">➕ Add User</a>
  <a href="ListUserController" class="btn btn-outline-light">📋 List Users</a>
  <a href="AddProject.jsp" class="btn btn-outline-light">📁 Add Project</a>
  <a href="NewTaskAController" class="btn btn-outline-light">📝 New Task</a>
  <a href="ListAllProjectsController" class="btn btn-outline-light">📃 List All Projects</a>
  <a href="ReportController" class="btn btn-outline-light">📊 Reports</a>
</div>

<!-- Sidebar Overlay -->
<div id="sidebarOverlay" class="sidebar-overlay"></div>

<!-- Main Content -->
<div class="page-wrapper">
  <div class="main-content" id="mainContent">
    <h2>Projects & Tasks</h2>

    <!-- Loop through projects and display tasks -->
    <c:if test="${joinList.size() > 0}">
      <c:forEach var="i" begin="0" end="${joinList.size() - 1}">
        <div class="card mb-4 shadow-sm">
          <div class="card-body">
            <h5 class="card-title d-flex justify-content-between align-items-center">
              <span>
                <a href="ListProjectController?projectId=${projectList[i].projectId}" class="project-title-link text-primary">📁 ${projectList[i].title}</a>
              </span>
              <span class="d-flex gap-2">
                <a href="DeactivateProjectController?projectId=${projectList[i].projectId}" class="btn btn-sm btn-warning">🛑 Deactivate</a>
                <a href="DeleteProjectController?projectId=${projectList[i].projectId}" class="btn btn-sm btn-danger">🗑️ Delete</a>
              </span>
            </h5>
            <div class="project-description-box mt-2">
  <p class="mb-2">${projectList[i].description}</p>
  <a href="UpdateDescriptionController?projectId=${projectList[i].projectId}" class="btn btn-sm btn-outline-info">✏️ Change Description</a>
</div>

            <div class="table-responsive">
              <table class="table table-bordered table-hover table-sm">
                <thead class="table-primary">
                  <tr>
                    <th>Task ID</th>
                    <th>Task Detail</th>
                    <th>Assigned By</th>
                    <th>Assigned To</th>
                    <th>Remarks</th>
                    <th>Status</th>
                    <th>Assign Date</th>
                    <th>Completion Date</th>
                    <th>Action</th>
                  </tr>
                </thead>
                <tbody>
                  <c:if test="${joinList[i].size() > 0}">
                    <c:forEach var="j" begin="0" end="${joinList[i].size() > 2 ? 2 : joinList[i].size() - 1}">
                      <tr>
                        <td>${joinList[i][j].taskId}</td>
                        <td>${joinList[i][j].taskDetail}</td>
                        <td>${joinList[i][j].assignedByFirstName} ${joinList[i][j].assignedByLastName}</td>
                        <td>${joinList[i][j].assignedToFirstName} ${joinList[i][j].assignedToLastName}</td>
                        <td>${joinList[i][j].remarks}</td>
                        <td>
                          <span class="badge
                            <c:choose>
                              <c:when test="${joinList[i][j].status == 'Initialized'}">bg-primary</c:when>
                              <c:when test="${joinList[i][j].status == 'In Progress'}">bg-info text-dark</c:when>
                              <c:when test="${joinList[i][j].status == 'Pending'}">bg-warning text-dark</c:when>
                              <c:when test="${joinList[i][j].status == 'On Hold'}">bg-secondary</c:when>
                              <c:when test="${joinList[i][j].status == 'Completed'}">bg-success</c:when>
                              <c:when test="${joinList[i][j].status == 'Cancelled'}">bg-danger</c:when>
                              <c:otherwise>bg-light text-dark</c:otherwise>
                            </c:choose>">
                            ${joinList[i][j].status}
                          </span>
                        </td>
                        <td>${joinList[i][j].assignedDate}</td>
                        <td>${joinList[i][j].completionDate}</td>
                        <td class="text-center">
                          <a href="ViewTaskController?taskId=${joinList[i][j].taskId}" class="btn-action btn-view"><i class="bi bi-eye-fill"></i> View</a>
                          <a href="UpdateTaskAController?taskId=${joinList[i][j].taskId}" class="btn-action btn-update"><i class="bi bi-pencil-square"></i> Update</a>
                          <a href="DeleteTaskController?taskId=${joinList[i][j].taskId}" class="btn-action btn-delete"><i class="bi bi-trash-fill"></i> Delete</a>
                        </td>
                      </tr>
                    </c:forEach>
                  </c:if>
                </tbody>
              </table>
            </div>

            <c:if test="${empty joinList[i]}">
              <p class="no-tasks-message">No tasks available for this project.</p>
              <a href="NewTaskAController" class="btn-new-task">📝 New Task</a>
            </c:if>
          </div>
        </div>
      </c:forEach>
    </c:if>

    <!-- No projects available -->
    <c:if test="${empty joinList}">
      <div class="alert alert-info mt-4">
        <h5>No active projects found.</h5>
        <p>Please add a new project to start managing tasks.</p>
        <a href="AddProject.jsp" class="btn btn-primary mt-2">➕ Add Project</a>
      </div>
    </c:if>
  </div>

  <!-- Footer -->
  <footer>
    &copy; 2025 Task Manager. All rights reserved.
  </footer>
</div>

<!-- JavaScript: Theme + Sidebar Toggle -->
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

<!-- SweetAlert for Project Deletion Errors -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<c:if test="${not empty ProjectDeleteError}">
  <script>
    Swal.fire({
      icon: 'error',
      title: 'Oops...',
      text: '${ProjectDeleteError}'
    });
  </script>
</c:if>

</body>
</html>