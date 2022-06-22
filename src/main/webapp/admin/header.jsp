<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
  <div id="top">
	<h3><a href="main.jsp">도서 소개 사이트 - 관리자 모드</a></h3>
	<ul id="topmenu">
<%
	String managerId = "";
	try {
		managerId = (String) session.getAttribute("managerId");
		if (managerId==null || managerId.equals("")) { 
			response.sendRedirect("main.jsp");	
		} else {
%>
			<li><%=managerId %> 님</li>
			<li> | </li>
			<li><a href="logoutPro.jsp">로그 아웃</a></li>
	        <li> | </li>
	        <li><a href="managerupdateForm.jsp">정보 수정</a></li>			
<%
		}
	} catch(Exception e) {
		e.printStackTrace();
	}
%>
	</ul>
  </div> 
  <nav id="menubar">
    <ul>
      <li><a href="../main/main.jsp">HOME</a></li>
      <li><a href="booklist.jsp">도서 관리</a></li>
      <li><a href="freeboardlist.jsp">자유게시판 관리</a></li>
      <li><a href="#">Q & A 관리</a></li>
      <li><a href="memberlist.jsp">회원 관리</a></li>
    </ul>
  </nav>
</body>
</html>