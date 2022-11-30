<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import = "vo.*"%>
<%@ page import="java.net.URLEncoder" %>
<%
	// 1. C
	// session 유효성 검증 코드 후 필요하다면 redirect!
	if(session.getAttribute("loginMember") == null){
		// 로그인이 되지 않은 상태
		response.sendRedirect(request.getContextPath()+"/member/loginForm.jsp");
		return;
	}
	// 알림 메시지
	String msg = null;
	
	request.setCharacterEncoding("UTF-8");
	
	// 방어코드
	if(request.getParameter("year")== null 
			|| request.getParameter("month")== null
			|| request.getParameter("date")== null
			|| request.getParameter("year").equals("") 
			|| request.getParameter("month").equals("")
			|| request.getParameter("date").equals("")){
		msg = URLEncoder.encode("정보를 입력하세요.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp?msg="+msg);
		return;
	}
	
	int year = 0;
	int month = 0;
	int date = 0;
	
	year = Integer.parseInt(request.getParameter("year"));
	month = Integer.parseInt(request.getParameter("month"));
	date = Integer.parseInt(request.getParameter("date"));
	System.out.println(year);
	System.out.println(month);
	System.out.println(date);

	//방어코드
	if(request.getParameter("cashNo")==null 
			|| request.getParameter("categoryKind")==null
			|| request.getParameter("categoryName")==null
			|| request.getParameter("cashNo").equals("") 
			|| request.getParameter("categoryKind").equals("") 
			|| request.getParameter("categoryName").equals("")){
		msg = URLEncoder.encode("정보를 입력하세요.", "utf-8"); // get 방식 주소창에 문자열 인코딩 
		response.sendRedirect(request.getContextPath()+"/cash/cashDateList.jsp");
		return;
	}
	
	String cashNo = request.getParameter("cashNo");
	String categoryKind = request.getParameter("categoryKind");
	String categoryName = request.getParameter("categoryName");
	System.out.println(cashNo);
	System.out.println(categoryKind);
	System.out.println(categoryName);
	
	// 2. M
	
	// 3. V
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>deleteCashForm</title>
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
		<jsp:include page="/inc/header.jsp"></jsp:include>
	</div>
    
    <br><br>
    
    <div class="container">
    	<h3 style="float:left;"><strong>내역 삭제</strong></h3>
		<!-- msg 파라메타값이 있으면 출력 -->
		<%
			msg = request.getParameter("msg");
			if(msg != null) {
		%>
				<div><%=msg%></div>
		<%		
			}
		%>
		<form action="<%=request.getContextPath()%>/cash/deleteCashAction.jsp" method="post">
		<input type="hidden" name="cashNo" value="<%=cashNo%>">
		<input type="hidden" name="categoryKind" value="<%=categoryKind%>">
		<input type="hidden" name="categoryName" value="<%=categoryName%>">
		<input type="hidden" name="year" value="<%=year%>">
		<input type="hidden" name="month" value="<%=month%>">
		<input type="hidden" name="date" value="<%=date%>">
		<table class="table table-border">
			<tr>
				<td>종류</td>
				<td><%=categoryKind%></td>
			</tr>
			<tr>
				<td>이름</td>
				<td><%=categoryName%></td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><input type="password" name="memberPw"></td>
			</tr>
		</table>
		<a href="<%=request.getContextPath()%>/cash/cashDateList.jsp?year=<%=year%>&month=<%=month%>&date=<%=date%>">이전</a>
		<button type="submit">삭제</button>
		</form>
	</div>
	<!-- footer include -->
	<div>
		<jsp:include page="/inc/footer.jsp"></jsp:include>
	</div>
</body>
</html>