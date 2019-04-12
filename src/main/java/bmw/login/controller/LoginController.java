package bmw.login.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class LoginController {
	
	
	@RequestMapping(value="/", method=RequestMethod.GET)
	public void loginPage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
				
		RequestDispatcher dispatcher = request.getRequestDispatcher("/loginPageForm.jsp");
		dispatcher.forward(request, response);
		
	}
	
	
	@RequestMapping(value="/access_denied_page")
    public String accessDeniedPage() throws Exception {
      
		return "/denied/access_denied_page";
    }


	

}
