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

import bean.ProjectBean;
import bean.UserBean;
import dao.ProjectDao;
import dao.UserDao;

@WebFilter("/UpdateTaskBController")
public class UpdateTaskBFilterARequired implements Filter{

	public void init(FilterConfig filterConfig) throws ServletException {
	
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
String taskDetail = request.getParameter("taskDetail");
		
		if(taskDetail == null || taskDetail.isBlank()) {
			ProjectDao projectDao = new ProjectDao();
			ArrayList<ProjectBean> projectList = projectDao.listProject();
			
			UserDao userDao = new UserDao();
			ArrayList<UserBean> userList = userDao.listUser();
			
			request.setAttribute("taskId", request.getParameter("taskId"));
			request.setAttribute("userList",userList);
			request.setAttribute("projectList", projectList);
			request.setAttribute("taskDetailError","Task Details is Required");
			request.setAttribute("projectId",request.getParameter("projectId"));
			request.setAttribute("assignedBy", request.getParameter("assignedBy"));
			request.setAttribute("assignedTo",request.getParameter("assignedTo"));
			request.setAttribute("remarks",request.getParameter("remarks"));
			request.setAttribute("status", request.getParameter("status"));
			request.setAttribute("assignedDate",request.getParameter("assignedDate"));
			request.setAttribute("completionDate",request.getParameter("completionDate"));
			request.getRequestDispatcher("UpdateTask.jsp").forward(request, response);
		}
		else {
			chain.doFilter(request, response);
		}
	}

	public void destroy() {
	
		
	}
	
}
