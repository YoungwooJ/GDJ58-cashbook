<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
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

	//session에 저장된 멤버(현재 로그인 사용자)
	Object objLoginMember = session.getAttribute("loginMember");
	Member loginMember = (Member)objLoginMember;
	//System.out.println(loginMember);
	
	// 방어 코드
	if(request.getParameter("memberId")==null 
			|| request.getParameter("memberId").equals("")){
		msg = URLEncoder.encode("ID값이 없습니다.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/member/deleteMemberForm.jsp?msg="+msg);
		return;
	} else {
		String memberId = request.getParameter("memberId");
	}
	// 방어 코드
	if(request.getParameter("memberPw")==null 
			|| request.getParameter("memberPw").equals("")){
		msg = URLEncoder.encode("비밀번호를 입력하세요.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/member/deleteMemberForm.jsp?msg="+msg);
		return;
	} else {
		String memberPw = request.getParameter("memberPw");
	}
	
	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
	
	Member member = new Member();
	member.setMemberId(memberId);
	member.setMemberPw(memberPw);
	
	// 디버깅 코드
	System.out.println(memberId);
	System.out.println(memberPw);
	
	// 2. M
	// 회원 닉네임 수정
	MemberDao memberDao = new MemberDao();
	int row = 0;
	String redirectUrl = "/member/deleteMemberForm.jsp";
	
	row = memberDao.deleteMember(member);
	if(row==1){
		System.out.println("회원 탈퇴 성공");
		msg = URLEncoder.encode("회원탈퇴가 완료되었습니다.", "utf-8");
		redirectUrl = "/member/loginForm.jsp?msg="+msg;
		session.invalidate();
	} else {
		System.out.println("회원 탈퇴 실패");
		msg = URLEncoder.encode("비밀번호가 틀렸습니다.", "utf-8");
		System.out.println(memberId+" "+memberPw);
		redirectUrl = "/member/deleteMemberForm.jsp?msg="+msg;
	}
	
	response.sendRedirect(request.getContextPath()+redirectUrl);
	// 3. V
%>