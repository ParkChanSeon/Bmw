package bmw.login.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import bmw.login.dao.MemberDAO;
import bmw.model.Member;

@Service
public class LoginService {
	
	@Autowired
	MemberDAO dao;
	
	// 아이디 중복 확인
	public Member checkId(String member_id) {
		
		return dao.getUserById(member_id);
	}
	
	public int join(Member member) {
		return dao.join(member);
	}
	
	

}
