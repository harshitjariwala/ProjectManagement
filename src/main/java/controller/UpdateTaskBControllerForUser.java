package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.TaskBean;
import dao.TaskDao;

@WebServlet("/UpdateTaskBControllerForUser")
public class UpdateTaskBControllerForUser extends HttpServlet{
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		TaskBean task = new TaskBean();
		task.setTaskId(Integer.parseInt(request.getParameter("taskId")));
		task.setStatus(request.getParameter("status"));
		
		TaskDao dao = new TaskDao();
		dao.updateTaskForUser(task.getTaskId(),task);
		response.sendRedirect("ViewTaskControllerForUser?taskId="+task.getTaskId());
	}
}
