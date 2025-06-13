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
 * Filter to validate login form input.
 * Checks if email and password fields are non-empty.
 * If validation fails, it forwards back to Login.jsp with error messages.
 */
@WebFilter("/LoginController")
public class LoginFilterARequired implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // No initialization logic needed for now
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        boolean isError = false;

        // Validate email
        if (email == null || email.isBlank()) {
            request.setAttribute("emailError", "Email Id is Required");
            isError = true;
        }

        // Validate password
        if (password == null || password.isBlank()) {
            request.setAttribute("passwordError", "Password is Required");
            isError = true;
        }

        if (isError) {
            // Preserve values in case of error
            request.setAttribute("email", email);
            request.setAttribute("password", password);
            
            // Forward back to login page
            request.getRequestDispatcher("Login.jsp").forward(request, response);
        } else {
            // Proceed to next filter or servlet
            chain.doFilter(request, response);
        }
    }

    @Override
    public void destroy() {
        // No cleanup necessary
    }
}
