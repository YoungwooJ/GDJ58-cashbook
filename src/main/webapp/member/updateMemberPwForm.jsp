<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="util.*"%>
<%@ page import="java.net.URLEncoder" %>
<%
	// 1. C
	// session 유효성 검증 코드 후 필요하다면 redirect!
	if(session.getAttribute("loginMember") == null){
		// 로그인이 되지 않은 상태
		response.sendRedirect(request.getContextPath()+"/member/loginForm.jsp");
		return;
	}
	
	//알림 메시지
	String msg = null;
	
	request.setCharacterEncoding("UTF-8");

	//session에 저장된 멤버(현재 로그인 사용자)
	Object objLoginMember = session.getAttribute("loginMember");
	Member loginMember = (Member)objLoginMember;
	//System.out.println(loginMember);
	
	Member paramMember = new Member();
	paramMember.setMemberId(loginMember.getMemberId());
	Member resultMember = null;
	
	// 2. M
	// 회원 정보 조회
	MemberDao memberDao = new MemberDao();
	resultMember = memberDao.selectMemberInfo(paramMember);
	
	// 3. 출력(View)
	// 디버깅 코드
	System.out.println("수정할 비밀번호 : " + resultMember.getMemberPw());
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>updateMemberPwForm</title>
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
			msg = request.getParameter("msg");
			if(msg != null) {
		%>
				<div class="text-danger"><%=msg%></div>
		<%		
			}
		%>
		<h2 class="p-3 rounded">비밀번호 수정</h2>
		<form action="<%=request.getContextPath()%>/member/updateMemberPwAction.jsp" method="post">
			<table class="table table-bordered">
				<tr>
					<td>아이디</td>
					<td>
						<input type="text" name="memberId" value="<%=resultMember.getMemberId()%>" readonly="readonly">
					</td>
				</tr>
				<tr>
					<td>닉네임</td>
					<td>
						<input type="text" name="memberName" value="<%=resultMember.getMemberName()%>" readonly="readonly">
					</td>
				</tr>
				<tr>
					<td>기존 비밀번호</td>
					<td>
						<input type="password" name="memberPw" value="">
					</td>
				</tr>
				<tr>
					<td>새로운 비밀번호</td>
					<td>
						<input type="password" name="newMemberPw" value="">
					</td>
				</tr>
			</table>
			<a style="float: left;" type="button" class="btn btn-primary" href="<%=request.getContextPath()%>/member/memberOne.jsp">이전</a>
			<button style="float: right;" class="btn btn-info text-white" type="submit">비밀번호 변경</button>
		</form>
	</div>
	<!-- footer include -->
	<div>
		<jsp:include page="/inc/footer.jsp"></jsp:include>
	</div>
</body>
</html>