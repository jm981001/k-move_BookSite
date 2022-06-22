<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    

<%@ page import="book.BookDAO" %>
<%@ page import="book.BookVO" %>
<%@ page import="java.io.File" %>    

<%
    request.setCharacterEncoding("utf-8");
    %>

<%
	int bnum = Integer.parseInt(request.getParameter("bnum"));
	int pageNum = Integer.parseInt(request.getParameter("pageNum"));
	
	String managerId = (String) session.getAttribute("managerId");
	if(managerId==null || managerId.equals("")) {
		response.sendRedirect("main.jsp");	
	} else {
		BookDAO bookDAO = BookDAO.getInstance();
		BookVO bookBean = bookDAO.getArticle(bnum);		
		bookDAO.deleteBook(bnum);				
		new File("D://k-move/ws/BookSite/WebContent/bookimg/" + bookBean.getBimage()).delete();

		response.sendRedirect("booklist.jsp?pageNum=" + pageNum);
	}
%>