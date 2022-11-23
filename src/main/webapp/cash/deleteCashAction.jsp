<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
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
	
	//session에 저장된 멤버(현재 로그인 사용자)
	Object objLoginMember = session.getAttribute("loginMember");
	Member loginMember = (Member)objLoginMember;
	//System.out.println(loginMember);
	
	// 알림 메시지
	String msg = null;
	
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
	
	//방어코드
	if(request.getParameter("cashNo") == null || request.getParameter("cashNo").equals("")
	|| request.getParameter("categoryKind") == null || request.getParameter("categoryKind").equals("")
	|| request.getParameter("categoryName") == null || request.getParameter("categoryName").equals("")) {
		msg = URLEncoder.encode("수정 정보를 입력하세요.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/cash/cashDateList.jsp?msg="+msg+"&year="+year+"&month="+month+"&date="+date);
		return;
	}
	
	String cashNo = request.getParameter("cashNo");
	String categoryKind = request.getParameter("categoryKind");
	String categoryName = request.getParameter("categoryName");
	
	// 디버깅 코드
	System.out.println(cashNo + " <--- cashNo");
	System.out.println(categoryKind + " <--- categoryKind");
	System.out.println(categoryName + " <--- categoryName");
	
	
	//방어코드
	if(request.getParameter("memberPw")==null 
			|| request.getParameter("memberPw").equals("")){
		msg = URLEncoder.encode("비밀번호를 입력하세요.", "utf-8");
		String msgCategoryKind = URLEncoder.encode(categoryKind, "utf-8");
		String msgCategoryName = URLEncoder.encode(categoryName, "utf-8");
		response.sendRedirect(request.getContextPath()+"/cash/deleteCashForm.jsp?msg="+msg+"&cashNo="+cashNo+"&categoryKind="+msgCategoryKind+"&categoryName="+msgCategoryName+"&year="+year+"&month="+month+"&date="+date);
		return;
	}
	
	String memberId = loginMember.getMemberId();
	String memberPw = request.getParameter("memberPw");
	
	// 디버깅 코드
	System.out.println(memberId + " <--- Id");
	System.out.println(memberPw + " <--- PW");
	
	// 2. M
	
	// db연결
	DBUtil dbUtil = new DBUtil();
	Connection conn = dbUtil.getConnection();
	
	// 비밀번호 확인
	String pwSql = "SELECT member_name memberName FROM member WHERE member_id=? AND member_pw=PASSWORD(?)";
	PreparedStatement pwStmt = conn.prepareStatement(pwSql);
	pwStmt.setString(1, memberId);
	pwStmt.setString(2, memberPw);
	ResultSet rs = pwStmt.executeQuery();
	
	String targetPage = "/cash/deleteCashForm.jsp";
	String memberName = null;
	
	while(rs.next()) {
		memberName = rs.getString("memberName"); 
		if(memberName!=null){
			System.out.println("비밀번호 확인 성공");
			
			// 내역 삭제 쿼리
			String sql = "DELETE FROM cash WHERE cash_no = ? AND member_id = ?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, cashNo);
			stmt.setString(2, memberId);
			
			int row = stmt.executeUpdate();
			
			if(row == 1) {
				System.out.println("삭제성공");
				msg = URLEncoder.encode("내역이 삭제되었습니다.", "utf-8");
				targetPage = "/cash/cashDateList.jsp?msg="+msg+"&year="+year+"&month="+month+"&date="+date;
			} else {
				System.out.println("삭제실패");
				msg = URLEncoder.encode("삭제 실패하였습니다.", "utf-8");
				String msgCategoryKind = URLEncoder.encode(categoryKind, "utf-8");
				String msgCategoryName = URLEncoder.encode(categoryName, "utf-8");
				targetPage = "/cash/deleteCashForm.jsp?msg="+msg+"&cashNo="+cashNo+"&categoryKind"+msgCategoryKind+"&categoryName"+msgCategoryName;
			}
				
			stmt.close();
			conn.close();
		}
	}
	
	if(memberName==null){
		System.out.println("비밀번호 확인 실패");	
		msg = URLEncoder.encode("비밀번호가 틀렸습니다.", "utf-8");
		String msgCategoryKind = URLEncoder.encode(categoryKind, "utf-8");
		String msgCategoryName = URLEncoder.encode(categoryName, "utf-8");
		targetPage = "/cash/deleteCashForm.jsp?msg="+msg+"&cashNo="+cashNo+"&categoryKind="+msgCategoryKind+"&categoryName="+msgCategoryName+"&year="+year+"&month="+month+"&date="+date;
	}
	
	pwStmt.close();
	rs.close();
	
	response.sendRedirect(request.getContextPath()+targetPage);
	// 3. V
%>