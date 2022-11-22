<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	session.invalidate(); // 세션 초기화
	System.out.println("로그아웃 성공");
	response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
%>