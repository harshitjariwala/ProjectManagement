package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.UserBean;
import dao.UserDao;

@WebServlet("/NewPasswordController")
public class NewPasswordController extends HttpServlet{
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String password = request.getParameter("password");
		
		HttpSession session = request.getSession();
		UserBean user = (UserBean) session.getAttribute("user");
		
		UserDao dao = new UserDao();
		dao.updatePassword(user.getUserId(), password);
		response.sendRedirect("Login.jsp");
	}
}
