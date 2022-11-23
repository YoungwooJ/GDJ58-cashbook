<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*"%>
<%@ page import="util.*"%>
<%@ page import="java.net.URLEncoder" %>
<%
	// 1. C
	// session 유효성 검증 코드 후 필요하다면 redirect!
	if(session.getAttribute("loginMember") == null){
		// 로그인이 되지 않은 상태
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
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
			|| request.getParameter("memberPw")==null
			|| request.getParameter("memberName")==null
			|| request.getParameter("newMemberName")==null 
			|| request.getParameter("memberId").equals("") 
			|| request.getParameter("memberPw").equals("")
			|| request.getParameter("memberName").equals("")
			|| request.getParameter("newMemberName").equals("")){
		msg = URLEncoder.encode("변경할 닉네임을 입력하세요.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/updateMemberForm.jsp?msg="+msg);
		return;
	}
	
	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
	String memberName = request.getParameter("memberName");
	String newMemberName = request.getParameter("newMemberName");
	
	// 디버깅 코드
	System.out.println(memberId);
	System.out.println(memberPw);
	System.out.println(memberName);
	System.out.println(newMemberName);
	
	// 2. M
	
	// db연결
	DBUtil dbUtil = new DBUtil();
	Connection conn = dbUtil.getConnection();
	
	// 쿼리
	String sql = null;
	PreparedStatement stmt = null;
	sql = "UPDATE member SET member_name = ? WHERE member_id = ? AND member_pw = PASSWORD(?)";
	stmt = conn.prepareStatement(sql);
	stmt.setString(1, newMemberName);
	stmt.setString(2, memberId);
	stmt.setString(3, memberPw);
	
	int row = stmt.executeUpdate();
	
	if(row==1){
		System.out.println("수정 성공");
		msg = URLEncoder.encode("회원정보가 수정되었습니다.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/memberOne.jsp?msg="+msg);
	} else {
		System.out.println("수정 실패");
		msg = URLEncoder.encode("비밀번호가 틀렸습니다.", "utf-8");
		System.out.println(memberId+" "+memberPw+" "+ newMemberName);
		response.sendRedirect(request.getContextPath()+"/updateMemberForm.jsp?msg="+msg);
		return;
	}
	
	stmt.close();
	conn.close();
	
	// 3. V
%>