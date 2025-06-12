package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.JoinBean;
import dao.JoinDao;

@WebServlet("/UpdateTaskAControllerForUser")
public class UpdateTaskAControllerForUser extends HttpServlet{
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		JoinDao joinDao = new JoinDao();
		JoinBean join = joinDao.getTaskById(Integer.parseInt(request.getParameter("taskId")));
		
		request.setAttribute("join",join);
		request.getRequestDispatcher("UpdateTaskForUser.jsp").forward(request, response);
	}
}
