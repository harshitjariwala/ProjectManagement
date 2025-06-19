package filter;

import java.io.IOException;
import javax.servlet.*;

import javax.servlet.annotation.WebFilter;

/**
 * Filter to validate email format using regular expression.
 */
@WebFilter("/ForgetPasswordController")
public class ForgetPasswordFilterBRegEx implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // No initialization needed
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        String email = request.getParameter("email");

        // Safer, slightly improved regex: allows dots before @ and domain parts up to 4 chars
        String emailRegex = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,4}$";

        if (!email.matches(emailRegex)) {
            request.setAttribute("emailError", "Enter a valid Email ID.");
            request.setAttribute("email", email);
            request.getRequestDispatcher("Login.jsp").forward(request, response);
        } else {
            chain.doFilter(request, response);
        }
    }

    @Override
    public void destroy() {
        // No cleanup needed
    }
}
