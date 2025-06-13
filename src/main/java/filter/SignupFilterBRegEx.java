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
 * Filter to validate signup form fields using regular expressions
 * Validates format of firstName, lastName, email and password matching
 */
@WebFilter("/SignupController")
public class SignupFilterBRegEx implements Filter {

    /**
     * Initialize filter configuration
     */
    public void init(FilterConfig filterConfig) throws ServletException {
        // Filter initialization code can be added here if needed
    }

    /**
     * Validates form field formats using regex patterns
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
        
        // Define regex patterns for validation
        String alphaRegex = "[a-zA-Z]+";
        String emailRegex = "[a-zA-Z0-9-_]+@[a-zA-Z]+\\.[a-zA-Z]{2,3}";
        
        boolean isError = false;
        
        // Validate firstName format - must contain only alphabetic characters
        if (firstName.matches(alphaRegex) == false) {
            request.setAttribute("firstNameError", "Enter valid First Name");
            isError = true;
        }
        
        // Validate lastName format - only if provided (optional field)
        if (lastName.matches(alphaRegex) == false && lastName != null && lastName.isBlank() != true) {
            request.setAttribute("lastNameError", "Enter valid Last Name");
            isError = true;
        }
        
        // Validate email format
        if (email.matches(emailRegex) == false) {
            request.setAttribute("emailError", "Enter valid Email ID");
            isError = true;
        }
        
        // Validate password matching
        if (password.equals(confirmPassword) == false) {
            request.setAttribute("passwordError", "Password and Confirm Password should be same");
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
            // All validations passed, continue to next filter/servlet
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