<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login Form</title>
<!-- Scripts -->
			<script src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
			<script src="${pageContext.request.contextPath}/resources/js/jquery.scrollex.min.js"></script>
			<script src="${pageContext.request.contextPath}/resources/js/skel.min.js"></script>
			<script src="${pageContext.request.contextPath}/resources/js/util.js"></script>
			<script src="${pageContext.request.contextPath}/resources/js/main.js"></script>

<script type="text/javascript">



$(document).ready(function(){
	
	var regist_code = 0 ;

	var loginMember = ${not empty sessionScope.loginMember.member_id};

	
	if(loginMember){
		
	window.location.href="${pageContext.request.contextPath}/member";
	}
	
	
	$('.message a').click(function(){
		   $('.login-form').animate({height: "toggle", opacity: "toggle"}, "slow");
			$('.register-form').animate({height: "toggle", opacity: "toggle"}, "slow");
			$('#radio_check_m').attr("checked", true)
			
	});
	
	// 아이디 중복 검사
	$('#member_id').keyup(function(){
	
		
		
			var map = new Map;
			 map = {
					 "member_id" : $('#member_id').val()
			 }
			 
			 
			 $.ajax({
				 url : "${pageContext.request.contextPath}/checkId",
				 type : "POST",
				 cache : false,
				 dataType : 'json',
				 data : map,
				 beforeSend : function(xhr)
                 {   /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
                     xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                 },
				 success : function(data){
					 
					 
					 var value = data.msg;
	            	  var error_code = data.error_code;
	            	  
	            	   $("#id_msg").text(value);
	            	   
	            	   $("#member_id").css("margin-bottom","0");
	            	   
	            	   if(error_code == 0){
	            		   
	            		   $("#id_msg").css("color","blue");
	            		  
	            	   } else
	            		   $("#id_msg").css("color","red");
	            	   
	        }	
					 
                 
					 
				
			 })
			
		
		check();
			
		
		
	});
	
	$('#member_id').focusout(function(){
		if($('#member_id').val() == "")
			alert("id를 입력해 주세요.") 
		else if($('#member_id').val().length < 4){
		alert("4글자 이상의 아이디를 입력해 주세요.")
	}
		
	})
	
	
	
	// 확인 버튼을 눌렀을때
	$('#signup_btn').click(function(){
		
		if ($('#id_msg').text() == "사용중인 id 입니다." || $('#member_id').val() == "" || $('#id_msg').text() == "사용할 id를 입력하세요." ||$('#id_msg').text() == "4글자 이상의 아이디를 입력해 주세요."){
			alert("올바른 id를 입력해 주세요. ")
			return false;
		} else if ($('#member_pw1').val() != $('#member_pw2').val()){
			alert("비밀번호가 일치하지 않습니다.")
			return false;
		} else if ($('#member_pw1').val() == "" || $('#member_pw2').val() == ""){
			alert("비밀번호를 입력하세요.")
			return false;
		}else if($('#member_name').val() == ""){
			alert("이름을 입력해 주세요.");
			return false;
		} else if ($('#member_id').val() == ""){
			alert("id를 입력해 주세요.")
			return false;
		} else if ($('#birth_year').val() == "" || $('#birth_month').val() == "" || $('#birth_day').val() == "" ){
			alert("생년월일을 입력해 주세요.")
			return false;
		} else if ($('#member_phone').val() == ""){
			alert("전화번호를 입력해 주세요.")
			return false;
		} else {
			// else 시작
			
			
			
			 var map = new Map;
			
			var birth_year = $('#birth_year').val();
			
			var birth_month = $('#birth_month').val();
			
			var birth_day = $('#birth_day').val();
			
			
			
			
			var member_birth =  birth_year +"-"+ birth_month+ "-" + birth_day;
			
			 map = {
					 "member_id" : $('#member_id').val(),
					 "member_name" : $('#member_name').val(),
					 "member_pw" : $('#member_pw1').val(),
					 "member_gender" : $('input[name="member_gender"]:checked').val(),
					 "member_phone" : $('#member_phone').val(),
					 "member_birth" : member_birth
					 }
			
			$.ajax({
				 url : "${pageContext.request.contextPath}/join",
				 type : "POST",
				 cache : false,
				 dataType : 'json',
				 data : map,
				 beforeSend : function(xhr)
                {   //데이터를 전송하기 전에 헤더에 csrf값을 설정한다
                    xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                },
				 success : function(return_data){
					console.log(return_data)
	            	  var return_code = return_data.return_code;
	            	  console.log(return_code)
	            	   if(return_code == "1"){
	            		
	            		alert("회원가입 신청이 완료되었습니다. 관리자에게 문의하세요.");
	            		
	           			
	       				$('#id_msg').text("")
	       				$('#member_id').val("")
	       				$('#member_id').css("margin-bottom","16px")
	       				$('#member_name').val("")
	       				$('#member_phone').val("")
	       				$('#member_pw1').val("")
	       				$('#member_pw1').css("margin-bottom","16px")
	       				$('#pw_msg1').text("")
	       				$('#member_pw2').css("margin-bottom","16px")
	       				$('#pw_msg2').text("")
	       				$('#member_pw2').val("")
	       				$('#radio_check_m').attr("checked", true)
	       				$('#radio_check_f').attr("checked", false)
	       				
	       				
	       			
	       			
	       			$('.login-form').animate({height: "toggle", opacity: "toggle"}, "slow");
	       			$('.register-form').animate({height: "toggle", opacity: "toggle"}, "slow");
	       			
	            		  
	            	   } else {
	            		   
	            		   alert("회원가입 실패. 관리자에게 문의하세요.");
	            		   
	        			}	
					 
			}
					 
				
			 })
			
			
			alert("회원가입 신청이 완료되었습니다. 관리자에게 문의하세요.");
			
				$(location).attr("href", "${pageContext.request.contextPath}/logout");
				
			
		} //else 끝
			
	
		
		
	});
	
	// 비밀번호 텍스트필드 포커스 아웃 
	$('#member_pw1').focusout(function(){
		
		var member_pw1 = $('#member_pw1').val()
		
		if ( member_pw1 == ""){
			$('#member_pw1').css("margin-bottom","0");
			$('#member_pw2').attr("disabled", true)
			
			$('#pw_msg1').text("비밀번호를 입력하세요.")
			$('#pw_msg1').css("color","red")
			
			
			
		} else if(member_pw1.length < 8){
			$('#pw_msg1').text("8~20자 비밀번호를 입력하세요.")
			$('#pw_msg1').css("color","red")
			$('#member_pw2').attr("disabled", true)
		}
		
		
	})
	
	$('#member_pw1').keyup(function(){
		$('#member_pw1').css("margin-bottom","0");
		$('#member_pw2').attr("disabled", true)
		var size = $('#member_pw1').val().length;
		console.log(size)
	
		if(size < 8){
			$('#pw_msg1').text("8~20자 비밀번호를 입력하세요.")
			$('#pw_msg1').css("color","red")
			$('#member_pw2').attr("disabled", true)
		} else if(size > 7 && size < 21) {
			
			$('#pw_msg1').text("사용 가능한 비밀번호 입니다.")
			$('#pw_msg1').css("color","blue")
			$('#member_pw2').attr("disabled", false)
			
		} else {
			alert("8~20자 비밀번호를 입력하세요.")
			$('#pw_msg1').text("8~20자 비밀번호를 입력하세요.")
			$('#pw_msg1').css("color","red")
			$('#member_pw2').attr("disabled", true)
		}
		
	})
	
	$('#member_pw2').keyup(function(){
		$('#member_pw2').css("margin-bottom","0");
		
		if($('#member_pw1').val() != $('#member_pw2').val()){
			$('#pw_msg2').text("비밀번호가 일치하지 않습니다.")
			$('#pw_msg2').css("color","red")
			
		} else {
			$('#pw_msg2').text("")
			$('#member_pw2').css("margin-bottom","16px");	
		} 
		
	})
	
	
	$('#member_phone').keyup(function(){
	
		var phoneNumber = $('#member_phone').val();
		
		if (phoneNumber.indexOf("-") != -1){
			alert("-를 제외한 번호를 입력해주세요 \n ex : 01012345267")
		}
	
	})
	
	
	$('#member_phone').focusout(function(){
	
		var phoneNumber = $('#member_phone').val();
		
		if (phoneNumber.indexOf("-") != -1){
			alert("-를 제외한 번호를 입력해주세요 \n ex : 01012345267")
		}
	
	})
	
	$(document).on("keyup", "input:text[numberOnly]", function() {$(this).val( $(this).val().replace(/[^0-9]/gi,"") );});
	
	
	function check(){
		
		if($('#member_id').val() != "" && $('#pw_msg1').text() == "사용 가능한 비밀번호 입니다."
				&& $('#id_msg').text() == "사용 가능한 id 입니다." && $('#pw_msg1').text() == "" &&
				$('#member_phone').val() != "" && $('#member_name').val() != ""){
			$('#signup_btn').attr("disabled", true);
		} else {
			$('#signup_btn').attr("disabled", false);
		}
	
		
	}
	
	
	
	
	
	
});


