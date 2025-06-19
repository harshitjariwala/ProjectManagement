package filter;

import java.io.IOException;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;

import bean.UserBean;
import dao.UserDao;

@WebFilter("/ForgetPasswordController")
public class ForgetPasswordFilterCEmailCheck implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // No initialization needed
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        String email = request.getParameter("email");

        // Null/blank check for safety if other filters fail
        if (email.isBlank()) {
            request.setAttribute("emailError", "Email ID is required");
            request.getRequestDispatcher("Login.jsp").forward(request, response);
            return;
        }

        UserDao dao = new UserDao();
        UserBean user = dao.checkUniqueEmail(email);

        if (user == null) {
            request.setAttribute("emailError", "Email ID is not registered");
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
