package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ProjectDao;

@WebServlet("/UpdateDescriptionBController")
public class UpdateDescriptionBController extends HttpServlet{
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		ProjectDao dao = new ProjectDao();
		dao.updateDescription(Integer.parseInt(request.getParameter("projectId")), request.getParameter("description"));
		response.sendRedirect("AdminIndexController");
	}
}
