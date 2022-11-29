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
	String noticeMemo = null;

	int currentPage = 0;
	
	// 방어코드
	if(request.getParameter("currentPage")== null || request.getParameter("currentPage").equals("")){
		msg = URLEncoder.encode("메모를 입력하세요.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/admin/notice/noticeList.jsp?msg="+msg+"&currentPage="+currentPage);
		return;
	} else {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	if(request.getParameter("noticeMemo")== null || request.getParameter("noticeMemo").equals("")){
		msg = URLEncoder.encode("메모를 입력하세요.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/admin/notice/noticeList.jsp?msg="+msg+"&currentPage="+currentPage);
		return;
	} else {
		noticeMemo = request.getParameter("noticeMemo");
	}
	
	Notice notice = new Notice();
	notice.setNoticeMemo(noticeMemo);
	
	String redirectUrl = "/admin/notice/noticeList.jsp";
	
	// 2. Model 호출
	// 공지사항 입력
	NoticeDao noticeDao = new NoticeDao();
	int row = noticeDao.insertNotice(notice);
	// 디버깅 코드
	System.out.println(row + "<-- insertNoticeAction.jsp");
	if(row == 1){
		System.out.println("등록 성공");
		msg = URLEncoder.encode("공지사항이 등록되었습니다.", "utf-8");
		// 디버깅 코드
		System.out.println(noticeMemo + "<-- insertNoticeAction.jsp");
		redirectUrl = "/admin/notice/noticeList.jsp?msg="+msg+"&currentPage="+currentPage;
	} else {
		System.out.println("등록 실패");
		msg = URLEncoder.encode("공지사항 등록에 실패하였습니다.", "utf-8");
		// 디버깅 코드
		System.out.println(noticeMemo + "<-- insertNoticeAction.jsp");
		redirectUrl = "/admin/notice/noticeList.jsp?msg="+msg+"&currentPage="+currentPage;
	}

	// redirect
	response.sendRedirect(request.getContextPath()+redirectUrl);
%>