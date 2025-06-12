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
      padding: 30px 20px;	
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
/* Light Theme */
body.light-theme .main-content {
  background-color: #ffffff;
  color: #212529;
}

/* Dark Theme */
body.dark-theme .main-content {
  background-color: #1a1a1a;
  color: #eaeaea;
}

/* Styling for links inside main-content */
body.light-theme .main-content a {
  color: #0d6efd;
}

body.dark-theme .main-content a {
  color: #66b2ff;
}

body.light-theme .main-content a:hover,
body.dark-theme .main-content a:hover {
  text-decoration: underline;
}

 .main-content {
  padding: 30px 20px;
  margin-left: 0;
  transition: margin-left 0.3s ease-in-out;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: flex-start;
  min-height: 100%;
}

/* Light Theme */
body.light-theme .main-content {
  background-color: #ffffff;
  color: #212529;
}

/* Dark Theme */
body.dark-theme .main-content {
  background-color: #1a1a1a;
  color: #eaeaea;
}
 /* Card styling */
.card {
  border-radius: 12px;
  background-color: #ffffff;
  border: 1px solid #dee2e6;
}

/* Dark Theme override */
body.dark-theme .card {
  background-color: #2c2c2c;
  color: #eaeaea;
  border: 1px solid #444;
}
 .main-content.shifted {
  margin-left: 250px;
  align-items: center;
}
    
  </style>
</head>
<body class="light-theme">

<div class="main-header">
  <div class="d-flex align-items-center gap-3">
 
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
    <a href="LogoutController" class="btn btn-sm btn-outline-light">
      <i class="bi bi-box-arrow-right"></i> Logout
	</a>
  </div>
</div>

<div class="page-wrapper">
  <div class="main-content" id="mainContent">
   
   	<div class="card p-4 shadow-sm" style="max-width: 700px; width: 100%;">
  <h5 class="mb-3 text-center">Task Details</h5>
  <p><strong>Project Title:</strong> ${join.title}</p>
  <p><strong>Task ID:</strong> ${join.taskId}</p>
  <p><strong>Task Detail:</strong> ${join.taskDetail}</p>
  <p><strong>Assigned By:</strong> ${join.assignedByFirstName} ${join.assignedByLastName}</p>
  <p><strong>Assigned To:</strong> ${join.assignedToFirstName} ${join.assignedToLastName}</p>
  <p><strong>Remarks:</strong> ${join.remarks}</p>
  <p><strong>Status:</strong> ${join.status}</p>
  <p><strong>Assigned Date:</strong> ${join.assignedDate}</p>
  <p><strong>Completion Date:</strong> ${join.completionDate}</p>

  <div class="mt-4 d-flex gap-3 justify-content-center flex-wrap">
    
    <a href="UpdateTaskAControllerForUser?taskId=${join.taskId}" class="btn btn-outline-success">✏️ Update</a>
    <a href="UserIndexController" class="btn btn-outline-success">🏠 Home</a>
  </div>
</div>


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
