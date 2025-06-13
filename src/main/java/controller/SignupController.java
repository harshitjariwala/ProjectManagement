package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.UserBean;
import dao.UserDao;

/**
 * Servlet controller to handle user signup functionality
 * Processes POST requests from signup form after validation filters
 */
@WebServlet("/SignupController")
public class SignupController extends HttpServlet {
    
    /**
     * Handles POST request for user registration
     * Creates new user account and redirects to login page
     * 
     * @param request HttpServletRequest containing form data
     * @param response HttpServletResponse for sending redirect
     * @throws ServletException if servlet error occurs
     * @throws IOException if I/O error occurs
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Create new user bean object
        UserBean user = new UserBean();
        
        // Set user properties from form parameters
        user.setFirstName(request.getParameter("firstName"));
        user.setLastName(request.getParameter("lastName"));
        user.setEmail(request.getParameter("email"));
        user.setPassword(request.getParameter("password"));
        user.setRole(request.getParameter("role"));
        
        // Save user to database
        UserDao dao = new UserDao();
        dao.insertUser(user);
        
        // Redirect to login page after successful registration
        response.sendRedirect("Login.jsp");
    }
}