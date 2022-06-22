<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="reply.ReplyDAO" %>

<% request.setCharacterEncoding("utf-8"); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	int pageNum = Integer.parseInt(request.getParameter("pageNum"));

	String id = (String) session.getAttribute("id");
	if(id == null || id.equals("")) {
		response.sendRedirect("../main/main.jsp");
	} else {
%>
	<jsp:useBean id="reply" class="reply.ReplyVO">
		<jsp:setProperty name="reply" property="*"/>
	</jsp:useBean>
<%
	ReplyDAO replyDAO = ReplyDAO.getInstance();
	replyDAO.insertReply(reply);
	
	response.sendRedirect("content.jsp?num=" + reply.getRef() + "&pageNum=" + pageNum);

	}
%>
</body>
</html>