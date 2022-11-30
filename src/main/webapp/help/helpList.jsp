<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%
	// 1. Controller : session, request
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
	
	String memberId = loginMember.getMemberId();
	
	// 2. Model 호출
	HelpDao helpDao = new HelpDao();
	ArrayList<HashMap<String, Object>> list = helpDao.selectHelpList(memberId);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>HelpList</title>
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
		<h3 style="float:left;"><strong>고객센터</strong></h3>
		<table class="table table-border">
			<tr>
				<th>문의번호</th>
				<th>문의</th>
				<th>문의ID</th>
				<th>문의수정날짜</th>
				<th>문의생성날짜</th>
				<th>답변번호</th>
				<th>답변</th>
				<th>답변ID</th>
				<th>답변수정날짜</th>
				<th>답변생성날짜</th>
				<th>수정</th>
				<th>삭제</th>
			</tr>
			<%
				for(HashMap<String, Object> m : list){
					int helpNo = (Integer)m.get("helpNo");
			%>		
				<tr>
					<td><%=helpNo%></td>
					<td><%=(String)m.get("helpMemo")%></td>
					<td><%=(String)m.get("helpMemberId")%></td>
					<td><%=(String)m.get("helpUpdatedate")%></td>
					<td><%=(String)m.get("helpCreatedate")%></td>
					<td>
						<%
							if((Integer)m.get("commentNo") == 0){
						%>
								답변전	
						<%		
							} else {
						%>
								<%=(Integer)m.get("commentNo")%>
						<%
							}
						%>
					</td>
					<td>
						<%
							if(m.get("commentMemo") == null){
						%>
								답변전	
						<%		
							} else {
						%>
								<%=(String)m.get("commentMemo")%>
						<%
							}
						%>
					</td>
					<td>
						<%
							if(m.get("commentMemberId") == null){
						%>
								답변전	
						<%		
							} else {
						%>
								<%=(String)m.get("commentMemberId")%>
						<%
							}
						%>
					</td>
					<td>
						<%
							if(m.get("commentUpdatedate") == null){
						%>
								답변전	
						<%		
							} else {
						%>
								<%=(String)m.get("commentUpdatedate")%>
						<%
							}
						%>
					</td>
					<td>
						<%
							if(m.get("commentCreatedate") == null){
						%>
								답변전	
						<%		
							} else {
						%>
								<%=(String)m.get("commentCreatedate")%>
						<%
							}
						%>
					</td>
					<td>
						<%
							if(m.get("commentMemo") == null){
						%>
								<a href="<%=request.getContextPath()%>/help/updateHelpForm.jsp?helpNo=<%=helpNo%>">수정</a>	
						<%		
							} else {
						%>
								&nbsp;
						<%
							}
						%>
					</td>
					<td>
						<%
							if(m.get("commentMemo") == null){
						%>
								<a href="<%=request.getContextPath()%>/help/deleteHelpAction.jsp?helpNo=<%=helpNo%>">삭제</a>	
						<%		
							} else {
						%>
								&nbsp;
						<%
							}
						%>
					</td>
				</tr>
			<%
				}
			%>
		</table>
		<a href="<%=request.getContextPath()%>/cash/cashList.jsp">이전</a>
		<a href="<%=request.getContextPath()%>/help/insertHelpForm.jsp">추가</a>
	</div>
	<!-- footer include -->
	<div>
		<jsp:include page="/inc/footer.jsp"></jsp:include>
	</div>
</body>
</html>