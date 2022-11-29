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
	
	// 2. Model 호출
	// 페이징
	int currentPage = 1;
	final int ROW_PER_PAGE = 5;
	int beginRow = (currentPage-1)*ROW_PER_PAGE;
	
	// 최근 공지 5개, 최근 멤버 5명, 최근 문의 5개 출력
	NoticeDao noticeDao = new NoticeDao();
	MemberDao memberDao = new MemberDao();
	HelpDao helpDao = new HelpDao();
	
	ArrayList<Notice> noticeList = noticeDao.selectNoticeListByPage(beginRow, ROW_PER_PAGE);
	ArrayList<Member> memberList = memberDao.selectMemberListByPage(beginRow, ROW_PER_PAGE);
	ArrayList<HashMap<String, Object>> helpList = helpDao.selectHelpList(beginRow, ROW_PER_PAGE);
	
	// 3. View
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>adminMain</title>
</head>
<body>
	<!-- header include -->
	<div>
		<jsp:include page="/admin/inc/header.jsp"></jsp:include>
	</div>
	<div>
		<!-- adminMain contents... -->
		<!-- 최근 공지 5개 -->
		<h3>최근 공지</h3>
		<table>
			<tr>
				<th>내용</th>
				<th>날짜</th>
			</tr>
			<%
				for(Notice n : noticeList){
			%>
					<tr>
						<td><%=n.getNoticeMemo()%></td>
						<td><%=n.getCreatedate()%></td>
					</tr>
			<%
				}
			%>
		</table>
		
		<!-- 최근 멤버 5명 -->
		<h3>최근 멤버</h3>
		<table>
			<tr>
				<th>아이디</th>
				<th>이름</th>
				<th>마지막수정날짜</th>
				<th>가입날짜</th>
			</tr>
			<%
				for(Member m : memberList){
			%>
					<tr>
						<td><%=m.getMemberId()%></td>
						<td><%=m.getMemberName()%></td>
						<td><%=m.getUpdatedate()%></td>
						<td><%=m.getCreatedate()%></td>
					</tr>
			<%
				}
			%>
		</table>
		
		<!-- 최근 문의 5개 -->
		<h3>최근 문의</h3>
		<table>
			<tr>
				<th>문의내용</th>
				<th>아이디</th>
				<th>문의날짜</th>
				<th>답변내용</th>
				<th>답변날짜</th>
			</tr>
			<%
				for(HashMap<String, Object> m : helpList){
					String commentMemo = (String)m.get("commentMemo");
			%>
					<tr>
						<td><%=m.get("helpMemo")%></td>
						<td><%=m.get("helpMemberId")%></td>
						<td><%=m.get("helpCreatedate")%></td>
						<%
							if(commentMemo != null){
						%>
								<td><%=commentMemo%></td>
								<td><%=(String)m.get("commentCreatedate")%></td>
						<%
							} else {
						%>
								<td colspan="2">답변 대기</td>
						<%
							}
						%>
						
					</tr>
			<%
				}
			%>	
		</table>
	</div>
	<!-- footer include -->
	<div>
		<jsp:include page="/inc/footer.jsp"></jsp:include>
	</div>
</body>
</html>