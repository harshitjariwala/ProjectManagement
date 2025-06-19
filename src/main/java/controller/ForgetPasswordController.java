package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import bean.UserBean;
import dao.UserDao;
import util.EmailOTPUtil;

@WebServlet("/ForgetPasswordController")
public class ForgetPasswordController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");

        // Since filters already validate the email, no need to revalidate here
        String otp = EmailOTPUtil.generateOTP();

        boolean sent = EmailOTPUtil.sendOTP(email, otp); // Assuming this method returns a boolean for success

        if (!sent) {
            // Handle OTP send failure (fallback UI or retry)
            request.setAttribute("emailError", "Failed to send OTP. Please try again.");
            request.setAttribute("email", email);
            request.getRequestDispatcher("Login.jsp").forward(request, response);
            return;
        }

        UserDao dao = new UserDao();
        UserBean user = dao.checkUniqueEmail(email); // Safe as filters ensure email exists

        HttpSession session = request.getSession();
        session.setAttribute("otp", otp);
        session.setAttribute("user", user);

        response.sendRedirect("VerifyOtp.jsp");
    }
}
