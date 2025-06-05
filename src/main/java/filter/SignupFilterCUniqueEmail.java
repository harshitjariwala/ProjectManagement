package filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;

import bean.UserBean;
import dao.UserDao;

@WebFilter("/SignupController")
public class SignupFilterCUniqueEmail implements Filter{

	public void init(FilterConfig filterConfig) throws ServletException {
	
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		String email = request.getParameter("email");
		UserDao dao = new UserDao();
		UserBean user = dao.checkUniqueEmail(email);
		
		if(user != null) {
			request.setAttribute("firstName",request.getParameter("firstName"));
			request.setAttribute("lastName",request.getParameter("lastName"));
			request.setAttribute("email",email);
			request.setAttribute("emailError","Already have an account on this Email ID");
			request.setAttribute("password",request.getParameter("password"));
			request.setAttribute("confirmPassword",request.getParameter("confirmPassword"));
			request.setAttribute("role",request.getParameter("role"));
			request.getRequestDispatcher("Signup.jsp").forward(request, response);
		}
		else {
			chain.doFilter(request, response);
		}
	}

	public void destroy() {
	
	}

}
