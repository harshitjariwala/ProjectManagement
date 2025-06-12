package filter;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;

import bean.TaskBean;
import dao.TaskDao;

@WebFilter("/DeleteProjectController")
public class DeleteProjectFilter implements Filter{

	public void init(FilterConfig filterConfig) throws ServletException {
		
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		TaskDao dao = new TaskDao();
		ArrayList<TaskBean> list = dao.getTaskByProjectId(Integer.parseInt(request.getParameter("projectId")));
		if(list.size() != 0) {
			request.setAttribute("ProjectDeleteError","Connot Delete the project.Delete the tasks associated with this Project in order to delete the project");
			request.getRequestDispatcher("AdminIndexController").forward(request, response);
		}else {
			chain.doFilter(request, response);
		}
	}

	public void destroy() {
	
	}	
}