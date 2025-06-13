package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import bean.UserBean;
import dao.UserDao;

/**
 * Handles login requests for the application.
 * Authenticates the user and redirects based on their role.
 */
@WebServlet("/LoginController")
public class LoginController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Fetch login form parameters
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Authenticate user
        UserDao dao = new UserDao();
        UserBean user = dao.authenticateUser(email, password);

        if (user == null) {
            // Invalid credentials
            request.setAttribute("passwordError", "Invalid Credentials");
            request.setAttribute("email", email);
            request.setAttribute("password", password); // ⚠ Optional: remove this for security
            request.getRequestDispatcher("Login.jsp").forward(request, response);
        } else {
            // Valid user, start session
            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            // Redirect based on user role
            if ("admin".equalsIgnoreCase(user.getRole())) {
                response.sendRedirect("AdminIndexController");
            } else {
                response.sendRedirect("UserIndexController");
            }
        }
    }
}
