package bmw.login.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import bmw.login.dao.MemberDAO;

@Service("userSer")
public class UserServiceImpl implements UserService {
    
    @Resource(name="memberDAO")
    private MemberDAO memberDAO;
 
    public void countFailure(String username) {
    	memberDAO.updateFailureCount(username);
    }
 
    public int checkFailureCount(String username) {
        return memberDAO.checkFailureCount(username);
    }
 
    public void disabledUsername(String username) {
    	memberDAO.updateDisabled(username);
    }

	public void resetFailureCnt(String username) {
		memberDAO.updateFailureCountReset(username);
	}

	public void updateAccessDate(String username) {
		// TODO Auto-generated method stub
		
	}
 
}
