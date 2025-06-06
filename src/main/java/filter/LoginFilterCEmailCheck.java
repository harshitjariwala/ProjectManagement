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

@WebFilter("/LoginController")
public class LoginFilterCEmailCheck implements Filter{

	public void init(FilterConfig filterConfig) throws ServletException {
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		String email = request.getParameter("email");
		
		UserDao dao = new UserDao();
		UserBean user = dao.checkUniqueEmail(email);
		
		if(user == null) {
			request.setAttribute("emailError","Email Id is not Registered");
			request.setAttribute("email",email);
			request.setAttribute("password", request.getParameter("password"));
			request.getRequestDispatcher("Login.jsp").forward(request, response);
		}
		else {
			chain.doFilter(request, response);
		}
	}

	public void destroy() {
		
	}

}
