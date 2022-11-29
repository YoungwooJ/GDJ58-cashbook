<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%
	//session에 저장된 멤버(현재 로그인 사용자)
	Object objLoginMember = session.getAttribute("loginMember");
	Member loginMember = (Member)objLoginMember;
	//System.out.println(loginMember);
%>
<a href="<%=request.getContextPath()%>/cash/cashList.jsp">가계부</a>
<a href="<%=request.getContextPath()%>/member/memberOne.jsp?loginMemberId=<%=loginMember.getMemberId()%>">내정보</a>
<a href="<%=request.getContextPath()%>/member/logout.jsp">로그아웃</a>