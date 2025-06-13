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
 * Filter to validate email format using a regular expression.
 * If the email format is invalid, it returns the user to the Login.jsp page with an error message.
 */
@WebFilter("/LoginController")
public class LoginFilterBRegEx implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // No initialization needed
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        String email = request.getParameter("email");

        // Simple regex to check email format
        String emailRegex = "^[a-zA-Z0-9._%+-]+@[a-zA-Z]+\\.[a-zA-Z]{2,3}$";

        // If email doesn't match the pattern, return with error
        if (email == null || !email.matches(emailRegex)) {
            request.setAttribute("emailError", "Enter Valid Email Id");

            // Retain entered values (except password ideally)
            request.setAttribute("email", email);
            request.setAttribute("password", request.getParameter("password")); // Optional: avoid this for security

            request.getRequestDispatcher("Login.jsp").forward(request, response);
        } else {
            // Proceed if email format is valid
            chain.doFilter(request, response);
        }
    }

    @Override
    public void destroy() {
        // No cleanup necessary
    }
}
