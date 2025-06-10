package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.ProjectBean;
import bean.UserBean;
import dao.ProjectDao;
import dao.UserDao;

@WebServlet("/NewTaskAController")
public class NewTaskAController extends HttpServlet{

	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
		ProjectDao projectDao = new ProjectDao();
		ArrayList<ProjectBean> projectList = projectDao.listProject();
		
		UserDao userDao = new UserDao();
		ArrayList<UserBean> userList = userDao.listUser();
		
		request.setAttribute("userList",userList);
		request.setAttribute("projectList", projectList);
		request.getRequestDispatcher("NewTask.jsp").forward(request, response);
	}
}
