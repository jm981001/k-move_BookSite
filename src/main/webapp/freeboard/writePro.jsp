<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="freeboard.FreeBoardDAO" %>

<% request.setCharacterEncoding("utf-8"); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String id = (String) session.getAttribute("id");
	if(id==null || id.equals("")) {
		response.sendRedirect("../main/main/jsp");
	} else {
%>
	<jsp:useBean id="article" class="freeboard.FreeBoardVO">
		<jsp:setProperty name="article" property="*"/>
	</jsp:useBean>
<%
	FreeBoardDAO freeboardDAO = FreeBoardDAO.getInstance();
	freeboardDAO.insertBoard(article);
	
	response.sendRedirect("list.jsp");
	}
%>
</body>
</html>