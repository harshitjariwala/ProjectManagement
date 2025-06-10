package filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;

@WebFilter("/VerifyOtpController")
public class VerifyOtpFilterBLengthCheck implements Filter{

	public void init(FilterConfig filterConfig) throws ServletException {
	
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		String otp = request.getParameter("otp");
		
		if(otp.length() != 6) {
			request.setAttribute("error","Enter the 6 digit OTP");
			request.getRequestDispatcher("VerifyOtp.jsp").forward(request, response);
		}
		else {
			chain.doFilter(request, response);
		}
	}

	public void destroy() {
	
	}
}