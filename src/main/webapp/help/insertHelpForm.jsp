<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	//1. Controller : session, request
	// session 유효성 검증 코드 후 필요하다면 redirect!
	if(session.getAttribute("loginMember") == null){
		// 로그인이 되지 않은 상태
		response.sendRedirect(request.getContextPath()+"/member/loginForm.jsp");
		return;
	}
	
	// session에 저장된 멤버(현재 로그인 사용자)
	Object objLoginMember = session.getAttribute("loginMember");
	Member loginMember = (Member)objLoginMember;
	//System.out.println(loginMember);
	
	//알림 메시지
	String msg = null;
	
	request.setCharacterEncoding("UTF-8");
	
	String memberId = loginMember.getMemberId();
	
	// 2. Model 호출
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>InsertHelpForm</title>
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
    
	<!-- help 입력 폼 -->
	<div class="container">
    	<h3 style="float:left;"><strong>문의 입력</strong></h3>
    	<br><br><br>
		<!-- msg 파라메타값이 있으면 출력 -->
		<%
			msg = request.getParameter("msg");
			if(request.getParameter("msg") != null) {
		%>
				<div><%=msg%></div>
		<%		
			}
		%>
		<form action="<%=request.getContextPath()%>/help/insertHelpAction.jsp" method="post">
			<table border="1">
				<tr>
					<td>문의 ID</td>
					<td>
						<input type="text" name="memberId" value="<%=memberId%>" readonly="readonly">
					</td>
				</tr>
				<tr>
					<td>문의 닉네임</td>
					<td>
						<input type="text" name="memberName" value="<%=loginMember.getMemberName()%>" readonly="readonly">
					</td>
				</tr>
				<tr>
					<td>문의</td>
					<td>
						<textarea rows="3" cols="50" name="helpMemo"></textarea>
					</td>
				</tr>
			</table>			
			<a href="<%=request.getContextPath()%>/help/helpList.jsp">이전</a>
			<button type="submit">입력</button>
		</form>
	</div>	
	<!-- footer include -->
	<div>
		<jsp:include page="/inc/footer.jsp"></jsp:include>
	</div>
</body>
</html>