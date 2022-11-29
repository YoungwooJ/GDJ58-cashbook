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
	
	// 2. Model : noticeList
	// 공지사항 목록 페이징
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	final int ROW_PER_PAGE = 10;
	int beginRow = (currentPage-1)*ROW_PER_PAGE;
	
	int count = 0;
	NoticeDao noticeDao = new NoticeDao();
	count = noticeDao.selectNoticeCount(); // -> lastPage
	
	int lastPage = (int)Math.ceil((double)count / (double)ROW_PER_PAGE); //마지막 페이지 번호 구하기
	
	// 공지사항 목록 출력
	ArrayList<Notice> list = noticeDao.selectNoticeListByPage(beginRow, ROW_PER_PAGE);
	
	// 3. View
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>noticeList</title>
</head>
<body>
	<!-- header include -->
	<div>
		<jsp:include page="/admin/inc/header.jsp"></jsp:include>
	</div>
	<div>
		<!-- notice contents... -->
		<h1>공지</h1>
		<table border="1">
			<tr>
				<th>공지내용</th>
				<th>공지날짜</th>
				<th>수정</th>
				<th>삭제</th>
			</tr>
			<%
				for(Notice n : list){
			%>
				<tr>
					<td><%=n.getNoticeMemo()%></td>
					<td><%=n.getCreatedate()%></td>
					<td><a href="<%=request.getContextPath()%>/admin/notice/updateNoticeForm.jsp?noticeNo=<%=n.getNoticeNo()%>&currentPage=<%=currentPage%>">수정</a></td>
					<td><a href="<%=request.getContextPath()%>/admin/notice/deleteNoticeAction.jsp?noticeNo=<%=n.getNoticeNo()%>&currentPage=<%=currentPage%>">삭제</a></td>
				</tr>
			<%		
				}
			%>
		</table>
		
		<!-- 공지사항 페이징 -->
		<a href="<%=request.getContextPath()%>/admin/notice/noticeList.jsp?currentPage=1" style="text-decoration: none;">처음</a>
			<%
				if(currentPage > 1) {
			%>
					<a href="<%=request.getContextPath()%>/admin/notice/noticeList.jsp?currentPage=<%=currentPage-1%>" style="text-decoration: none;">이전</a>
			<%
				}
			%>
			<span><%=currentPage%></span>
			<%
				if(currentPage < lastPage){
			%>
					<a href="<%=request.getContextPath()%>/admin/notice/noticeList.jsp?currentPage=<%=currentPage+1%>" style="text-decoration: none;">다음</a>
			<%		
				}
			%>
		<a href="<%=request.getContextPath()%>/admin/notice/noticeList.jsp?currentPage=<%=lastPage%>" style="text-decoration: none;">마지막</a>
		
		<!-- notice 입력 폼 -->
		<h5 style="float:left;">공지 입력</h5><br><br><br>
		<!-- msg 파라메타값이 있으면 출력 -->
		<%
			String msg = request.getParameter("msg");
			if(request.getParameter("msg") != null) {
		%>
				<div><%=msg%></div>
		<%		
			}
		%>
		<form action="<%=request.getContextPath()%>/admin/notice/insertNoticeAction.jsp" method="post">
			<table border="1">
				<tr>
					<td>내용</td>
					<td>
						<textarea rows="3" cols="50" name="noticeMemo"></textarea>
					</td>
				</tr>
			</table>			
			<a href="<%=request.getContextPath()%>/admin/adminMain.jsp">이전</a>
			<button type="submit">입력</button>
		</form>
		<!-- footer include -->
		<div>
			<jsp:include page="/inc/footer.jsp"></jsp:include>
		</div>
	</div>
</body>
</html>