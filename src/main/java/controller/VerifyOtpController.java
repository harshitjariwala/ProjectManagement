package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/VerifyOtpController")
public class VerifyOtpController extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get OTP entered by user
        String enteredOtp = request.getParameter("otp");

        // Get the original OTP stored in session
        HttpSession session = request.getSession();
        String sessionOtp = (String) session.getAttribute("otp");


        // Compare entered OTP with the one in session
        if (enteredOtp != null && enteredOtp.equals(sessionOtp)) {
            // OTP is correct
            session.removeAttribute("otp"); // remove OTP after successful validation
            request.setAttribute("success", "Email verified successfully!");
            request.getRequestDispatcher("AdminIndex.jsp").forward(request, response);
        } else {
            // OTP is incorrect
            request.setAttribute("error", "Invalid OTP. Please try again.");
            request.getRequestDispatcher("otp.jsp").forward(request, response);
        }
    }
}

