<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="util.*" %>
<%@ page import="java.net.URLEncoder" %>
<%
	// 1. C
	// session 유효성 검증 코드 후 필요하다면 redirect!
	if(session.getAttribute("loginMember") != null){
		// 로그인이 된 상태
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		return;
	}
	
	request.setCharacterEncoding("UTF-8");
	String msg = null;
	
	// 방어 코드
	if(request.getParameter("memberName")==null||request.getParameter("memberName").equals("")||request.getParameter("memberId")==null || request.getParameter("memberId").equals("")||request.getParameter("memberPw")==null||request.getParameter("memberPw").equals("")){
		msg = URLEncoder.encode("회원 가입 정보를 입력하세요.", "utf-8"); // get 방식 주소창에 문자열 인코딩 
		response.sendRedirect(request.getContextPath()+"/member/insertMemberForm.jsp?msg="+msg);
		return;
	}
	
	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
	String memberName = request.getParameter("memberName");
	
	Member member = new Member();
	member.setMemberId(memberId);
	member.setMemberPw(memberPw);
	member.setMemberName(memberName);
	
	String redirectUrl = "/member/insertMemberForm.jsp";
	
	// 2. M 호출
	// ID 중복 안되게
	MemberDao memberDao = new MemberDao();
	if(memberDao.selectMemberIdck(memberId)){
		System.out.println("아이디 중복");
		msg = URLEncoder.encode("아이디가 중복되었습니다.", "utf-8");
		redirectUrl = "/member/insertMemberForm.jsp?msg="+msg;
	} else {
		// 회원 가입 쿼리
		int row = memberDao.insertMember(member);
		// 디버깅 코드
		System.out.println(row + "<-- insertMemberAction.jsp row");
		if(row==1){
			System.out.println("회원가입 성공");
			msg = URLEncoder.encode("회원가입이 완료되었습니다.", "utf-8");
			// 디버깅 코드
			System.out.println(memberId+" "+memberPw+" "+ memberName + "<-- insertMemberAction.jsp");
			redirectUrl = "/member/loginForm.jsp?msg="+msg;
		} else {
			System.out.println("회원가입 실패");
			msg = URLEncoder.encode("회원가입에 실패하였습니다.", "utf-8");
			// 디버깅 코드
			System.out.println(memberId+" "+memberPw+" "+ memberName + "<-- insertMemberAction.jsp");
			redirectUrl = "/member/insertMemberForm.jsp?msg="+msg;
		}
	}
	
	// redirect
	response.sendRedirect(request.getContextPath()+redirectUrl);
%>