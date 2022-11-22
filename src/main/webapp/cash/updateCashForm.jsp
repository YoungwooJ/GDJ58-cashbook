<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="vo.*"%>
<%@ page import="dao.*" %>
<%@ page import="util.*"%>
<%@ page import="java.net.URLEncoder" %>
<%
	//1. C
	// session 유효성 검증 코드 후 필요하다면 redirect!
	if(session.getAttribute("loginMember") == null){
		// 로그인이 되지 않은 상태
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
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
	//디버깅 코드
	/*
	System.out.println(year);
	System.out.println(month);
	System.out.println(date);
	*/
			
	String cashNo = request.getParameter("cashNo");
	String categoryKind = request.getParameter("categoryKind");
	String categoryName = request.getParameter("categoryName");
	
	// 디버깅 코드
	System.out.println(cashNo + " <--- cashNo");
	System.out.println(categoryKind + " <--- categoryKind");
	System.out.println(categoryName + " <--- categoryName");
	
	CashDao cashDao = new CashDao();
	ArrayList<HashMap<String, Object>> list = cashDao.selectCashListByDate(loginMember.getMemberId(), year, month, date);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>