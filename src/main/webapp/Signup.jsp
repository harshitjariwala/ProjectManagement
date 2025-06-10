<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored = "false"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Signup - Task Manager</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
  <style>
    html, body {
      height: 100%;
      margin: 0;
      display: flex;
      flex-direction: column;
      overflow: hidden;
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
  min-height: 60px;
  max-height: 60px;
  flex-shrink: 0;
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
  flex: 1 1 auto;
  overflow-y: auto;
  display: flex;
  justify-content: center;
  align-items: center;
  padding: 10px;
}

.signup-card {
  width: 100%;
  max-width: 500px;
  background-color: inherit;
  border: 1px solid rgba(255, 255, 255, 0.2);
  border-radius: 12px;
  padding: 25px;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
  max-height: 100%;
  overflow-y: auto;
}

    .form-label {
  font-weight: 500;
  font-size: 0.9rem;
  margin-bottom: 4px;
}

    body.dark-theme .form-control {
      background-color: #1c1c1c;
      color: #f1f1f1;
      border: 1px solid #444;
    }

    body.light-theme .form-control {
      background-color: #fff;
      color: #212529;
      border: 1px solid #ced4da;
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

    body.dark-theme footer {
      background-color: #1a1a1a;
      color: #f1f1f1;
    }
    body.dark-theme .form-select {
  background-color: #1c1c1c;
  color: #f1f1f1;
  border: 1px solid #444;
}

body.light-theme .form-select {
  background-color: #fff;
  color: #212529;
  border: 1px solid #ced4da;
}

.error-message {
  color: #dc3545; /* Bootstrap's danger color */
  font-size: 0.8rem;
  margin-top: 2px;
  display: block;
}
footer {
  flex-shrink: 0;
  padding: 10px 20px;
  background-color: #243447;
  color: white;
  text-align: center;
}
.form-control,
.form-select {
  padding: 6px 10px;
  font-size: 0.9rem;
}
    
  </style>
</head>
<body class="light-theme">

  <!-- Header -->
<div class="main-header d-flex justify-content-between align-items-center">
  <!-- Sidebar Toggle (optional space) -->
  <div class="d-flex align-items-center" style="width: 33%;">
    <!-- You can add sidebar toggle button here if needed -->
  </div>

  <!-- Centered Title -->
  <div class="text-center" style="width: 34%;">
    <h4 class="m-0">Signup Page</h4>
  </div>

  <!-- Theme Toggle -->
  <div class="d-flex justify-content-end align-items-center" style="width: 33%;">
    <div class="form-check form-switch text-light m-0">
      <input class="form-check-input" type="checkbox" id="themeSwitch">
      <label class="form-check-label" for="themeSwitch">Dark Mode</label>
    </div>
  </div>
</div>


  <!-- Signup Form -->
  <div class="signup-container">
    <div class="signup-card">
      <h3 class="text-center mb-4">Create an Account</h3>
      <form action="SignupController" method="post">
  <div class="mb-3">
    <label for="firstName" class="form-label">First Name</label>
    <input type="text" class="form-control" name="firstName" value="${firstName}">
    <span class="error-message">${firstNameError}</span>
  </div>
  <div class="mb-3">
    <label for="lastName" class="form-label">Last Name</label>
    <input type="text" class="form-control" name="lastName" value="${lastName}">
    <span class="error-message">${lastNameError}</span>
  </div>
  <div class="mb-3">
    <label for="email" class="form-label">Email Address</label>
    <input type="text" class="form-control" name="email" value="${email}">
    <span class="error-message">${emailError}</span>
  </div>
  <div class="mb-3">
    <label for="password" class="form-label">Password</label>
    <input type="password" class="form-control" name="password" value="${password}">
    <span class="error-message">${passwordError}</span>
  </div>
  <div class="mb-3">
    <label for="confirmPassword" class="form-label">Confirm Password</label>
    <input type="password" class="form-control" name="confirmPassword" value="${confirmPassword}">
    <span class="error-message">${confirmPasswordError}</span>
  </div>
  <div class="mb-3">
    <label for="role" class="form-label">Role</label>
    <select class="form-select" name="role">
      <option value="admin" ${role.equals("admin") ? "selected" : ""}>Admin</option>
      <option value="user" ${role.equals("user") ? "selected" : ""}>User</option>
    </select>
  </div>
  <div class="d-grid">
    <button type="submit" class="btn btn-primary">Sign Up</button>
  </div>
  <div class="text-center mt-3">
    <small>Already have an account? <a href="Login.jsp">Login here</a></small>
  </div>
</form>

    </div>
  </div>

  <!-- Footer -->
  <footer>
    &copy; 2025 Task Manager. All rights reserved.
  </footer>

  <!-- JavaScript -->
  <script>
  // Apply saved theme on page load
  window.addEventListener('DOMContentLoaded', () => {
    const isDark = localStorage.getItem('theme') === 'dark';
    document.body.classList.toggle('dark-theme', isDark);
    document.body.classList.toggle('light-theme', !isDark);
    document.getElementById('themeSwitch').checked = isDark;
  });

  // Save theme when toggled
  document.getElementById('themeSwitch').addEventListener('change', function () {
    const isDark = this.checked;
    document.body.classList.toggle('dark-theme', isDark);
    document.body.classList.toggle('light-theme', !isDark);
    localStorage.setItem('theme', isDark ? 'dark' : 'light');
  });
  </script>

</body>
</html>
