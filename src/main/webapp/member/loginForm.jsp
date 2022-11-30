<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<%	
	// 1. C
	// 로그인이 되어 있을 때는 접근 불가
	if(session.getAttribute("loginMember") != null){
		// 로그인이 된 상태
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		return;
	}

	// 알림 메시지
	String msg = null;
	
	// 공지사항 목록 페이징
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	final int ROW_PER_PAGE = 5;
	int beginRow = (currentPage-1)*ROW_PER_PAGE;
	
	int count = 0;
	NoticeDao noticeDao = new NoticeDao();
	count = noticeDao.selectNoticeCount();
	
	int lastPage = (int)Math.ceil((double)count / (double)ROW_PER_PAGE); //마지막 페이지 번호 구하기
	
	// 공지사항 목록 출력
	ArrayList<Notice> list = noticeDao.selectNoticeListByPage(beginRow, ROW_PER_PAGE);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>loginForm</title>
	<!-- 부트스트랩5 CDN -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
	<style>
		.background{
			background-image: url(<%=request.getContextPath()%>/img/city.jpg);
		}
		
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
		input:hover {
			outline: none !important;
			border-color: #0054FF;
			box-shadow: 0 0 10px #6799FF;
		}
		#verticalMiddle{
		    position: absolute;
		    top: 60%;
		    left: 50%;
		    transform: translate(-50%, -50%);
		}
	</style>
</head>
<body class="background">
	<div>
		<div class="container text-center">
			<!-- 공지(5개)목록 페이징 -->
			<h3><strong>공지사항</strong></h3>
			<table class="table table-borderless table-light rounded-3 shadow p-4 bg-white">
				<tr>
					<th>공지내용</th>
					<th>날짜</th>
				</tr>
				<%
					for(Notice n : list){
				%>
						<tr>
							<td><%=n.getNoticeMemo()%></td>
							<td><%=n.getCreatedate()%></td>
						</tr>
				<%
					}
				%>
			</table>
			<!-- 공지사항 페이징 -->
			<ul class="pagination justify-content-center">
				<li class="page-item"><a class="page-link text-primary" href="<%=request.getContextPath()%>/member/loginForm.jsp?currentPage=1" style="text-decoration: none;">처음</a></li>
					<%
						if(currentPage > 1) {
					%>
							<li class="page-item"><a class="page-link text-primary" href="<%=request.getContextPath()%>/member/loginForm.jsp?currentPage=<%=currentPage-1%>" style="text-decoration: none;">이전</a></li>
					<%
						}
					%>
					<li class="page-item"><span class="page-link text-primary"><%=currentPage%></span></li>
					<%
						if(currentPage < lastPage){
					%>
							<li class="page-item"><a class="page-link text-primary" href="<%=request.getContextPath()%>/member/loginForm.jsp?currentPage=<%=currentPage+1%>" style="text-decoration: none;">다음</a></li>
					<%		
						}
					%>
				<li class="page-item"><a class="page-link text-primary" href="<%=request.getContextPath()%>/member/loginForm.jsp?currentPage=<%=lastPage%>" style="text-decoration: none;">마지막</a></li>
			</ul>
		</div>
	
		<div class="container w-50 text-center" id="verticalMiddle">
			<form action="<%=request.getContextPath()%>/member/loginAction.jsp" method="post">
				<table class="table table-borderless table-light rounded-3 shadow p-4 bg-white">
				<tr>
					<td colspan="2">
						<h4 style="float:left;">&nbsp;&nbsp;&nbsp;로그인</h4>
					</td>
				</tr>
				<!-- msg 파라메타값이 있으면 출력 -->
				<%
					msg = request.getParameter("msg");
					if(msg != null) {
				%>
						<div><%=msg%></div>
				<%		
					}
				%>
				<tr>
						<td>ID</td>
						<td><input type="text" name="memberId" class="form-control w-75 mx-auto"></td>
					</tr>
					<tr>
						<td>PW</td>
						<td><input type="password" name="memberPw" class="form-control w-75 mx-auto"></td>
					</tr>
				</table>
				<button style="float: right;" class="btn btn-primary m-1" type="submit">로그인</button>
				<div>
				<!-- id가 없는 경우 회원가입 부터 -->
				<a style="float: left;" type="button" class="btn btn-primary m-1" href="<%=request.getContextPath()%>/member/insertMemberForm.jsp">회원가입</a>
				</div>
			</form>
		</div>
	</div>
	<!-- footer include -->
	<div>
		<jsp:include page="/inc/footer.jsp"></jsp:include>
	</div>
</body>
</html>