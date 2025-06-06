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
public class LoginFilterBRegEx implements Filter{

	public void init(FilterConfig filterConfig) throws ServletException {
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		String email = request.getParameter("email");
		
		String emailRegex = "[a-zA-Z0-9-_]+@[a-zA-Z]+\\.[a-zA-Z]{2,3}";
		if(email.matches(emailRegex) == false) {
			request.setAttribute("emailError", "Enter Valid Email Id");
			request.setAttribute("email",email);
			request.setAttribute("password",request.getParameter("password"));
			request.getRequestDispatcher("Login.jsp").forward(request, response);	
		}
		else {
			chain.doFilter(request, response);
		}
	}

	public void destroy() {
		
	}

}
