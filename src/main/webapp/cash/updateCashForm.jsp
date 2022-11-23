<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="vo.*"%>
<%@ page import="dao.*" %>
<%@ page import="util.*"%>
<%@ page import="java.net.URLEncoder" %>
<%
	// 1. C
	// session 유효성 검증 코드 후 필요하다면 redirect!
	if(session.getAttribute("loginMember") == null){
		// 로그인이 되지 않은 상태
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	//session에 저장된 멤버(현재 로그인 사용자)
	Object objLoginMember = session.getAttribute("loginMember");
	Member loginMember = (Member)objLoginMember;
	//System.out.println(loginMember);	
	
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
	//디버깅 코드
	/*
	System.out.println(year);
	System.out.println(month);
	System.out.println(date);
	*/
			
	int cashNo = Integer.parseInt(request.getParameter("cashNo"));
	
	// 디버깅 코드
	//System.out.println(cashNo + " <--- cashNo");
	
	// 2. Model 호출
	
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryList();
	
	CashDao cashDao = new CashDao();
	ArrayList<HashMap<String, Object>> list = cashDao.selectCashListByDate(loginMember.getMemberId(), year, month, date);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateCashForm</title>
</head>
<body>
	<!-- msg 파라메타값이 있으면 출력 -->
	<%
		msg = request.getParameter("msg");
		if(msg != null) {
	%>
			<div><%=msg%></div>
	<%		
		}
	%>
	<div>
		<form action="<%=request.getContextPath()%>/cash/updateCashAction.jsp">
		<input type="hidden" name="cashNo" value="<%=cashNo%>">
		<input type="hidden" name="year" value="<%=year%>">
		<input type="hidden" name="month" value="<%=month%>">
		<input type="hidden" name="date" value="<%=date%>">
		<table border="1">
			<%
			for(HashMap<String, Object> m : list){
				String cashDate = (String)m.get("cashDate");
				int categoryNo = (Integer)m.get("categoryNo");
				if(Integer.parseInt(cashDate.substring(8)) == date){
					if(cashNo == (Integer)m.get("cashNo")){
			%>
						<tr>
							<th>날짜</th>
							<td>
								<input type="text" name="cashDate" value="<%=(String)m.get("cashDate")%>" readonly="readonly">
							</td>
						</tr>
						<tr>
							<th>구분 항목</th>
							<td>
								<select name= "categoryNo">
									<option value="<%=(Integer)m.get("categoryNo")%>">
										<%=(String)m.get("categoryKind")%> <%=(String)m.get("categoryName")%>
									</option>
								<% 
									for(Category c : categoryList){
										int chkCategoryNo = (Integer)(c.getCategoryNo());
										if(categoryNo != chkCategoryNo){
											%>
												<option value="<%=c.getCategoryNo()%>">
													<%=c.getCategoryKind()%> <%=c.getCategoryName()%>
												</option>
											<%
										}
									}
								%>
								</select>
							</td>
						</tr>
						<tr>
							<th>금액</th>
							<td>
								<input type="number" name="cashPrice" value="<%=(Long)m.get("cashPrice")%>">원
							</td>
						</tr>
						<tr>
							<th>메모</th>
							<td>
								<textarea rows="3" cols="50" name="cashMemo"><%=(String)m.get("cashMemo")%></textarea>
							</td>
						</tr>
						<tr>
							<th>작성일</th>
							<td>
								<input type="text" name="cashDate" value="<%=(String)m.get("createdate")%>" readonly="readonly">
							</td>
						</tr>
			<%			
						}
					}		
				}
			%>
			<tr>
				<th>비밀번호</th>
				<td><input type="password" name="memberPw"></td>
			</tr>
		</table>
		<button type="submit">수정</button>
		</form>
	</div>
</body>
</html>