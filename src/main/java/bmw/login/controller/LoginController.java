package bmw.login.controller;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;



import bmw.login.service.LoginService;
import bmw.model.Member;

@Controller
public class LoginController {
	
	@Autowired
	Member member;
	@Autowired
	LoginService service;
	
	
	@RequestMapping(value="/", method=RequestMethod.GET)
	public void loginPage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
				
		RequestDispatcher dispatcher = request.getRequestDispatcher("/loginPageForm.jsp");
		dispatcher.forward(request, response);
		
	}
	
	
	@RequestMapping(value="/access_denied_page")
    public String accessDeniedPage() throws Exception {
      
		return "/denied/access_denied_page";
    }

	
	
	@RequestMapping(value="/checkId", method=RequestMethod.POST)
	@ResponseBody
	public Object checkId(@RequestParam Map<String,Object> map ,HttpServletRequest request) {
		Map<String,Object> data = new HashMap<String, Object>();
		
		String member_id = ((String) map.get("member_id")).trim();
		
		if(member_id != null) {
		
				if(member_id.length() < 4) {
			data.put("msg", "4글자 이상의 아이디를 입력해 주세요.");
			data.put("error_code", "1");
			return data;
				} else {
			
		member = service.checkId(member_id);
		
		
		if(member == null) {
			data.put("msg", "사용 가능한 id 입니다.");
			data.put("error_code", "0");
			return data;
		}
		else {
			data.put("msg", "사용중인 id 입니다.");
			data.put("error_code", "1");
			return data;
		} 
		
				}
		
		
		} else {
			data.put("msg", "사용할 id를 입력하세요.");
			data.put("error_code", "1");
			return data;
		}
		
	}
	
	
	@RequestMapping(value="/join", method=RequestMethod.POST)
	@ResponseBody
	public Object memberJoin(@RequestParam Map<String,Object> map ,HttpServletRequest request ) throws ParseException {
		
		Map<String,Object> return_data = new HashMap<String, Object>();
		
		System.out.println(map);
		
		String member_id = (String)map.get("member_id");
		String member_pw = (String)map.get("member_pw");
		String member_name = (String)map.get("member_name");
		String member_gender = (String)map.get("member_gender");
		String member_phone = (String)map.get("member_phone");
	
		member = new Member();
		member.setMember_id(member_id);
		member.setMember_pw(member_pw);
		member.setMember_name(member_name);
		member.setMember_gender(member_gender);
		
		member.setMember_phone(member_phone);
		String member_image = "/resources/images/profile/default_image.jpg";
		member.setMember_image(member_image);
		
		String birth = (String)map.get("member_birth");
		
		
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		
		
		
		Date member_birth = df.parse(birth);
		
		// DB에 생년월일이 하루 늦게 들어가서 날짜를 1일 + 함
		 Calendar cal = Calendar.getInstance();
		
		 cal.setTime(member_birth);
		
		 cal.add(Calendar.DATE, 1);
		 
		 member_birth = new Date(cal.getTimeInMillis());
		
		
		member.setMember_birth(member_birth);
		
		System.out.println(member.getMember_id());
		System.out.println(member.getMember_pw());
		System.out.println(member.getMember_name());
		System.out.println(member.getMember_birth());
		System.out.println(member.getMember_gender());
		System.out.println(member.getMember_phone());
		
		int return_code = service.join(member);
		
		System.out.println(return_code);
		
		if(return_code == 1) {
			return_data.put("return_code", return_code);
		} else {
			return_code = 0;
			return_data.put("return_code", return_code);
		}
		
		
		
		return return_data;
	}

			
	@RequestMapping(value = "/access_denied", method=RequestMethod.GET)
	public String access_denied () {
		
		
		return "/denied/access_denied_page";
	}
		
	
	

}
