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
public class NewPasswordFilterARequired implements Filter{

	public void init(FilterConfig filterConfig) throws ServletException {
	
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		String password = request.getParameter("password");
		String confirmPassword = request.getParameter("confirmPassword");
		
		boolean isError = false;
		
		if(password == null || password.isBlank()) {
			request.setAttribute("passwordError","Password is Required");
			isError = true;
		}
		
		if(confirmPassword == null || confirmPassword.isBlank()) {
			request.setAttribute("confirmPasswordError","Confirm Password is Required");
			isError = true;
		}
		
		if(isError) {
			request.setAttribute("password",password);
			request.setAttribute("confirmPassword",confirmPassword);
			request.getRequestDispatcher("NewPassword.jsp").forward(request, response);
		}
		else {
			chain.doFilter(request, response);
		}
	}

	public void destroy() {
		
	}
}