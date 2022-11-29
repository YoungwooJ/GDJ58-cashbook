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
	
	// 2. Model 호출
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>deleteMemberForm</title>
</head>
<body>
	<!-- header include -->
	<div>
		<jsp:include page="/admin/inc/header.jsp"></jsp:include>
	</div>
	<!-- msg 파라메타값이 있으면 출력 -->
	<%
		msg = request.getParameter("msg");
		if(request.getParameter("msg") != null) {
	%>
			<div><%=msg%></div>
	<%		
		}
	%>
	<div>
		<!-- 비밀번호 확인 -->
		<form action="<%=request.getContextPath()%>/admin/member/deleteMemberAction.jsp?memberNo=<%=memberNo%>" method="post">
		<input type="hidden" name="memberNo" value="<%=memberNo%>">
		<table>
			<tr>
				<th>회원번호</th>
				<td>
					<input type="text" name="memberNo" value="<%=memberNo%>">
				</td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td>
					<input type="password" name="adminPw" value="">
				</td>
			</tr>
		</table>
		<a href="<%=request.getContextPath()%>/admin/member/memberList.jsp">이전</a>
		<button type="submit">삭제</button>
		</form>
	</div>
	<!-- footer include -->
	<div>
		<jsp:include page="/inc/footer.jsp"></jsp:include>
	</div>
</body>
</html>