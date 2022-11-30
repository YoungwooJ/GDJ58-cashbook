<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.URLEncoder" %>
<%
	// Controller
	// session 유효성 검증 코드 후 필요하다면 redirect!
	if(session.getAttribute("loginMember") == null){
		// 로그인이 되지 않은 상태
		response.sendRedirect(request.getContextPath()+"/member/loginForm.jsp");
		return;
	}
	
	//session에 저장된 멤버(현재 로그인 사용자)
	Object objLoginMember = session.getAttribute("loginMember");
	Member loginMember = (Member)objLoginMember;
	//System.out.println(loginMember);

	request.setCharacterEncoding("UTF-8");
	
	// 방어코드
	if(request.getParameter("year")==null 
			|| request.getParameter("month")==null
			|| request.getParameter("date")==null
			|| request.getParameter("year").equals("") 
			|| request.getParameter("month").equals("")
			|| request.getParameter("date").equals("")){
		String msg = URLEncoder.encode("정보를 입력하세요.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		return;
	}
	
	int year = 0;
	int month = 0;
	int date = 0;
	
	year = Integer.parseInt(request.getParameter("year"));
	month = Integer.parseInt(request.getParameter("month"));
	date = Integer.parseInt(request.getParameter("date"));
	
	
	// Model 호출
	
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryList();
	
	CashDao cashDao = new CashDao();
	ArrayList<HashMap<String, Object>> list = cashDao.selectCashListByDate(loginMember.getMemberId(), year, month, date);
	
	// View
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>cashDateList</title>
	</head>
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
<body>
	<!-- header include -->
	<div>
		<jsp:include page="/inc/header.jsp"></jsp:include>
	</div>
    
    <br><br>
    
	<div class="container">
		<!-- cash 목록 출력 -->
		<h3 style="float:left;"><strong>세부 내역</strong></h3>
		<table class="table table-border">
			<tr>
				<th colspan="7"><%=year%>년 <%=month%>월 <%=date%>일</th>
			</tr>
			<tr>
				<th>날짜</th>
				<th>구분</th>
				<th>항목</th>
				<th>금액</th>
				<th>메모</th>
				<th>작성일</th>
				<th>수정일</th>
				<th>수정</th>
				<th>삭제</th>
			</tr>
			<%
				for(HashMap<String, Object> m : list){
					String cashDate = (String)m.get("cashDate");
					if(Integer.parseInt(cashDate.substring(8)) == date){
			%>
						<tr>
							<td><%=(String)m.get("cashDate")%></td>
							<td>
								<%
									String categoryKind = (String)m.get("categoryKind");
									if(categoryKind.equals("수입")){
								%>
										<span style="color: blue;"><%=categoryKind%></span>
								<%
									} else {
								%>		
										<span style="color: red;"><%=categoryKind%></span>
								<%
									}
								%>
							</td>
							<td><%=(String)m.get("categoryName")%></td>
							<td><%=(Long)m.get("cashPrice")%>원</td>
							<td><%=(String)m.get("cashMemo")%></td>
							<td><%=(String)m.get("createdate")%></td>
							<td><%=(String)m.get("updatedate")%></td>
							<td><a href="<%=request.getContextPath()%>/cash/updateCashForm.jsp?cashNo=<%=(Integer)m.get("cashNo")%>&year=<%=year%>&month=<%=month%>&date=<%=date%>">수정</a></td>
							<td><a href="<%=request.getContextPath()%>/cash/deleteCashForm.jsp?cashNo=<%=(Integer)m.get("cashNo")%>&categoryKind=<%=(String)m.get("categoryKind")%>&categoryName=<%=(String)m.get("categoryName")%>&year=<%=year%>&month=<%=month%>&date=<%=date%>">삭제</a></td>
						</tr>
			<%			
					}		
				}
			%>
		</table>
		<br><br>
		<!-- cash 입력 폼 -->
		<h3 style="float:left;"><strong>내역 입력</strong></h3><br>
		<!-- msg 파라메타값이 있으면 출력 -->
		<%
			String msg = request.getParameter("msg");
			if(request.getParameter("msg") != null) {
		%>
				<div><%=msg%></div>
		<%		
			}
		%>
		<form action="<%=request.getContextPath()%>/cash/insertCashAction.jsp" method="post">
			<input type="hidden" name="memberId" value="<%=loginMember.getMemberId()%>">
			<input type="hidden" name="year" value="<%=year%>">
			<input type="hidden" name="month" value="<%=month%>">
			<input type="hidden" name="date" value="<%=date%>">
			<table class="table table-border">
				<tr>
					<td>날짜</td>
					<td>
						<input type="text" name="cashDate" value="<%=year%>-<%=month%>-<%=date%>" readonly="readonly">
					</td>
				</tr>
				<tr>
					<td>구분</td>
					<td>
						<select name= "categoryNo">
						<% 
							for(Category c : categoryList){
						%>
								<option value="<%=c.getCategoryNo()%>">
									<%=c.getCategoryKind()%> <%=c.getCategoryName()%>
								</option>
						<%
							}
						%>
						</select>
					</td>
				</tr>
				<tr>
					<td>금액</td>
					<td>
						<input type="number" name="cashPrice" value="">
					</td>
				</tr>
				<tr>
					<td>메모</td>
					<td>
						<textarea rows="3" cols="50" name="cashMemo"></textarea>
					</td>
				</tr>
			</table>			
			<a href="<%=request.getContextPath()%>/cash/cashList.jsp">이전</a>
			<button type="submit">입력</button>
		</form>
	</div>
	<!-- footer include -->
	<div>
		<jsp:include page="/inc/footer.jsp"></jsp:include>
	</div>
</body>
</html>