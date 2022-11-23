<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="vo.*"%>
<%@ page import="util.*"%>
<%@ page import="java.net.URLEncoder" %>
<%
	// 1. C
	// session 유효성 검증 코드 후 필요하다면 redirect!
	if(session.getAttribute("loginMember") == null){
		// 로그인이 되지 않은 상태
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	//알림 메시지
	String msg = null;
	
	request.setCharacterEncoding("UTF-8");

	//session에 저장된 멤버(현재 로그인 사용자)
	Object objLoginMember = session.getAttribute("loginMember");
	Member loginMember = (Member)objLoginMember;
	//System.out.println(loginMember);
	
	// 2. M
	
	// db연결
	DBUtil dbUtil = new DBUtil();
	Connection conn = dbUtil.getConnection();
	
	// 쿼리
	String sql = null;
	PreparedStatement stmt = null;
	sql = "SELECT member_id memberId, member_pw memberPw, member_name memberName FROM member WHERE member_id = ?";
	stmt = conn.prepareStatement(sql);
	stmt.setString(1, loginMember.getMemberId());
	ResultSet rs = stmt.executeQuery();
	Member member = null;
	if(rs.next()){
		member = new Member();
		member.setMemberId(rs.getString("memberId"));
		member.setMemberPw(rs.getString("memberPw"));
		member.setMemberName(rs.getString("memberName"));
	}
	
	// 3. 출력(View)
	// 디버깅 코드
	System.out.println("수정할 비밀번호 : " + member.getMemberPw());
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateMemberPwForm</title>
</head>
<body>
	<form action="<%=request.getContextPath()%>/updateMemberPwAction.jsp">
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
					<input type="text" name="memberId" value="<%=member.getMemberId()%>" readonly="readonly">
				</td>
			</tr>
			<tr>
				<td>닉네임</td>
				<td>
					<input type="text" name="memberName" value="<%=member.getMemberName()%>" readonly="readonly">
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
		<button style="float: right;" type="submit">비밀번호 변경</button>
	</form>
</body>
</html>