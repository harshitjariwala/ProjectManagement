package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ProjectDao;

@WebServlet("/ActivateProjectController")
public class ActivateProjectController extends HttpServlet{

	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		ProjectDao dao = new ProjectDao();
		dao.activateProject(Integer.parseInt(request.getParameter("projectId")));
		response.sendRedirect("AdminIndexController");
	}
}
