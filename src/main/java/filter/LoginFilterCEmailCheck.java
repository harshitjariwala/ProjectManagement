package filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;

import bean.UserBean;
import dao.UserDao;

/**
 * Filter to check if the entered email is registered in the system.
 * If not registered, it sets an error message and forwards back to Login.jsp.
 */
@WebFilter("/LoginController")
public class LoginFilterCEmailCheck implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // No initialization required
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        String email = request.getParameter("email");

        // Check if email exists in the database
        UserDao dao = new UserDao();
        UserBean user = dao.checkUniqueEmail(email);

        if (user == null) {
            // Email not found, show error and return to login
            request.setAttribute("emailError", "Email Id is not Registered");
            request.setAttribute("email", email);
            request.setAttribute("password", request.getParameter("password")); // Consider removing this for security
            request.getRequestDispatcher("Login.jsp").forward(request, response);
        } else {
            // Proceed if email exists
            chain.doFilter(request, response);
        }
    }

    @Override
    public void destroy() {
        // No resource cleanup needed
    }
}
