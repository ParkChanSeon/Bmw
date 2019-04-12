package bmw.login.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationCredentialsNotFoundException;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UserDetailsService;

import bmw.model.Member;

public class CustomAuthenticationProvider implements AuthenticationProvider {

	 @Autowired
	    private UserDetailsService userDeSer;
	 
	    @SuppressWarnings("unchecked")
	    public Authentication authenticate(Authentication authentication) throws AuthenticationException {
	        
	        String username = (String) authentication.getPrincipal();
	        String password = (String) authentication.getCredentials();
	        
	        Member member = (Member) userDeSer.loadUserByUsername(username);
	        
	        if(!matchPassword(password, member.getPassword())) {
	            throw new BadCredentialsException(username);
	        }
	 
	        if(!member.isEnabled()||!member.isCredentialsNonExpired()) {
	            throw new AuthenticationCredentialsNotFoundException(username);
	        }
	        
	        return new UsernamePasswordAuthenticationToken(username, password, member.getAuthorities());
	    }
	 
	    public boolean supports(Class<?> authentication) {
	        return true;
	    }
	    
	    private boolean matchPassword(String loginPwd, String password) {
	        return loginPwd.equals(password);
	    }

		
	 


	
}
