package filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;

@WebFilter("/AddProjectController")
public class AddProjectFilterARequired implements Filter{

	public void init(FilterConfig filterConfig) throws ServletException {
		
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		String title = request.getParameter("title");
		
		if(title == null || title.isBlank()) {
			request.setAttribute("title", title);
			request.setAttribute("titleError","Project Title is required");
			request.setAttribute("description", request.getParameter("description"));
			request.getRequestDispatcher("AddProject.jsp").forward(request, response);
		}
		else {
			chain.doFilter(request, response);
		}
	}

	public void destroy() {
		
	}

}
