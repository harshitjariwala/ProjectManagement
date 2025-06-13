package filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;

/**
 * Filter to validate required fields for user signup
 * Validates firstName, email, password, and confirmPassword before processing
 */
@WebFilter("/SignupController")
public class SignupFilterARequired implements Filter {

    /**
     * Initialize filter configuration
     */
    public void init(FilterConfig filterConfig) throws ServletException {
        // Filter initialization code can be added here if needed
    }

    /**
     * Validates required signup form fields
     * If validation fails, forwards back to signup page with error messages
     * If validation passes, continues to the next filter/servlet in chain
     */
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        // Get form parameters
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String role = request.getParameter("role");
        
        boolean isError = false;
        
        // Validate firstName - required field
        if (firstName == null || firstName.isBlank()) {
            request.setAttribute("firstNameError", "First Name is Required");
            isError = true;
        }
        
        // Validate email - required field
        if (email == null || email.isBlank()) {
            request.setAttribute("emailError", "Email Id is Required");
            isError = true;
        }
        
        // Validate password - required field
        if (password == null || password.isBlank()) {
            request.setAttribute("passwordError", "Password is Required");
            isError = true;
        }
        
        // Validate confirmPassword - required field
        if (confirmPassword == null || confirmPassword.isBlank()) {
            request.setAttribute("confirmPasswordError", "Confirm Password is Required");
            isError = true;
        }
        
        // If validation errors exist, forward back to signup page
        if (isError) {
            // Preserve form data for user convenience
            request.setAttribute("firstName", firstName);
            request.setAttribute("lastName", lastName);
            request.setAttribute("email", email);
            request.setAttribute("password", password);
            request.setAttribute("confirmPassword", confirmPassword);
            request.setAttribute("role", role);
            
            // Forward to signup page with error messages
            request.getRequestDispatcher("Signup.jsp").forward(request, response);
        } else {
            // All required fields are valid, continue to next filter/servlet
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