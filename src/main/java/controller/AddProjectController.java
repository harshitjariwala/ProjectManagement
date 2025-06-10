package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.ProjectBean;
import dao.ProjectDao;

@WebServlet("/AddProjectController")
public class AddProjectController extends HttpServlet{
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String title = request.getParameter("title");
		String description = request.getParameter("description");
		
		ProjectBean project = new ProjectBean();
		project.setTitle(title);
		project.setDescription(description);
		project.setActive("True");
		
		ProjectDao dao = new ProjectDao();
		dao.insertProject(project);
		response.sendRedirect("AdminIndexController");
	}
}
