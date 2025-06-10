package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.JoinBean;
import bean.ProjectBean;
import bean.TaskBean;
import dao.JoinDao;
import dao.ProjectDao;
import dao.TaskDao;

@WebServlet("/AdminIndexController")
public class AdminIndexController extends HttpServlet{
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ProjectDao projectDao = new ProjectDao();
		ArrayList<ProjectBean> projectList = projectDao.listProject();
		
		JoinDao joinDao = new JoinDao();
		ArrayList<ArrayList<JoinBean>> joinList = new ArrayList<>();
		
		for(ProjectBean i : projectList) {
			joinList.add(joinDao.listTaskByProjectId(i.getProjectId()));
		}
		
		request.setAttribute("projectList",projectList);
		request.setAttribute("joinList", joinList);
		request.getRequestDispatcher("AdminIndex.jsp").forward(request, response);
	}
}
