<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
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

	//session에 저장된 멤버(현재 로그인 사용자)
	Object objLoginMember = session.getAttribute("loginMember");
	Member loginMember = (Member)objLoginMember;
	//System.out.println(loginMember);

	// 방어 코드
	if(request.getParameter("memberId")==null 
			|| request.getParameter("memberName")==null
			|| request.getParameter("newMemberName")==null 
			|| request.getParameter("memberId").equals("") 
			|| request.getParameter("memberName").equals("")
			|| request.getParameter("newMemberName").equals("")){
		msg = URLEncoder.encode("변경할 닉네임을 입력하세요.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/member/updateMemberForm.jsp?msg="+msg);
		return;
	}
	// 방어 코드
	if(request.getParameter("memberPw")==null 
			|| request.getParameter("memberPw").equals("")){
		msg = URLEncoder.encode("비밀번호를 입력하세요.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/member/updateMemberForm.jsp?msg="+msg);
		return;
	}
	
	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
	String memberName = request.getParameter("memberName");
	String newMemberName = request.getParameter("newMemberName");
	
	Member member = new Member();
	member.setMemberId(memberId);
	member.setMemberPw(memberPw);
	member.setMemberName(memberName);
	
	// 디버깅 코드
	System.out.println(memberId);
	System.out.println(memberPw);
	System.out.println(memberName);
	System.out.println(newMemberName);
	
	// 2. M
	// 회원 닉네임 수정
	MemberDao memberDao = new MemberDao();
	int row = 0;
	
	row = memberDao.updateMemberName(member, newMemberName);
	if(row==1){
		System.out.println("수정 성공");
		msg = URLEncoder.encode("회원정보가 수정되었습니다.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/member/memberOne.jsp?msg="+msg);
	} else {
		System.out.println("수정 실패");
		msg = URLEncoder.encode("비밀번호가 틀렸습니다.", "utf-8");
		System.out.println(memberId+" "+memberPw+" "+ newMemberName);
		response.sendRedirect(request.getContextPath()+"/member/updateMemberForm.jsp?msg="+msg);
		return;
	}
	
	// 3. V
%>