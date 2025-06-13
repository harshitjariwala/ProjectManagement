<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Login - Task Manager</title>
  
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>

  <style>
    html, body {
      height: 100%;
      margin: 0;
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
    }

    .toggle-sidebar-btn {
      font-size: 26px;
      background: none;
      border: none;
      cursor: pointer;
      color: white;
    }

    .signup-container {
      flex: 1;
      display: flex;
      justify-content: center;
      align-items: center;
      padding: 20px;
    }

    .signup-card {
      width: 100%;
      max-width: 500px;
      background-color: inherit;
      border: 1px solid rgba(255, 255, 255, 0.2);
      border-radius: 12px;
      padding: 30px;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }

    .form-label {
      font-weight: 500;
    }

    body.dark-theme .form-control,
    body.dark-theme .form-select {
      background-color: #1c1c1c;
      color: #f1f1f1;
      border: 1px solid #444;
    }

    body.light-theme .form-control,
    body.light-theme .form-select {
      background-color: #fff;
      color: #212529;
      border: 1px solid #ced4da;
    }

    .error-message {
      color: #dc3545; /* Bootstrap's danger color */
      font-size: 0.9rem;
      margin-top: 4px;
      display: block;
    }

    footer {
      padding: 10px 20px;
      text-align: center;
      background-color: #243447;
      color: white;
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
  <div class="main-header">
    <div style="width: 33%;"></div>

    <!-- Page Title -->
    <div class="text-center" style="width: 34%;">
      <h4 class="m-0">Login Page</h4>
    </div>

    <!-- Theme Switch -->
    <div class="d-flex justify-content-end align-items-center" style="width: 33%;">
      <div class="form-check form-switch text-light m-0">
        <input class="form-check-input" type="checkbox" id="themeSwitch">
        <label class="form-check-label" for="themeSwitch">Dark Mode</label>
      </div>
    </div>
  </div>

  <!-- Login Form -->
  <div class="signup-container">
    <div class="signup-card">
      <h3 class="text-center mb-4">Login</h3>

      <form action="LoginController" method="post">
        <div class="mb-3">
          <label for="email" class="form-label">Email Address</label>
          <input type="text" class="form-control" name="email" value="${email}" id="loginEmail">
          <span class="error-message">${emailError}</span>
        </div>

        <div class="mb-3">
          <label for="password" class="form-label">Password</label>
          <input type="password" class="form-control" name="password" value="${password}">
          <span class="error-message">${passwordError}</span>
        </div>

        <div class="d-grid">
          <button type="submit" class="btn btn-primary">Login</button>
        </div>

        <div class="text-center mt-3">
          <small>Don't have an account? <a href="Signup.jsp">Signup here</a></small>
        </div>
      </form>

      <!-- Forgot Password Form -->
      <form action="ForgetPasswordController" method="post" id="forgotForm">
        <input type="hidden" name="email" id="forgotEmail" />
        <div class="text-center mt-3">
          <button type="submit" class="btn btn-link p-0" style="text-decoration: none;">Forgot Password?</button>
        </div>
      </form>
    </div>
  </div>

  <!-- Footer -->
  <footer>
    &copy; 2025 Task Manager. All rights reserved.
  </footer>

  <!-- JavaScript for Theme and Forgot Password -->
  <script>
    // Load saved theme from localStorage on page load
    window.addEventListener('DOMContentLoaded', () => {
      const isDark = localStorage.getItem('theme') === 'dark';
      document.body.classList.toggle('dark-theme', isDark);
      document.body.classList.toggle('light-theme', !isDark);
      document.getElementById('themeSwitch').checked = isDark;
    });

    // Update theme preference in localStorage on toggle
    document.getElementById('themeSwitch').addEventListener('change', function () {
      const isDark = this.checked;
      document.body.classList.toggle('dark-theme', isDark);
      document.body.classList.toggle('light-theme', !isDark);
      localStorage.setItem('theme', isDark ? 'dark' : 'light');
    });

    // Copy email to hidden input before submitting forgot password form
    document.getElementById("forgotForm").addEventListener("submit", function () {
      const emailInput = document.getElementById("loginEmail");
      const forgotEmail = document.getElementById("forgotEmail");
      forgotEmail.value = emailInput.value.trim();
    });
  </script>
</body>
</html>