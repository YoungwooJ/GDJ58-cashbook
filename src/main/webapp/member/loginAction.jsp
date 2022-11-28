<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%@ page import="java.net.URLEncoder" %>
<%	
	// 1. C
	// session 유효성 검증 코드 후 필요하다면 redirect!
	if(session.getAttribute("loginMember") != null){
		// 로그인이 된 상태
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		return;
	}

	// 메시지 코드
	String msg = null;
	
	//방어코드
	if(request.getParameter("memberId")==null 
			|| request.getParameter("memberPw")==null
			|| request.getParameter("memberId").equals("") 
			|| request.getParameter("memberPw").equals("")){
		msg = URLEncoder.encode("정보를 입력하세요.", "utf-8"); // get 방식 주소창에 문자열 인코딩 
		response.sendRedirect(request.getContextPath()+"/member/loginForm.jsp?msg="+msg);
		return;
	}
	
	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
	
	Member paramMember = new Member(); // 모델 호출시 매개값
	
	// 분리된 M(모델)을 호출
	MemberDao memberDao = new MemberDao();
	paramMember.setMemberId(memberId);
	paramMember.setMemberPw(memberPw);
	Member resultMember = memberDao.login(paramMember);
	
	String redirectUrl = "/member/loginForm.jsp";
	
	if(resultMember == null){
			System.out.println("로그인 실패");
			msg = URLEncoder.encode("아이디와 비밀번호를 확인하세요.", "utf-8"); // get 방식 주소창에 문자열 인코딩 
			redirectUrl = "/member/loginForm.jsp?msg="+msg;
	} else {
		   	System.out.println("로그인 성공");
			// 로그인 성공했다는 값을 저장 -> session 
			session.setAttribute("loginMember", resultMember); // session에 로그인 아이디 & 이름을 저장
			redirectUrl = "/cash/cashList.jsp";
	}
	
	// redirect
	response.sendRedirect(request.getContextPath()+redirectUrl);
%>