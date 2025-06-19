<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Reports Dashboard</title>

  <!-- Bootstrap + Icons + Chart.js -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet" />
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

  <style>
    html, body {
      height: 100%;
      margin: 0;
    }

    .page-wrapper {
      display: flex;
      flex-direction: column;
      min-height: 100vh;
    }

    .main-header {
      height: 60px;
      background-color: #243447;
      color: white;
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 0 20px;
    }

    .main-header h4 {
      margin: 0 auto;
      font-size: 20px;
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
      transition: transform 0.3s ease-in-out;
      transform: translateX(-100%);
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

    .main-content {
      flex: 1;
      padding: 20px;
      margin-left: 0;
      transition: margin-left 0.3s ease-in-out;
    }

    .main-content.shifted {
      margin-left: 250px;
    }

    footer {
      background-color: #243447;
      color: white;
      text-align: center;
      padding: 10px 0;
    }

    .chart-card {
      max-width: 900px;
      margin: 0 auto 30px;
      padding: 20px;
      border-radius: 12px;
      box-shadow: 0 0 10px rgba(0,0,0,0.05);
      background-color: white;
      height: 400px;
    }

    .chart-card canvas {
      width: 100% !important;
      height: 100% !important;
      display: block;
    }

    body.dark-theme {
      background-color: #121212;
      color: white;
    }

    body.dark-theme .main-header,
    body.dark-theme .sidebar,
    body.dark-theme footer {
      background-color: #1f1f1f;
      color: white;
    }

    body.dark-theme .chart-card {
      background-color: #1e1e1e;
    }

    .toggle-sidebar-btn {
      font-size: 26px;
      background: none;
      border: none;
      color: white;
      cursor: pointer;
    }

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

    body.light-theme .sidebar {
      background-color: #e9ecef;
      color: #212529;
    }

    body.light-theme .sidebar .btn {
      color: #212529;
      border-color: #adb5bd;
    }
  </style>
</head>

<body class="light-theme">
  <div class="page-wrapper">

    <!-- Header -->
    <div class="main-header">
      <div class="d-flex align-items-center gap-3">
        <button class="toggle-sidebar-btn" id="toggleSidebarBtn">&#9776;</button>
        <h4 class="m-0 flex-grow-1 text-center">Task Manager Dashboard</h4>
      </div>
      <div class="d-flex align-items-center gap-3">
        <div class="form-check form-switch text-light m-0">
          <input class="form-check-input" type="checkbox" id="themeSwitch">
          <label class="form-check-label" for="themeSwitch">Dark Mode</label>
        </div>
        <div class="d-flex align-items-center gap-2">
          <img src="https://cdn-icons-png.flaticon.com/512/149/149071.png" width="32" height="32" />
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
      <a class="btn btn-outline-light mb-2" href="AdminIndexController">🏠 Home</a>
      <a class="btn btn-outline-light mb-2" href="Signup.jsp">➕ Add User</a>
      <a class="btn btn-outline-light mb-2" href="ListUserController">📋 List Users</a>
      <a class="btn btn-outline-light mb-2" href="AddProject.jsp">📁 Add Project</a>
      <a class="btn btn-outline-light mb-2" href="NewTaskAController">📝 New Task</a>
      <a class="btn btn-outline-light mb-2" href="ListAllProjectsController">📃 All Projects</a>
      <a class="btn btn-outline-light mb-2">📊 Reports</a>
    </div>
    <div class="sidebar-overlay" id="sidebarOverlay"></div>

    <!-- Main Content -->
    <div class="main-content" id="mainContent">
      <div class="chart-card">
        <h5>📊 Tasks per Project</h5>
        <canvas id="barChart"></canvas>
      </div>

      <div class="chart-card">
        <h5>📈 Task Status Distribution</h5>
        <canvas id="doughnutChart"></canvas>
      </div>
    </div>

    <!-- Footer -->
    <footer>
      &copy; 2025 Task Manager. All rights reserved.
    </footer>

  </div>

  <!-- Sidebar & Theme Toggle Script -->
  <script>
    const toggleSidebarBtn = document.getElementById('toggleSidebarBtn');
    const sidebar = document.getElementById('taskManagerSidebar');
    const mainContent = document.getElementById('mainContent');
    const overlay = document.getElementById('sidebarOverlay');

    toggleSidebarBtn.onclick = () => {
      sidebar.classList.toggle('open');
      mainContent.classList.toggle('shifted');
      overlay.classList.toggle('active');
    };

    overlay.onclick = () => {
      sidebar.classList.remove('open');
      mainContent.classList.remove('shifted');
      overlay.classList.remove('active');
    };

    const isDark = localStorage.getItem('theme') === 'dark';
    document.body.classList.toggle('dark-theme', isDark);
    document.body.classList.toggle('light-theme', !isDark);
    document.getElementById('themeSwitch').checked = isDark;

    document.getElementById('themeSwitch').addEventListener('change', function () {
      const dark = this.checked;
      document.body.classList.toggle('dark-theme', dark);
      document.body.classList.toggle('light-theme', !dark);
      localStorage.setItem('theme', dark ? 'dark' : 'light');
    });
  </script>

  <!-- Chart.js Initialization -->
  <script>
    // Bar Chart
    new Chart(document.getElementById("barChart"), {
      type: 'bar',
      data: {
        labels: ['Project A', 'Project B', 'Project C'],
        datasets: [{
          label: 'Tasks',
          data: [12, 19, 7],
          backgroundColor: ['#0d6efd', '#198754', '#ffc107']
        }]
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        aspectRatio: 2,
        scales: {
          y: { beginAtZero: true }
        }
      }
    });

    // Doughnut Chart
    new Chart(document.getElementById("doughnutChart"), {
      type: 'doughnut',
      data: {
        labels: ['Completed', 'In Progress', 'Pending'],
        datasets: [{
          data: [10, 5, 3],
          backgroundColor: ['#198754', '#0dcaf0', '#ffc107']
        }]
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        aspectRatio: 2
      }
    });
  </script>

</body>
</html>
