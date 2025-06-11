package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.ProjectBean;
import dao.ProjectDao;

@WebServlet("/ListAllProjectsController")
public class ListAllProjectsController extends HttpServlet{
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		ProjectDao dao = new ProjectDao();
		ArrayList<ProjectBean> projectList = dao.listProject();
		request.setAttribute("projectList",projectList);
		request.getRequestDispatcher("ListAllProjects.jsp").forward(request, response);
	}
}
