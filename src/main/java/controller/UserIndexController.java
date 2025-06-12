package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.JoinBean;
import bean.ProjectBean;
import bean.UserBean;
import dao.JoinDao;
import dao.ProjectDao;

@WebServlet("/UserIndexController")
public class UserIndexController extends HttpServlet{

	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		UserBean user = (UserBean) session.getAttribute("user");
		
		ProjectDao projectDao = new ProjectDao();
		ArrayList<ProjectBean> projectList = projectDao.listProject();
		
		JoinDao joinDao = new JoinDao();
		ArrayList<ArrayList<JoinBean>> joinList = new ArrayList<ArrayList<JoinBean>>();
		
		for(ProjectBean i : projectList) {
			if(joinDao.listTaskByProjectIdForUser(i.getProjectId(), user).size() != 0) {
				joinList.add(joinDao.listTaskByProjectIdForUser(i.getProjectId(), user));
			}
		}
		request.setAttribute("projectList", projectList);
		request.setAttribute("joinList", joinList);
		request.getRequestDispatcher("UserIndex.jsp").forward(request, response);
	}
}
