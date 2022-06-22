<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>도서 소개</title>
<link href="../css/common.css" rel="stylesheet" type="text/css">
</head>
<body>
<header>
  <jsp:include page="header.jsp" flush="false"/>
</header>
<section>
<%
	String managerId = "";
	try {
		managerId = (String) session.getAttribute("managerId");
		if (managerId==null || managerId.equals("")) {  %>
			<jsp:include page="loginForm.jsp" flush="false"/>
<%		} else { %>
			<jsp:include page="introList.jsp" flush="false"/>
<%
		}
	} catch(Exception e) {
		e.printStackTrace();
	}
%>  
</section>
</body>
</html>