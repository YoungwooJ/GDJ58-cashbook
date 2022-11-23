<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%	
	// 1. C
	// 로그인이 되어 있을 때는 접근 불가
	if(session.getAttribute("loginMember") != null){
		// 로그인이 된 상태
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		return;
	}

	//알림 메시지
	String msg = null;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>loginForm</title>
</head>
<body>
	<h1>로그인</h1>
	<!-- msg 파라메타값이 있으면 출력 -->
	<%
		msg = request.getParameter("msg");
		if(msg != null) {
	%>
			<div><%=msg%></div>
	<%		
		}
	%>
	<form action="<%=request.getContextPath()%>/loginAction.jsp" method="post">
		<div>
			ID:
			<input type="text" name="memberId">
		</div>
		<div>
			PW:
			<input type="password" name="memberPw">
		</div>
		<div>
			<button type="submit">로그인</button>
		</div>
		<!-- id가 없는 경우 회원가입 부터 -->
		<a href="<%=request.getContextPath()%>/insertMemberForm.jsp">회원가입</a>
	</form>
</body>
</html>