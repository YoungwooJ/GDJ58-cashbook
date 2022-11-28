<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 1. C
	// session 유효성 검증 코드 후 필요하다면 redirect!
	if(session.getAttribute("loginMember") != null){
		// 로그인이 된 상태
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>InsertMemberForm</title>
</head>
<body>
	<div>
		<h2>회원 가입</h2>
		<!-- msg 파라메타값이 있으면 출력 -->
		<%
			String msg = request.getParameter("msg");
			if(msg != null) {
		%>
				<div><%=msg%></div>
		<%		
			}
		%>
		<form action="<%=request.getContextPath()%>/member/insertMemberAction.jsp" method="post">
			<table>
				<tr>
					<td>회원 아이디</td>
					<td><input type="text" name="memberId"></td>
				</tr>
				<tr>
					<td>회원 닉네임</td>
					<td><input type="text" name="memberName"></td>
				</tr>
				<tr>
					<td>회원 비밀번호</td>
					<td><input type="password" name="memberPw"></td>
				</tr>
			</table>
			<a href="<%=request.getContextPath()%>/member/loginForm.jsp">이전</a>
			<button type="submit">회원가입</button>
		</form>
	</div>
</body>
</html>