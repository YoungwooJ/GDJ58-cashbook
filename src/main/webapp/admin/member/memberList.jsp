<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%
	// 1. Controller
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/member/loginForm.jsp");
		return;
	}
	
	request.setCharacterEncoding("UTF-8");
	String msg = null;
	
	Member member = new Member();
	
	// 2. Model 호출
	// 멤버 페이징
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	final int ROW_PER_PAGE = 10;
	int beginRow = (currentPage-1)*ROW_PER_PAGE;
	
	int count = 0;
	MemberDao memberDao = new MemberDao();
	count = memberDao.selectMemberCount(); // -> lastPage
	
	int lastPage = (int)Math.ceil((double)count / (double)ROW_PER_PAGE); //마지막 페이지 번호 구하기
	
	// 멤버 목록 출력
	ArrayList<Member> list = memberDao.selectMemberListByPage(beginRow, ROW_PER_PAGE);
	
	// 3. View
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>memberList</title>
</head>
<body>
	<ul>
		<li><a href="<%=request.getContextPath()%>/admin/notice/noticeList.jsp">공지관리</a></li>
		<li><a href="<%=request.getContextPath()%>/admin/category/categoryList.jsp">카테고리관리</a></li>
		<li><a href="<%=request.getContextPath()%>/admin/member/memberList.jsp">멤버관리(목록, 레벨수정, 강제탈퇴)</a></li>
	</ul>
	<div>
		<!-- memberList contents... -->
		<h1>멤버 목록</h1>
		<!-- msg 파라메타값이 있으면 출력 -->
		<%
			msg = request.getParameter("msg");
			if(request.getParameter("msg") != null) {
		%>
				<div><%=msg%></div>
		<%		
			}
		%>
		<table>
			<tr>
				<th>멤버번호</th>
				<th>멤버아이디</th>
				<th>레벨</th>
				<th>이름</th>
				<th>마지막 수정일</th>
				<th>생성일자</th>
				<th>레벨수정</th>
				<th>강제탈퇴</th>
			</tr>
			<%
				for(Member m : list){
				%>
					<tr>
						<td><%=m.getMemberNo()%></td>
						<td><%=m.getMemberId()%></td>
						<td><%=m.getMemberLevel()%></td>
						<td><%=m.getMemberName()%></td>
						<td><%=m.getUpdatedate()%></td>
						<td><%=m.getCreatedate()%></td>
						<td><a href="<%=request.getContextPath()%>/admin/member/updateMemberForm.jsp?memberNo=<%=m.getMemberNo()%>">수정</a></td>
						<td><a href="<%=request.getContextPath()%>/admin/member/deleteMemberForm.jsp?memberNo=<%=m.getMemberNo()%>">삭제</a></td>
					</tr>
				<%				
				}
			%>
		</table>
		
		<!-- 멤버 페이징 -->
		<a href="<%=request.getContextPath()%>/admin/member/memberList.jsp?currentPage=1" style="text-decoration: none;">처음</a>
			<%
				if(currentPage > 1) {
			%>
					<a href="<%=request.getContextPath()%>/admin/member/memberList.jsp?currentPage=<%=currentPage-1%>" style="text-decoration: none;">이전</a>
			<%
				}
			%>
			<span><%=currentPage%></span>
			<%
				if(currentPage < lastPage){
			%>
					<a href="<%=request.getContextPath()%>/admin/member/memberList.jsp?currentPage=<%=currentPage+1%>" style="text-decoration: none;">다음</a>
			<%		
				}
			%>
		<a href="<%=request.getContextPath()%>/admin/member/memberList.jsp?currentPage=<%=lastPage%>" style="text-decoration: none;">마지막</a>
	</div>
</body>
</html>