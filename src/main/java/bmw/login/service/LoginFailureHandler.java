package bmw.login.service;

import java.io.IOException;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.CredentialsExpiredException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

import bmw.util.MessageUtils;

public class LoginFailureHandler implements AuthenticationFailureHandler {

	@Resource(name="userSer")
    private UserService userSer;


	
	private String member_id_name;
	private String member_pw_name;
	private String errorMsgName;
	private String defaultFailureUrl;
	int cnt = 0;
	
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException exception) throws IOException, ServletException {
		
		String username = request.getParameter(member_id_name);
		String password = request.getParameter(member_pw_name);
		String errorMsg = null;
		
		if(exception instanceof BadCredentialsException) {
			loginFailureCount(username);
			errorMsg = MessageUtils.getMessage("error.BadCredentials");
			
			if (cnt < 5) {
			request.setAttribute("cnt", "비밀번호 오류 : ("+ cnt +"/5) 남음");
			} else {
				request.setAttribute("cnt", "비밀번호 5회 오류 : 관리자에게 문의하세요");
			}
			
        } else if(exception instanceof InternalAuthenticationServiceException) {
        	errorMsg = MessageUtils.getMessage("error.BadCredentials");
        } else if(exception instanceof DisabledException) {
        	errorMsg = MessageUtils.getMessage("error.Disaled");
        } else if(exception instanceof CredentialsExpiredException) {
        	errorMsg = MessageUtils.getMessage("error.CredentialsExpired");
        }


		
		request.setAttribute(member_id_name, username);
		request.setAttribute(member_pw_name, password);
		request.setAttribute(errorMsgName, errorMsg );
		
		
		
		request.getRequestDispatcher("loginPageForm.jsp").forward(request, response);
		
	}
	
	protected void loginFailureCount(String username) {
		userSer.countFailure(username);
		cnt = userSer.checkFailureCount(username);
		if(cnt==5) {
			userSer.disabledUsername(username);
		}
	}

	public String getMember_id_name() {
		return member_id_name;
	}

	public void setMember_id_name(String member_id_name) {
		this.member_id_name = member_id_name;
	}

	public String getMember_pw_name() {
		return member_pw_name;
	}

	public void setMember_pw_name(String member_pw_name) {
		this.member_pw_name = member_pw_name;
	}

	public String getErrorMsgName() {
		return errorMsgName;
	}

	public void setErrorMsgName(String errorMsgName) {
		this.errorMsgName = errorMsgName;
	}

	public String getDefaultFailureUrl() {
		return defaultFailureUrl;
	}

	public void setDefaultFailureUrl(String defaultFailureUrl) {
		this.defaultFailureUrl = defaultFailureUrl;
	}
	
	

}
