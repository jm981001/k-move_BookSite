<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="manager.ManagerDAO" %> 

<% request.setCharacterEncoding("utf-8");%>

<%
	String id = request.getParameter("id");
	String passwd= request.getParameter("passwd");
	
	ManagerDAO managerdao = ManagerDAO.getInstance();
	int check = managerdao.userCheck(id, passwd);
	
	if(check == 1) {
		session.setAttribute("managerId", id);
		response.sendRedirect("main.jsp");
	} else if(check == 0) {
%>
	<script>
		alert("비밀번호가 맞지 않습니다.");
		history.go(-1);
	</script>
<%
	} else {
%>
	<script>
		alert("등록된 아이디가 아닙니다.");
		history.go(-1);
	</script>
<%		
	}
%>