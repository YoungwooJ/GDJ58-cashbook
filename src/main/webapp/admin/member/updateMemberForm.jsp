<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.URLEncoder" %>
<%
	// 1. Controller
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/member/loginForm.jsp");
		return;
	}

	request.setCharacterEncoding("UTF-8");
	String msg = null;
	int memberNo = 0;
	
	// 방어코드
	if(request.getParameter("memberNo")== null || request.getParameter("memberNo").equals("")){
		msg = URLEncoder.encode("오류입니다.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/admin/member/memberList?msg="+msg);
		return;
	} else {
		memberNo = Integer.parseInt(request.getParameter("memberNo"));
	}
	
	Member paramMember = new Member();
	paramMember.setMemberNo(memberNo);
	
	// 디버깅 코드
	System.out.println(memberNo);
	
	// 2. Model 호출
	MemberDao memberDao = new MemberDao();
	Member member = new Member();
	member = memberDao.selectMember(paramMember);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateMemberForm</title>
</head>
<body>
	<div>
		<!-- 비밀번호 확인 -->
		<form action="<%=request.getContextPath()%>/admin/member/updateMemberAction.jsp?memberNo=<%=memberNo%>" method="post">
		<input type="hidden" name="memberNo" value="<%=memberNo%>">
		<table>
			<tr>
				<th>회원 번호</th>
				<td>
					<input type="number" name="memberNo" value="<%=member.getMemberNo()%>" readonly="readonly">
				</td>
			</tr>
			<tr>	
				<th>회원 ID</th>
				<td>
					<input type="text" name="memberId" value="<%=member.getMemberId()%>" readonly="readonly">
				</td>
			</tr>
			<tr>
				<th>회원 닉네임</th>
				<td>
					<input type="text" name="memberName" value="<%=member.getMemberName()%>" readonly="readonly">
				</td>
			</tr>
			<tr>	
				<th>생성일자</th>
				<td>
					<input type="text" name="createdate" value="<%=member.getCreatedate()%>" readonly="readonly">
				</td>
			</tr>
			<tr>
				<th>수정일자</th>
				<td>
					<input type="text" name="updatedate" value="<%=member.getUpdatedate()%>" readonly="readonly">
				</td>
			</tr>
			<tr>	
				<th>회원 레벨</th>
				<select name="memberLevel">
					<option value="<%=(Integer)(member.getMemberLevel())%>">
					<%
						if(member.getMemberLevel() == 1){
					%>
							관리자
					<%
						} else {
					%>
							일반회원
					<%
						}
					%>
					</option>
					<option>
					<%
						
					%>
					</option>
				</select>
			</tr>
		</table>
		<button type="submit">수정</button>
		</form>
	</div>
</body>
</html>