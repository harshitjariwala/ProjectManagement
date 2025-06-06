<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Task Manager Dashboard</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
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
      position: relative;
      left: 18px;
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
      flex: 1;
    }

    .main-content.shifted {
      margin-left: 250px;
    }

    @media (max-width: 768px) {
      .main-content.shifted {
        margin-left: 0;
      }
    }

    .card {
      background-color: inherit;
      border: 1px solid rgba(255, 255, 255, 0.1);
    }

    .table th,
    .table td {
      vertical-align: middle;
    }

    body.dark-theme .table thead {
      background-color: #2c3e50;
      color: #f1f1f1;
    }

    body.light-theme .table thead {
      background-color: #dee2e6;
      color: #212529;
    }

    body.dark-theme .table tbody tr {
      background-color: #1c1c1c;
    }

    body.light-theme .table tbody tr {
      background-color: #ffffff;
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

    body.dark-theme .table-success {
      background-color: #276749 !important;
      color: #ffffff;
    }

    body.dark-theme .table-hover tbody tr:hover {
      background-color: #2b2b2b;
    }

    body.light-theme .card-title {
      color: #212529;
    }

    body.dark-theme .card-title {
      color: #f1f1f1;
    }

    .user-info img {
      border-radius: 50%;
    }

    @media (max-width: 768px) {
      .user-info span {
        display: none;
      }
    }

    .main-header.shifted {
      margin-left: 250px;
      transition: margin-left 0.3s ease-in-out;
    }

    @media (max-width: 768px) {
      .main-header.shifted {
        margin-left: 0;
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
    
  </style>
</head>
<body class="light-theme">

  <!-- Header -->
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
      <span id="usernameDisplay"><%= session.getAttribute("username") != null ? session.getAttribute("username") : "Guest" %></span>
    </div>
  </div>
</div>


  <!-- Sidebar -->
  <div class="sidebar" id="taskManagerSidebar">
    <h5 class="mb-4">Task Manager</h5>
    <div>
      <button class="btn btn-outline-light mb-2">🏠 Home</button>
      <button class="btn btn-outline-light mb-2">➕ Add User</button>
      <button class="btn btn-outline-light mb-2">📋 List Users</button>
      <button class="btn btn-outline-light mb-2">📝 New Task</button>
      <button class="btn btn-outline-light mb-2">📊 Reports</button>
    </div>
    <div class="mt-auto">
      <button class="btn btn-outline-light">🚪 Logout</button>
    </div>
  </div>

  <!-- Sidebar Overlay -->
  <div id="sidebarOverlay" class="sidebar-overlay"></div>

  <!-- Main Content -->
  <div class="page-wrapper">
  <div class="main-content" id="mainContent">
    <h2>Projects & Tasks</h2>
    <div class="card mb-4 shadow-sm">
      <div class="card-body">
        <h5 class="card-title">Project Alpha</h5>
        <div class="table-responsive">
          <table class="table table-bordered table-hover table-sm">
            <thead class="table-primary">
              <tr>
                <th>Task ID</th>
                <th>Assigned By</th>
                <th>Assigned To</th>
                <th>Remarks</th>
                <th>Status</th>
                <th>Assign Date</th>
                <th>Completion Date</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td>T001</td>
                <td>Alice Johnson</td>
                <td>Bob Smith</td>
                <td>Design UI mockups.</td>
                <td>In Progress</td>
                <td>2025-06-01</td>
                <td>2025-06-10</td>
              </tr>
              <tr>
                <td>T002</td>
                <td>Alice Johnson</td>
                <td>Sarah Lee</td>
                <td>Integrate frontend with backend.</td>
                <td>Pending</td>
                <td>2025-06-02</td>
                <td>2025-06-12</td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>
    
    <div class="card mb-4 shadow-sm">
      <div class="card-body">
        <h5 class="card-title">Project Alpha</h5>
        <div class="table-responsive">
          <table class="table table-bordered table-hover table-sm">
            <thead class="table-primary">
              <tr>
                <th>Task ID</th>
                <th>Assigned By</th>
                <th>Assigned To</th>
                <th>Remarks</th>
                <th>Status</th>
                <th>Assign Date</th>
                <th>Completion Date</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td>T001</td>
                <td>Alice Johnson</td>
                <td>Bob Smith</td>
                <td>Design UI mockups.</td>
                <td>In Progress</td>
                <td>2025-06-01</td>
                <td>2025-06-10</td>
              </tr>
              <tr>
                <td>T002</td>
                <td>Alice Johnson</td>
                <td>Sarah Lee</td>
                <td>Integrate frontend with backend.</td>
                <td>Pending</td>
                <td>2025-06-02</td>
                <td>2025-06-12</td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>
    
    <div class="card mb-4 shadow-sm">
      <div class="card-body">
        <h5 class="card-title">Project Alpha</h5>
        <div class="table-responsive">
          <table class="table table-bordered table-hover table-sm">
            <thead class="table-primary">
              <tr>
                <th>Task ID</th>
                <th>Assigned By</th>
                <th>Assigned To</th>
                <th>Remarks</th>
                <th>Status</th>
                <th>Assign Date</th>
                <th>Completion Date</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td>T001</td>
                <td>Alice Johnson</td>
                <td>Bob Smith</td>
                <td>Design UI mockups.</td>
                <td>In Progress</td>
                <td>2025-06-01</td>
                <td>2025-06-10</td>
              </tr>
              <tr>
                <td>T002</td>
                <td>Alice Johnson</td>
                <td>Sarah Lee</td>
                <td>Integrate frontend with backend.</td>
                <td>Pending</td>
                <td>2025-06-02</td>
                <td>2025-06-12</td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>
    
    <div class="card mb-4 shadow-sm">
      <div class="card-body">
        <h5 class="card-title">Project Alpha</h5>
        <div class="table-responsive">
          <table class="table table-bordered table-hover table-sm">
            <thead class="table-primary">
              <tr>
                <th>Task ID</th>
                <th>Assigned By</th>
                <th>Assigned To</th>
                <th>Remarks</th>
                <th>Status</th>
                <th>Assign Date</th>
                <th>Completion Date</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td>T001</td>
                <td>Alice Johnson</td>
                <td>Bob Smith</td>
                <td>Design UI mockups.</td>
                <td>In Progress</td>
                <td>2025-06-01</td>
                <td>2025-06-10</td>
              </tr>
              <tr>
                <td>T002</td>
                <td>Alice Johnson</td>
                <td>Sarah Lee</td>
                <td>Integrate frontend with backend.</td>
                <td>Pending</td>
                <td>2025-06-02</td>
                <td>2025-06-12</td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  
  </div>

  <!-- Footer -->
  <footer>
    &copy; 2025 Task Manager. All rights reserved.
  </footer>
</div>
  <!-- JavaScript -->
  <script>
    const themeSwitch = document.getElementById('themeSwitch');
    const sidebar = document.getElementById('taskManagerSidebar');
    const mainContent = document.getElementById('mainContent');
    const toggleSidebarBtn = document.getElementById('toggleSidebarBtn');
    const sidebarOverlay = document.getElementById('sidebarOverlay');

    themeSwitch.addEventListener('change', function () {
      const isDark = this.checked;
      document.body.classList.toggle('dark-theme', isDark);
      document.body.classList.toggle('light-theme', !isDark);
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
