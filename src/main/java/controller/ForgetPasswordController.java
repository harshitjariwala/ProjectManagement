package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import util.EmailOTPUtil;

@WebServlet("/ForgetPasswordController")
public class ForgetPasswordController extends HttpServlet{
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
		String email = request.getParameter("email");
		String otp = EmailOTPUtil.generateOTP();

		boolean sent = EmailOTPUtil.sendOTP(email, otp);
		
		HttpSession session = request.getSession();

		if (sent) {
		    session.setAttribute("otp", otp);
		    session.setAttribute("email",email);
		    response.sendRedirect("verifyOtp.jsp");
		} else {
		    request.setAttribute("error", "Failed to send OTP. Please try again.");
		    request.getRequestDispatcher("emailVerification.jsp").forward(request, response);
		}

	}
}
