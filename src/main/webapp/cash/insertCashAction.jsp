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
	
	// 방어코드
	if(request.getParameter("categoryNo") == null || request.getParameter("categoryNo").equals("")
	|| request.getParameter("memberId") == null || request.getParameter("memberId").equals("")
	|| request.getParameter("cashDate") == null || request.getParameter("cashDate").equals("")
	|| request.getParameter("cashPrice") == null || request.getParameter("cashPrice").equals("")
	|| request.getParameter("cashMemo") == null || request.getParameter("cashMemo").equals("")) {
		msg = URLEncoder.encode("내용을 입력하세요.", "utf-8"); // get 방식 주소창에 문자열 인코딩 
		response.sendRedirect(request.getContextPath()+"/cash/cashDateList.jsp?msg="+msg+"&year="+year+"&month="+month+"&date="+date);
		return;
	}
	
	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	String memberId = request.getParameter("memberId");
	String cashDate = request.getParameter("cashDate");
	long cashPrice = Long.parseLong(request.getParameter("cashPrice"));
	String cashMemo = request.getParameter("cashMemo");
	
	Cash cash = new Cash();
	cash.setCategoryNo(categoryNo);
	cash.setMemberId(memberId);
	cash.setCashDate(cashDate);
	cash.setCashPrice(cashPrice);
	cash.setCashMemo(cashMemo);
	
	// 2. M 호출
	CashDao cashDao = new CashDao();
	int row = cashDao.insertCash(cash);
	
	String redirectUrl = "/cash/cashDateList.jsp";	
	
	// 디버깅 코드
	if(row == 1) {
		System.out.println("입력성공");
		msg = URLEncoder.encode("내역이 입력되었습니다.", "utf-8");
		redirectUrl = "/cash/cashDateList.jsp?msg="+msg+"&year="+year+"&month="+month+"&date="+date;
	} else {
		System.out.println("입력실패");
		msg = URLEncoder.encode("내역 입력이 실패하였습니다.", "utf-8");
		redirectUrl = "/cash/cashDateList.jsp?msg="+msg+"&year="+year+"&month="+month+"&date="+date;
	}
	System.out.println("입력된 데이터 값: "+ categoryNo + " " + memberId + " " + cashDate + " " + cashPrice + " " + cashMemo + "<--- insertCashAction.jsp");
	
	// 3. V
	response.sendRedirect(request.getContextPath()+redirectUrl);
%>