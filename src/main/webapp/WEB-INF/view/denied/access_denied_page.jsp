<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>접근 거부</title>
<!-- Scripts -->
			<script src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
			<script src="${pageContext.request.contextPath}/resources/js/jquery.scrollex.min.js"></script>
			<script src="${pageContext.request.contextPath}/resources/js/skel.min.js"></script>
			<script src="${pageContext.request.contextPath}/resources/js/util.js"></script>
			<script src="${pageContext.request.contextPath}/resources/js/main.js"></script>


<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/login/login.css" />
</head>
<body style="background-image: url('${pageContext.request.contextPath}/resources/images/background01.jpg')">

<div class="login-page">
  <div class="form">
  		<p><span><b>Badminton Mixed doubles Wager</b></span></p>
  	<span class="logo"><img class="logo" src="${pageContext.request.contextPath}/resources/images/logo.png"></span>

	<p>접근 권한이 없습니다.</p>
	<p>관리자에게 문의하세요</p>
	
	<sec:authorize access="isAuthenticated()">
					
					<form id="logout-form" action='${pageContext.request.contextPath}/logout' method="POST">
   					<input name="${_csrf.parameterName}" type="hidden" value="${_csrf.token}"/>
					<button onclick="document.getElementById('logout-form').submit();">메인으로</button>
					</form>
					</sec:authorize>
	
	    
  </div>
</div>

</body>
</html>