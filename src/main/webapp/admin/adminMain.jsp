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
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<!-- 부트스트랩5 CDN -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
	<link rel="stylesheet" href="../css/bootstrap.css">
	<style>
		body {
			padding:1.5em;
			background: #f5f5f5;
		}
		
		table {
			border: 1px #BDBDBD solid;
			font-size: .9em;
			box-shadow: 0 2px 5px #BDBDBD;
			width: 100%;
			border-collapse: collapse;
			border-radius: 20px;
			overflow: hidden;
		}
		
		a {
			text-decoration: none;
		}
	</style>
</head>
<body>
	<!-- header include -->
	<div>
		<jsp:include page="/admin/inc/header.jsp"></jsp:include>
	</div>
    
	<div class="container">
		<!-- adminMain contents... -->
		<br>
		<!-- 최근 공지 5개 -->
		<h3 style="float:left;"><strong>최근 공지</strong></h3>
		<table class="table table-border">
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
		
		<br>
		<!-- 최근 멤버 5명 -->
		<h3 style="float:left;"><strong>최근 멤버</strong></h3>
		<table class="table table-border">
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
		
		<br>
		<!-- 최근 문의 5개 -->
		<h3 style="float:left;"><strong>최근 문의</strong></h3>
		<table class="table table-border">
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