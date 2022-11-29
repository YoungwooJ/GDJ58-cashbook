<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import="java.net.URLEncoder" %>
<%
	//1. Controller : session, request
	// session 유효성 검증 코드 후 필요하다면 redirect!
	if(session.getAttribute("loginMember") == null){
		// 로그인이 되지 않은 상태
		response.sendRedirect(request.getContextPath()+"/member/loginForm.jsp");
		return;
	}
	
	//알림 메시지
	String msg = null;
	
	request.setCharacterEncoding("UTF-8");
	
	String memberId = null;
	String helpMemo = null;
	
	// 방어코드
	if(request.getParameter("memberId") == null || request.getParameter("memberId").equals("")
	|| request.getParameter("helpMemo") == null || request.getParameter("helpMemo").equals("")) {
		msg = URLEncoder.encode("내용을 입력하세요.", "utf-8"); // get 방식 주소창에 문자열 인코딩 
		response.sendRedirect(request.getContextPath()+"/help/insertHelpForm.jsp?msg="+msg);
		return;
	} else {
		memberId = request.getParameter("memberId");
		helpMemo = request.getParameter("helpMemo");
	}
	
	Help help = new Help();
	help.setMemberId(memberId);
	help.setHelpMemo(helpMemo);
	
	String redirectUrl = "/help/helpList.jsp";
	
	// 2. Model 호출
	HelpDao helpDao = new HelpDao();
	int row = helpDao.insertHelp(help);
	// 디버깅 코드
	if(row == 1){
		System.out.println("입력성공");
		msg = URLEncoder.encode("문의가 입력되었습니다.", "utf-8");
		redirectUrl = "/help/helpList.jsp?msg="+msg;
	} else {
		System.out.println("입력실패");
		msg = URLEncoder.encode("문의 입력이 실패하였습니다.", "utf-8");
		redirectUrl = "/help/helpList.jsp?msg="+msg;
	}
	System.out.println("입력된 데이터 값: "+ memberId + " " + helpMemo + "<--- insertHelpAction.jsp");
	
	// 3. V
	response.sendRedirect(request.getContextPath()+redirectUrl);
%>