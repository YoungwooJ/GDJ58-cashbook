<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.URLEncoder" %>
<%
	//1. Controller
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/member/loginForm.jsp");
		return;
	}
	
	request.setCharacterEncoding("UTF-8");
	String msg = null;
	int noticeNo = 0;
	
	// 방어코드
	if(request.getParameter("noticeNo")== null || request.getParameter("noticeNo").equals("")){
		msg = URLEncoder.encode("오류입니다.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/admin/notice/noticeList?msg="+msg);
		return;
	} else {
		noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	}
	
	Notice notice = new Notice();
	notice.setNoticeNo(noticeNo);
	
	String redirectUrl = "/admin/notice/noticeList.jsp";
	
	// 2. Model 호출
	// 공지사항 입력
	NoticeDao noticeDao = new NoticeDao();
	int row = noticeDao.deleteNotice(notice);
	// 디버깅 코드
	System.out.println(row + "<-- deleteNoticeAction.jsp");
	if(row == 1){
		System.out.println("삭제 성공");
		msg = URLEncoder.encode("공지사항이 삭제되었습니다.", "utf-8");
		// 디버깅 코드
		System.out.println(noticeNo + "<-- deleteNoticeAction.jsp");
		redirectUrl = "/admin/notice/noticeList.jsp?msg="+msg;
	} else {
		System.out.println("삭제 실패");
		msg = URLEncoder.encode("공지사항 삭제에 실패하였습니다.", "utf-8");
		// 디버깅 코드
		System.out.println(noticeNo + "<-- delteNoticeAction.jsp");
		redirectUrl = "/admin/notice/noticeList.jsp?msg="+msg;
	}

	// redirect
	response.sendRedirect(request.getContextPath()+redirectUrl);
%>