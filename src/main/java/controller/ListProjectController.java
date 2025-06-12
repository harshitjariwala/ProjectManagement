package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.JoinBean;
import dao.JoinDao;

@WebServlet("/ListProjectController")
public class ListProjectController extends HttpServlet{
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		JoinDao dao = new JoinDao();
		ArrayList<JoinBean> list = dao.listTaskByProjectId(Integer.parseInt(request.getParameter("projectId")));
		request.setAttribute("list",list);
		request.getRequestDispatcher("ListProject.jsp").forward(request, response);
	}
}
