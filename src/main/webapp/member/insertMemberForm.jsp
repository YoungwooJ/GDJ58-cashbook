<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 1. C
	// session 유효성 검증 코드 후 필요하다면 redirect!
	if(session.getAttribute("loginMember") != null){
		// 로그인이 된 상태
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>InsertMemberForm</title>
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
		
		/*
		table {
			border: 1px #BDBDBD solid;
			font-size: .9em;
			box-shadow: 0 2px 5px #BDBDBD;
			width: 100%;
			border-collapse: collapse;
			border-radius: 20px;
			overflow: hidden;
		}
		*/
				
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
	<div class="container text-center">
		<!-- msg 파라메타값이 있으면 출력 -->
		<%
			String msg = request.getParameter("msg");
			if(msg != null) {
		%>
				<div class="text-danger"><%=msg%></div>
		<%		
			}
		%>
		<h2 class="p-3 rounded">회원가입</h2>
		<form action="<%=request.getContextPath()%>/member/insertMemberAction.jsp" method="post">
			<table class="table table-bordered">
				<tr>
					<td>회원 아이디</td>
					<td><input type="text" name="memberId"></td>
				</tr>
				<tr>
					<td>회원 닉네임</td>
					<td><input type="text" name="memberName"></td>
				</tr>
				<tr>
					<td>회원 비밀번호</td>
					<td><input type="password" name="memberPw"></td>
				</tr>
			</table>
			<a style="float: left;" type="button" class="btn btn-primary" href="<%=request.getContextPath()%>/member/loginForm.jsp">이전</a>
			<button style="float: right;" class="btn btn-primary" type="submit">회원가입</button>
		</form>
		<!-- footer include -->
		<div>
			<jsp:include page="/inc/footer.jsp"></jsp:include>
		</div>
	</div>
</body>
</html>