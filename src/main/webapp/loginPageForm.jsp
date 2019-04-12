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

	var loginMember = ${not empty sessionScope.loginMember.member_id};

	
	if(loginMember){
		
	window.location.href="${pageContext.request.contextPath}/member";
	}
	
	
	$('.message a').click(function(){
		   $('.form').animate({height: "toggle", opacity: "toggle"}, "slow");
		});
	
	
	 

});


	
	
</script>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/login/login.css" />
</head>
<body style="background-image: url('${pageContext.request.contextPath}/resources/images/lindan.jpg')">

<div class="login-page">
  <div class="form">
  		<p><span><b>Badminton Mixed doubles Wager</b></span></p>
  	<span class="logo"><img class="logo" src="${pageContext.request.contextPath}/resources/images/logo.png"></span>
  
     <form class="register-form">
      <input type="text" placeholder="name" />
      <input type="password" placeholder="password"/>
      <input type="text" placeholder="email address"/>
      <button>create</button>
      <p class="message">Already registered? <a href="#">Sign In</a></p>
    </form>
    
    <form class="login-form" name="f" action="${pageContext.request.contextPath}/login" method="POST">
      <input type="text" placeholder="e-mail" name="member_id" />
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