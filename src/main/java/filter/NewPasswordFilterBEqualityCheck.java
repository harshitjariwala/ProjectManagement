package filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;

@WebFilter("/NewPasswordController")
public class NewPasswordFilterBEqualityCheck implements Filter{

	public void init(FilterConfig filterConfig) throws ServletException {
	
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		String password = request.getParameter("password");
		String confirmPassword = request.getParameter("confirmPassword");
		
		if(password.equals(confirmPassword)) {
			chain.doFilter(request, response);
		}
		else {
			request.setAttribute("passwordError","Password and Confirm Password must be same");
			request.setAttribute("password",password);
			request.setAttribute("confirmPassword",confirmPassword);
			request.getRequestDispatcher("NewPassword.jsp").forward(request, response);
		}
	}

	public void destroy() {
		
	}
}