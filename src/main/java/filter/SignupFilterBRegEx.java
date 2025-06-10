package filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;

@WebFilter("/SignupController")
public class SignupFilterBRegEx implements Filter{

	public void init(FilterConfig filterConfig) throws ServletException {
	
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		String firstName = request.getParameter("firstName");
		String lastName = request.getParameter("lastName");
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String confirmPassword = request.getParameter("confirmPassword");
		
		String alphaRegex = "[a-zA-Z]+";
		String emailRegex = "[a-zA-Z0-9-_]+@[a-zA-Z]+\\.[a-zA-Z]{2,3}";
		
		boolean isError = false;
		
		if(firstName.matches(alphaRegex) == false) {
			request.setAttribute("firstNameError","Enter valid First Name");
			isError = true;
		}
		
		if(lastName.matches(alphaRegex) == false && lastName != null && lastName.isBlank() != true) {
			request.setAttribute("lastNameError","Enter valid Last Name");
			isError = true;
		}
		
		if(email.matches(emailRegex) == false) {
			request.setAttribute("emailError","Enter valid Email ID");
			isError = true;
		}
		
		if(password.equals(confirmPassword) == false) {
			request.setAttribute("passwordError","Password and Confirm Password should be same");
			isError = true;
		}
		
		if(isError) {
			request.setAttribute("firstName",firstName);
			request.setAttribute("lastName",lastName);
			request.setAttribute("email",email);
			request.setAttribute("password",password);
			request.setAttribute("confirmPassword",confirmPassword);
			request.setAttribute("role",request.getParameter("role"));
			request.getRequestDispatcher("Signup.jsp").forward(request, response);
		}
		else {
			chain.doFilter(request, response);
		}
	}

	public void destroy() {
	
	}

}
