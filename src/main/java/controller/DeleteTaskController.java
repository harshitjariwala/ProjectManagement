package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.TaskDao;

@WebServlet("/DeleteTaskController")
public class DeleteTaskController extends HttpServlet{
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		TaskDao dao = new TaskDao();
		dao.deleteTask(Integer.parseInt(request.getParameter("taskId")));
		response.sendRedirect("AdminIndexController");
	}
}
