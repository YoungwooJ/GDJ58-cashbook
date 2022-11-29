<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="util.*"%>
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
	Member resultMember = null;
	
	// 2. M
	// 회원 정보 조회
	MemberDao memberDao = new MemberDao();
	resultMember = memberDao.selectMemberInfo(paramMember);
	
	// 3. 출력(View)
	// 디버깅 코드
	System.out.println("수정할 비밀번호 : " + resultMember.getMemberPw());
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateMemberPwForm</title>
</head>
<body>
	<form action="<%=request.getContextPath()%>/member/updateMemberPwAction.jsp" method="post">
		<h2>비밀번호 수정</h2>
		<!-- msg 파라메타값이 있으면 출력 -->
		<%
			msg = request.getParameter("msg");
			if(msg != null) {
		%>
				<div><%=msg%></div>
		<%		
			}
		%>
		<table>
			<tr>
				<td>아이디</td>
				<td>
					<input type="text" name="memberId" value="<%=resultMember.getMemberId()%>" readonly="readonly">
				</td>
			</tr>
			<tr>
				<td>닉네임</td>
				<td>
					<input type="text" name="memberName" value="<%=resultMember.getMemberName()%>" readonly="readonly">
				</td>
			</tr>
			<tr>
				<td>기존 비밀번호</td>
				<td>
					<input type="password" name="memberPw" value="">
				</td>
			</tr>
			<tr>
				<td>새로운 비밀번호</td>
				<td>
					<input type="password" name="newMemberPw" value="">
				</td>
			</tr>
		</table>
		<a href="<%=request.getContextPath()%>/member/memberOne.jsp">이전</a>
		<button style="float: right;" type="submit">비밀번호 변경</button>
	</form>
	<!-- footer include -->
	<div>
		<jsp:include page="/inc/footer.jsp"></jsp:include>
	</div>
</body>
</html>