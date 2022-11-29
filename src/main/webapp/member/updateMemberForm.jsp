<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.net.URLEncoder" %>
<%
	// 1. C
	// session 유효성 검증 코드 후 필요하다면 redirect!
	if(session.getAttribute("loginMember") == null){
		// 로그인이 되지 않은 상태
		response.sendRedirect(request.getContextPath()+"/member/loginForm.jsp");
		return;
	}
	
	//알림 메시지
	String msg = null;
	
	request.setCharacterEncoding("UTF-8");

	//session에 저장된 멤버(현재 로그인 사용자)
	Object objLoginMember = session.getAttribute("loginMember");
	Member loginMember = (Member)objLoginMember;
	//System.out.println(loginMember);
	
	Member paramMember = new Member();
	paramMember.setMemberId(loginMember.getMemberId());
	
	Member member = new Member();
	
	// 2. M 호출
	// 쿼리
	MemberDao memberDao = new MemberDao();
	member = memberDao.selectMemberInfo(paramMember);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateMemberForm</title>
</head>
<body>
	<!-- msg 파라메타값이 있으면 출력 -->
	<%
		msg = request.getParameter("msg");
		if(msg != null) {
	%>
			<div><%=msg%></div>
	<%		
		}
	%>
	<form action="<%=request.getContextPath()%>/member/updateMemberAction.jsp" method="post">
		<h2>닉네임 수정</h2>
		<table border="1">
			<tr>
				<td>아이디</td>
				<td>
					<input type="text" name="memberId" value="<%=member.getMemberId()%>" readonly="readonly">
				</td>
			</tr>
			<tr>
				<td>기존 닉네임</td>
				<td>
					<input type="text" name="memberName" value="<%=member.getMemberName()%>" readonly="readonly">
				</td>
			</tr>
			<tr>
				<td>변경할 닉네임</td>
				<td>
					<input type="text" name="newMemberName" value="">
				</td>
			</tr>
			<tr>
				<td>비밀번호 확인</td>
				<td>
					<input type="password" name="memberPw" value="">
				</td>
			</tr>
		</table>
		<a href="<%=request.getContextPath()%>/member/memberOne.jsp">이전</a>
		<button type="submit">변경</button>
	</form>
	<!-- footer include -->
	<div>
		<jsp:include page="/inc/footer.jsp"></jsp:include>
	</div>
</body>
</html>