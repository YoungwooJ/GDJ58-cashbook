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
	
	//알림 메시지
	String msg = null;
	
	request.setCharacterEncoding("UTF-8");

	// 방어 코드
	if(request.getParameter("memberId")==null 
			|| request.getParameter("memberPw")==null
			|| request.getParameter("newMemberPw")==null 
			|| request.getParameter("memberId").equals("") 
			|| request.getParameter("memberPw").equals("")
			|| request.getParameter("newMemberPw").equals("")){
		msg = URLEncoder.encode("변경할 비밀번호를 입력하세요.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/member/updateMemberPwForm.jsp?msg="+msg);
		return;
	}

	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
	String newMemberPw = request.getParameter("newMemberPw");
	
	Member member = new Member();
	member.setMemberId(memberId);
	member.setMemberPw(memberPw);
	
	// 디버깅 코드
	System.out.println(memberId);
	System.out.println(memberPw);
	System.out.println(newMemberPw);
	
	// 2. M
	// 회원 비밀번호 변경
	MemberDao memberDao = new MemberDao();
	int row = 0;
	
	row = memberDao.updateMemberPw(member, newMemberPw);
	if(row==1){
		System.out.println("변경 성공");
		msg = URLEncoder.encode("비밀번호가 변경되었습니다.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/member/memberOne.jsp?msg="+msg);
	} else {
		System.out.println("변경 실패");
		msg = URLEncoder.encode("비밀번호가 틀렸습니다.", "utf-8");
		System.out.println(memberId+" "+memberPw+" "+ newMemberPw);
		response.sendRedirect(request.getContextPath()+"/member/updateMemberPwForm.jsp?msg="+msg);
		return;
	}
	
	// 3. V
%>