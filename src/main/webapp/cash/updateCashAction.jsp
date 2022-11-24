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
		response.sendRedirect(request.getContextPath()+"/member/loginForm.jsp");
		return;
	}
	
	//session에 저장된 멤버(현재 로그인 사용자)
	Object objLoginMember = session.getAttribute("loginMember");
	Member loginMember = (Member)objLoginMember;
	System.out.println(loginMember);	
	
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
	
	//방어코드
	if(request.getParameter("categoryNo") == null || request.getParameter("categoryNo").equals("")
	|| request.getParameter("cashPrice") == null || request.getParameter("cashPrice").equals("")
	|| request.getParameter("cashMemo") == null || request.getParameter("cashMemo").equals("")
	|| request.getParameter("cashNo") == null || request.getParameter("cashNo").equals("")) {
		msg = URLEncoder.encode("수정 정보를 입력하세요.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/cash/updateCashForm.jsp?msg="+msg+"&cashNo="+cashNo+"&year="+year+"&month="+month+"&date="+date);
		return;
	}
	
	if(request.getParameter("memberPw") == null || request.getParameter("memberPw").equals("")){
		msg = URLEncoder.encode("비밀번호를 입력하세요.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/cash/updateCashForm.jsp?msg="+msg+"&cashNo="+cashNo+"&year="+year+"&month="+month+"&date="+date);
		return;
	}

	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	long cashPrice = Long.parseLong(request.getParameter("cashPrice"));
	String cashMemo = request.getParameter("cashMemo");
	String memberId = loginMember.getMemberId();
	String memberPw = request.getParameter("memberPw");
	
	// 디버깅 코드
	System.out.println(categoryNo + " <--- categoryNo");
	System.out.println(cashPrice + " <--- cashPrice");
	System.out.println(cashMemo + " <--- cashMemo");
	System.out.println(cashNo + " <--- cashNo");
	System.out.println(memberId + " <--- memberId");
	System.out.println(memberPw + " <--- memberPw");
	
	Member member = new Member();
	member.setMemberId(memberId);
	member.setMemberPw(memberPw);
	
	Cash cash = new Cash();
	cash.setCategoryNo(categoryNo);
	cash.setCashPrice(cashPrice);
	cash.setCashMemo(cashMemo);
	cash.setCashNo(cashNo);
	cash.setMemberId(memberId);
	
	// 2. M
	CashDao cashDao = new CashDao();
	MemberDao memberDao = new MemberDao();
	
	// 비밀번호 확인
	String targetUrl = "/cash/updateCashForm.jsp";
	
	if(memberDao.memberPwck(member)) {
		System.out.println("비밀번호 확인 성공");
		// 업데이트
		int row = 0;
		row = cashDao.updateCash(cash);
		if(row==1){
			System.out.println("수정 성공");
			msg = URLEncoder.encode("내용이 수정되었습니다.", "utf-8");
			targetUrl = "/cash/cashDateList.jsp?msg="+msg+"&year="+year+"&month="+month+"&date="+date;
		} else {
			System.out.println("수정 실패");
			msg = URLEncoder.encode("수정 실패하였습니다.", "utf-8");
			System.out.println(categoryNo+" "+cashPrice+" "+ cashMemo+" "+ cashNo+" "+ loginMember.getMemberId());
			targetUrl = "/cash/updateCashForm.jsp?msg="+msg+"&cashNo="+cashNo+"&year="+year+"&month="+month+"&date="+date;
		}
	} else {
		System.out.println("비밀번호 확인 실패");	
		msg = URLEncoder.encode("비밀번호가 틀렸습니다.", "utf-8");
		targetUrl = "/cash/updateCashForm.jsp?msg="+msg+"&cashNo="+cashNo+"&year="+year+"&month="+month+"&date="+date;
	}
	
	response.sendRedirect(request.getContextPath()+targetUrl);
	// 3. V
%>	