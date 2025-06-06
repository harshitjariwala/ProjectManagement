<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>OTP Verification - Task Manager</title>
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

    .error-message {
      color: #dc3545;
      font-size: 0.9rem;
      margin-top: 6px;
    }

    .success-message {
      color: #28a745;
      font-size: 0.9rem;
      margin-top: 6px;
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
    .resend-link {
  margin-left: 6px;
  color: #0d6efd;
  text-decoration: none;
  font-weight: 500;
  transition: color 0.2s ease-in-out;
}

.resend-link:hover {
  color: #0a58ca;
  text-decoration: underline;
}
    
  </style>
</head>
<body class="light-theme">

<!-- Header -->
<div class="main-header d-flex justify-content-between align-items-center">
  <div style="width: 33%;"></div>
  <div class="text-center" style="width: 34%;">
    <h4 class="m-0">OTP Verification</h4>
  </div>
  <div class="d-flex justify-content-end align-items-center" style="width: 33%;">
    <div class="form-check form-switch text-light m-0">
      <input class="form-check-input" type="checkbox" id="themeSwitch">
      <label class="form-check-label" for="themeSwitch">Dark Mode</label>
    </div>
  </div>
</div>

<!-- OTP Form -->
<div class="signup-container">
  <div class="signup-card">
    <h3 class="text-center mb-4">Enter OTP</h3>
    <form action="VerifyOtpController" method="post">
      <div class="mb-3">
        <label for="otp" class="form-label">6-digit OTP</label>
        <input type="text" class="form-control" name="otp">
      </div>
      <div class="d-grid">
        <button type="submit" class="btn btn-primary">Verify OTP</button>
      </div>
    </form>
    <div class="text-center mt-3">
  <span>Didn't receive OTP?</span>

  <form action="ForgetPasswordController" method="post">
  <input type="hidden" name="email" value="${email}">
  <button type="submit" class="btn btn-link p-0">Resend OTP</button>
</form>

</div>

  </div>
</div>

<!-- Footer -->
<footer>
  &copy; 2025 Task Manager. All rights reserved.
</footer>

<!-- JavaScript for Theme Switch -->
<script>
  const themeSwitch = document.getElementById('themeSwitch');
  themeSwitch.addEventListener('change', function () {
    const isDark = this.checked;
    document.body.classList.toggle('dark-theme', isDark);
    document.body.classList.toggle('light-theme', !isDark);
  });
</script>

</body>
</html>
