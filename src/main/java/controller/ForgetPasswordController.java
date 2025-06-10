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
import util.EmailOTPUtil;

@WebServlet("/ForgetPasswordController")
public class ForgetPasswordController extends HttpServlet{
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
		String email = request.getParameter("email");
		String otp = EmailOTPUtil.generateOTP();

		EmailOTPUtil.sendOTP(email, otp);
		
		HttpSession session = request.getSession();
		
		UserDao dao = new UserDao();
		UserBean user = dao.checkUniqueEmail(email);
		session.setAttribute("otp", otp);
		session.setAttribute("user",user);
		response.sendRedirect("VerifyOtp.jsp");
	}
}
