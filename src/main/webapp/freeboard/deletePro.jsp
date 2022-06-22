<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="freeboard.FreeBoardDAO" %>

<% request.setCharacterEncoding("utf-8"); %>

<%
	int pageNum = Integer.parseInt(request.getParameter("pageNum"));
	int num = Integer.parseInt(request.getParameter("num"));
	
	String id = (String) session.getAttribute("id");
	if(id == null || id.equals("")) {
		response.sendRedirect("../main/main.jsp");
	} else {
		FreeBoardDAO freeboardDAO = FreeBoardDAO.getInstance();
		freeboardDAO.deleteBoard(num);
		response.sendRedirect("list.jsp?pageNum=" + pageNum);
	}
%>
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>