package bmw.model;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;


import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

@SuppressWarnings("serial")
public class Member implements UserDetails {

	private String member_id;
    private String member_pw;
    private String AUTHORITY;
    private boolean ENABLED;
    private String member_name;
    private Date member_birth;
    private String member_gender;
    private String member_phone;
    private String member_image;
    private Date member_regDate;
    private int failure_cnt; 
    

    
    
    public int getFailure_cnt() {
		return failure_cnt;
	}

	public void setFailure_cnt(int failure_cnt) {
		this.failure_cnt = failure_cnt;
	}

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public String getMember_pw() {
		return member_pw;
	}

	public void setMember_pw(String member_pw) {
		this.member_pw = member_pw;
	}

	public Date getMember_birth() {
		return member_birth;
	}

	public void setMember_birth(Date member_birth) {
		this.member_birth = member_birth;
	}

	public String getMember_gender() {
		return member_gender;
	}

	public void setMember_gender(String member_gender) {
		this.member_gender = member_gender;
	}

	public String getMember_phone() {
		return member_phone;
	}

	public void setMember_phone(String member_phone) {
		this.member_phone = member_phone;
	}

	public String getMember_image() {
		return member_image;
	}

	public void setMember_image(String member_image) {
		this.member_image = member_image;
	}

	public Date getMember_regDate() {
		return member_regDate;
	}

	public void setMember_regDate(Date member_regDate) {
		this.member_regDate = member_regDate;
	}

	public Collection<? extends GrantedAuthority> getAuthorities() {
        ArrayList<GrantedAuthority> auth = new ArrayList<GrantedAuthority>();
        auth.add(new SimpleGrantedAuthority(AUTHORITY));
        return auth;
    }
 
  public String getPassword() {
	  return member_pw;
  }
 
    public String getUsername() {
        return member_id;
    }
 
    public boolean isAccountNonExpired() {
        return true;
    }
 
    
    public boolean isAccountNonLocked() {
        return true;
    }
 
    
    public boolean isCredentialsNonExpired() {
        return true;
    }
 
   
    public boolean isEnabled() {
        return ENABLED;
    }
    
    public String getMember_name() {
        return member_name;
    }
 
    public void setMember_name(String name) {
        this.member_name = name;
    }
 


	
	
}