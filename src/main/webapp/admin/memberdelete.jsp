<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="member.MemberDAO" %>    

<% request.setCharacterEncoding("utf-8");%>

<%
	String id = request.getParameter("id");
	int pageNum = Integer.parseInt(request.getParameter("pageNum"));
	
	String managerId = (String) session.getAttribute("managerId");
	if(managerId==null || managerId.equals("")) {
		response.sendRedirect("main.jsp");	
	} else {
		MemberDAO memberDAO = MemberDAO.getInstance();
		memberDAO.deleteMember(id);
		response.sendRedirect("memberlist.jsp?pageNum=" + pageNum);
	}
%>
