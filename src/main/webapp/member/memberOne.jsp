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
<title>memberOne</title>
</head>
<body>
	<h2 class="p-3 bg-success text-white rounded">내정보</h2>
	<!-- msg 파라메타값이 있으면 출력 -->
	<%
		msg = request.getParameter("msg");
		if(msg != null) {
	%>
			<div><%=msg%></div>
	<%		
		}
	%>
	<!-- 비밀번호를 제외한 모든 정보(컬럼) 출력 -->
	<table class="table">
		<tr>
			<td>회원아이디</td>
			<td><%=member.getMemberId()%></td>
		</tr>
		<tr>
			<td>회원이름</td>
			<td><%=member.getMemberName()%></td>
		</tr>
		<tr>
			<td>회원등급</td>
			<td>
				<%
					int memberLevel = (Integer)(member.getMemberLevel());
					if(memberLevel == 0){
				%>
						일반회원
				<%
					} else {
				%>
						관리자
				<%
					}
				%>
			</td>
		</tr>
	</table>
	<br><br>
	<div>
		<a style="float: left;" href="<%=request.getContextPath()%>/cash/cashList.jsp">홈으로</a>
	</div>
	<br><br>
	<div>
		<a style="float: left;" href="<%=request.getContextPath()%>/member/updateMemberPwForm.jsp?memberId=<%=member.getMemberId()%>">비밀번호수정</a>
	</div>
	<div>
		<a style="float: left;" href="<%=request.getContextPath()%>/member/updateMemberForm.jsp?memberId=<%=member.getMemberId()%>">개인정보수정</a>
	</div>
	<div>
		<a style="float: right;" href="<%=request.getContextPath()%>/member/deleteMemberForm.jsp?memberId=<%=member.getMemberId()%>">회원탈퇴</a>
	</div>
	<div>
		<a style="float: right;" href="<%=request.getContextPath()%>/member/logout.jsp">로그아웃</a>
	</div>
	<br>
	<!-- footer include -->
	<div>
		<jsp:include page="/inc/footer.jsp"></jsp:include>
	</div>
</body>
</html>