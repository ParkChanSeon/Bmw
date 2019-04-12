package bmw.login.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;


import bmw.login.dao.MemberDAO;
import bmw.model.Member;


public class CustomUserDetailsService implements UserDetailsService{

	@Autowired
	private MemberDAO memberDAO;
	
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		System.out.println("loadUserByUsername : "+username);
		
		Member member = memberDAO.getUserById(username);
		
		
		if (member == null) {
			throw new InternalAuthenticationServiceException(username);
		}
		
		return member;
	}

}
