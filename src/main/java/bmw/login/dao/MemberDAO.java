package bmw.login.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import bmw.model.Member;

@Repository("memberDAO")
public class MemberDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	private String strNameSpace = "bmw.LoginMapper";
	
	public void setSqlSession(SqlSessionTemplate sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public Member getUserById(String username) {
			
		return sqlSession.selectOne(strNameSpace + ".selectUserById", username);
	}
	
	public void updateDisabled(String username) {
		sqlSession.update(strNameSpace + ".updateUnenabled", username);
	}

	
	public void updateFailureCountReset(String username) {
		sqlSession.update(strNameSpace + ".updateFailureCountReset", username);
	}
	
	
	public void updateFailureCount(String username) {
	        sqlSession.update(strNameSpace + ".updateFailureCount", username);
	    }
	    
	
	public int checkFailureCount(String username) {
	        return sqlSession.selectOne(strNameSpace + ".checkFailureCount", username);
	    }

	
	public void updateNewAccessDate(String username) {
		sqlSession.update(strNameSpace + ".updateAccessDate", username);
	}

	
	
	
	
	
	
}
