<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="book.BookDAO" %>   
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.Date" %>
<%@ page import="java.sql.Timestamp" %>

<% request.setCharacterEncoding("utf-8");%>

<%
	String managerId = (String) session.getAttribute("managerId");
	if(managerId==null || managerId.equals("")) {
		response.sendRedirect("main.jsp");	
	} else {
		//파일이 업로드되는 폴더를 지정한다.
		String saveFolder = "C://K-MOVE IT/BookSite/src/main/webapp/bookimg"; 
		String encType = "utf-8"; //엔코딩타입
		int maxSize = 5*1024*1024;  //최대 업로될 파일크기 5Mb
		MultipartRequest multi = null;
		String filename = "";
		
		try{
		   multi = new MultipartRequest(request, saveFolder, maxSize, encType, new DefaultFileRenamePolicy());
		   out.println("업로드 성공");
		   filename = multi.getFilesystemName("bimage"); //서버에 저장된 파일 이름
		  
		}catch(Exception e){
		 	System.out.println(e);
		}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
 
	<jsp:useBean id="article" class="book.BookVO">
		<!--<jsp:setProperty name="article" property="*" />-->
	</jsp:useBean>
<%
	article.setBkind(multi.getParameter("bkind"));
	article.setBtitle(multi.getParameter("btitle"));
	article.setAuthor(multi.getParameter("author"));
	article.setPubcom(multi.getParameter("pubcom"));
	article.setPubdate(new Timestamp(Date.valueOf(multi.getParameter("pubdate")).getTime()));
	article.setPage(Integer.parseInt(multi.getParameter("page")));
	article.setBimage(filename);	
	article.setBcontent(multi.getParameter("bcontent"));
	
	BookDAO bookDAO = BookDAO.getInstance();
	bookDAO.insertBoard(article);
	
	response.sendRedirect("booklist.jsp");
%>	
</body>
</html>
<%} %>