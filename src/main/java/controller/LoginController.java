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

@WebServlet("/LoginController")
public class LoginController extends HttpServlet{
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		
		UserDao dao = new UserDao();
		UserBean user = dao.authenticateUser(email, password);
		
		if(user == null) {
			request.setAttribute("passwordError","Invalid Credentials");
			request.setAttribute("email",email);
			request.setAttribute("password",password);
			request.getRequestDispatcher("Login.jsp").forward(request, response);
		}
		else {
			HttpSession session = request.getSession();
			session.setAttribute("user",user);
			if(user.getRole().equals("admin")) {
				response.sendRedirect("AdminIndexController");
			}			
			else {
				response.sendRedirect("UserIndex.jsp");
			}
		}
	}
}
