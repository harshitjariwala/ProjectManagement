package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.TaskBean;
import dao.TaskDao;

@WebServlet("/UpdateTaskBController")
public class UpdateTaskBController extends HttpServlet{
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
		TaskBean task = new TaskBean();
		task.setTaskId(Integer.parseInt(request.getParameter("taskId")));
		task.setProjectId(Integer.parseInt(request.getParameter("projectId")));
		task.setTaskDetail(request.getParameter("taskDetail"));
		task.setAssignedBy(Integer.parseInt(request.getParameter("assignedBy")));
		task.setAssignedTo(Integer.parseInt(request.getParameter("assignedTo")));
		task.setRemarks(request.getParameter("remarks"));
		task.setStatus(request.getParameter("status"));
		
		TaskDao dao = new TaskDao();
		dao.updateTask(task.getTaskId(), task);
		response.sendRedirect("ViewTaskController?taskId="+task.getTaskId());
	}
}
