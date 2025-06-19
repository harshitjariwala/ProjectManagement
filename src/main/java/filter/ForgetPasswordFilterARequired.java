package filter;

import java.io.IOException;
import javax.servlet.*;

import javax.servlet.annotation.WebFilter;

/**
 * Filter to validate that email is provided for forget password functionality.
 */
@WebFilter("/ForgetPasswordController")
public class ForgetPasswordFilterARequired implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // No initialization needed
    }

    /**
     * Checks if 'email' parameter is present and not blank. If missing, sets an error
     * message and forwards back to the login page.
     */
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        String email = request.getParameter("email");

        if (email == null || email.trim().isEmpty()) {
            request.setAttribute("emailError", "Email ID is required.");
            request.getRequestDispatcher("Login.jsp").forward(request, response);
        } else {
            // Input is valid, continue processing
            chain.doFilter(request, response);
        }
    }

    @Override
    public void destroy() {
        // No resource cleanup required
    }
}
