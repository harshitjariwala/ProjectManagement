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
 * Filter to validate email uniqueness during user signup
 * Checks if the provided email already exists in the database
 */
@WebFilter("/SignupController")
public class SignupFilterCUniqueEmail implements Filter {

    /**
     * Initialize filter configuration
     */
    public void init(FilterConfig filterConfig) throws ServletException {
        // Filter initialization code can be added here if needed
    }

    /**
     * Validates email uniqueness by checking database
     * If email already exists, forwards back to signup page with error message
     * If email is unique, continues to the next filter/servlet in chain
     */
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        // Get email parameter from request
        String email = request.getParameter("email");
        
        // Check if email already exists in database
        UserDao dao = new UserDao();
        UserBean user = dao.checkUniqueEmail(email);
        
        // If user exists with this email, show error
        if (user != null) {
            // Preserve all form data for user convenience
            request.setAttribute("firstName", request.getParameter("firstName"));
            request.setAttribute("lastName", request.getParameter("lastName"));
            request.setAttribute("email", email);
            request.setAttribute("password", request.getParameter("password"));
            request.setAttribute("confirmPassword", request.getParameter("confirmPassword"));
            request.setAttribute("role", request.getParameter("role"));
            
            // Set error message for duplicate email
            request.setAttribute("emailError", "Already have an account on this Email ID");
            
            // Forward back to signup page with error
            request.getRequestDispatcher("Signup.jsp").forward(request, response);
        } else {
            // Email is unique, continue to next filter/servlet
            chain.doFilter(request, response);
        }
    }

    /**
     * Clean up filter resources
     */
    public void destroy() {
        // Cleanup code can be added here if needed
    }
}