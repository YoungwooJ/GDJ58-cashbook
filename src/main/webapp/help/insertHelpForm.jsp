<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	//1. Controller : session, request
	// session 유효성 검증 코드 후 필요하다면 redirect!
	if(session.getAttribute("loginMember") == null){
		// 로그인이 되지 않은 상태
		response.sendRedirect(request.getContextPath()+"/member/loginForm.jsp");
		return;
	}
	
	// session에 저장된 멤버(현재 로그인 사용자)
	Object objLoginMember = session.getAttribute("loginMember");
	Member loginMember = (Member)objLoginMember;
	//System.out.println(loginMember);
	
	//알림 메시지
	String msg = null;
	
	request.setCharacterEncoding("UTF-8");
	
	String memberId = loginMember.getMemberId();
	
	// 2. Model 호출
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>InsertHelpForm</title>
</head>
<body>
	<!-- help 입력 폼 -->
	<h5 style="float:left;">문의 입력</h5><br><br><br>
	<!-- msg 파라메타값이 있으면 출력 -->
	<%
		msg = request.getParameter("msg");
		if(request.getParameter("msg") != null) {
	%>
			<div><%=msg%></div>
	<%		
		}
	%>
	<form action="<%=request.getContextPath()%>/help/insertHelpAction.jsp" method="post">
		<table border="1">
			<tr>
				<td>문의 ID</td>
				<td>
					<input type="text" name="memberId" value="<%=memberId%>" readonly="readonly">
				</td>
			</tr>
			<tr>
				<td>문의 닉네임</td>
				<td>
					<input type="text" name="memberName" value="<%=loginMember.getMemberName()%>" readonly="readonly">
				</td>
			</tr>
			<tr>
				<td>문의</td>
				<td>
					<textarea rows="3" cols="50" name="helpMemo"></textarea>
				</td>
			</tr>
		</table>			
		<a href="<%=request.getContextPath()%>/help/helpList.jsp">이전</a>
		<button type="submit">입력</button>
	</form>
	<!-- footer include -->
	<div>
		<jsp:include page="/inc/footer.jsp"></jsp:include>
	</div>
</body>
</html>