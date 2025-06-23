package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.ProjectBean;
import bean.StatusBean;
import dao.ProjectDao;
import dao.TaskDao;

@WebServlet("/ReportController")
public class ReportController extends HttpServlet{
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		ProjectDao projectDao = new ProjectDao();
		ArrayList<ProjectBean> projectList = projectDao.listAllProjects();
		request.setAttribute("projectList",projectList);
		
		TaskDao taskDao = new TaskDao();
		ArrayList<StatusBean> taskList = taskDao.countTaskByStatus();
		request.setAttribute("taskList", taskList);
		request.getRequestDispatcher("Report.jsp").forward(request, response);
	}
}
