<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%
	// 1. Controller
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/member/loginForm.jsp");
		return;
	}
	
	// 2. Model 호출
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- header include -->
	<div>
		<jsp:include page="/admin/inc/header.jsp"></jsp:include>
	</div>
	<!-- msg 파라메타값이 있으면 출력 -->
	<%
		String msg = request.getParameter("msg");
		if(request.getParameter("msg") != null) {
	%>
			<div><%=msg%></div>
	<%		
		}
	%>
	<form action="<%=request.getContextPath()%>/admin/category/insertCategoryAction.jsp" method="post">
		<div>
			<table>
				<tr>
					<th>수입/지출</th>
					<td>
						<input type="radio" name="categoryKind" value="수입">수입
						<input type="radio" name="categoryKind" value="지출">지출
					</td>
				</tr>
				<tr>
					<th>이름</th>
					<td><input type="text" name="categoryName"></td>
				</tr>
			</table>
			<a href="<%=request.getContextPath()%>/admin/category/categoryList.jsp">이전</a>
			<button type="submit">추가</button>
		</div>
	</form>
	<!-- footer include -->
	<div>
		<jsp:include page="/inc/footer.jsp"></jsp:include>
	</div>
</body>
</html>