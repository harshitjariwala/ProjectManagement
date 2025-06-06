package filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;

@WebFilter("/LoginController")
public class LoginFilterARequired implements Filter{

	public void init(FilterConfig filterConfig) throws ServletException {
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		
		boolean isError = false;
		
		if(email == null || email.isBlank()) {
			request.setAttribute("emailError","Email Id is Required");
			isError = true;
		}
		
		if(password == null || password.isBlank()) {
			request.setAttribute("passwordError","Password is Required");
			isError = true;
		}
		
		if(isError) {
			request.setAttribute("email",email);
			request.setAttribute("password", password);
			request.getRequestDispatcher("Login.jsp").forward(request, response);
		}
		else {
			chain.doFilter(request, response);
		}
	}

	public void destroy() {
	}
	
}
