package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.ProjectBean;
import dao.ProjectDao;

@WebServlet("/UpdateDescriptionController")
public class UpdateDescriptionController extends HttpServlet{
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		ProjectDao dao = new ProjectDao();
		ProjectBean project = dao.getprojectInfo(Integer.parseInt(request.getParameter("projectId")));
		request.setAttribute("project",project);
		request.getRequestDispatcher("UpdateDescription.jsp").forward(request, response);
	}
}