function onlyNumber(event){
	event = event || window.event;
	var keyID = (event.which) ? event.which : event.keyCode;
	if ( (keyID >= 48 && keyID <= 57) || (keyID >= 96 && keyID <= 105) || keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 ) 
		return;
	else
		return false;
}
function removeChar(event) {
	event = event || window.event;
	var keyID = (event.which) ? event.which : event.keyCode;
	if ( keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 ) 
		return;
	else
		event.target.value = event.target.value.replace(/[^0-9]/g, "");
}


	
	
</script>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/login/login.css" />
</head>
<body style="background-image: url('${pageContext.request.contextPath}/resources/images/background01.jpg')">

<div class="login-page">
  <div class="form">
  		<p><span><b>Badminton Mixed doubles Wager</b></span></p>
  	<span class="logo"><img class="logo" src="${pageContext.request.contextPath}/resources/images/logo.png"></span>
   	<form class="register-form" id = "register-form" >
     
     
     
      <input type="text" placeholder="id"name = "member_id" id = "member_id" maxlength="20"/>
       	<b id = "id_msg"></b>
      <input type="password" placeholder="password" name = "member_pw1" id = "member_pw1" maxlength="20" />
     	<b id = "pw_msg1"></b>
      <input type="password" placeholder="confirm password" name = "member_pw2" id = "member_pw2"  maxlength="20" />
      	<b id = "pw_msg2"></b>
      <input type="text" placeholder="name" name = "member_name" id = "member_name" />
     
      <div class ="radio_div" style="margin-bottom:16px">
      <label style="float: left; margin-right: 10px; margin-top: 15px;">
      <b>birth : </b>
      </label>
     
         
      
      <input type="tel" placeholder="yyyy"  id = "birth_year" style="width: 70px;
    margin-right: 10px;" maxlength="4"  onkeydown='return onlyNumber(event)' onkeyup='removeChar(event)'  />
      <input type="tel" placeholder="mm"  id = "birth_month" style="width: 55px;
    margin-right: 10px;" maxlength="2"  onkeydown='return onlyNumber(event)' onkeyup='removeChar(event)' />
      <input type="tel" placeholder="dd"  id = "birth_day" style="width: 55px;"  onkeydown='return onlyNumber(event)' onkeyup='removeChar(event)'
      maxlength="2" /> 
      
      
      </div>
     
     
      <div class ="radio_div">
      <label style="float: left; margin-right: 20px;"><b>gender : </b></label>
      <input type = "radio" name = "member_gender" class = "member_gender" value = "남" style="width:30px;"checked="checked" id= "radio_check_m"><label style="margin-right: 20px;" >male</label>
      <input type = "radio" name = "member_gender" class = "member_gender" value = "여" style="width:30px;" id = "radio_check_f"><label >female</label>
      </div>
      <input type="tel" placeholder="phone number" name = "member_phone" id = "member_phone"  maxlength="11"  onkeydown='return onlyNumber(event)' onkeyup='removeChar(event)'/>
      
      
      
      <button id = "signup_btn" >sign up</button>
      <p class="message">Already registered? <a href="#">Sign In</a></p>
    </form>
      <form class="login-form" name="f" action="${pageContext.request.contextPath}/login" method="POST">
      <input type="text" placeholder="id" name="member_id" />
      <input type="password" placeholder="password" name="member_pw"/>
      <button>login</button>
      <p class="message">Not registered? <a href="#">Create an account</a></p>
      <input name="${_csrf.parameterName}" type="hidden" value="${_csrf.token}">
      
      <c:if test="${not empty ERRORMSG}">
        <font color="red">
        <p>Your login attempt was not successful due to <br/>
        ${ERRORMSG }</p>
        <c:if test="${not empty cnt}">
        <p>${cnt}</p>
        </c:if>
        </font>
    </c:if>



    </form>
    
  </div>
  
 
 
  
  
  
  
  
  
  
</div>

</body>
</html>