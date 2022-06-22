<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="book.BookDAO" %>
<%@ page import="book.BookVO" %>
<%@ page import="java.util.List" %>

<% 
	//페이지처리
	int pageSize = 8;
	String pageNum = null;
	
	pageNum = request.getParameter("pageNum");
	if(pageNum == null) {
		pageNum = "1";
	}
	
	int currentPage = Integer.parseInt(pageNum); //1
	int startRow = (currentPage - 1) * pageSize + 1; //(1-1)*10+1=1
	int endRow = currentPage * pageSize;//1*10=10
	
	//int number = 0; //현재 페이지의 시작 번호
	//------------------
	
	List<BookVO> articleList = null;
	int count = 0; //총 글 수 
	
	BookDAO bookDAO = BookDAO.getInstance();
	count = bookDAO.getArticleCount();
	
	if (count > 0) {
		articleList = bookDAO.getArticles(startRow, endRow);
	}
	
	// number = count - (currentPage - 1) * pageSize;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>도서 소개</title>
<link href="../css/common.css" rel="stylesheet" type="text/css">
<link href="../css/book.css" rel="stylesheet" type="text/css">
</head>
	<jsp:include page="../module/header.jsp" flush="false"/>
<body>
<section>
	<h2>도 서 소 개</h2>
<%
for(int i=0; i<articleList.size(); i++) {
		BookVO article = articleList.get(i);
%>
	<article class="at_list">
		<div class="view_box">
			<div class="view_box_block">
				<a href="bookcontent.jsp?bnum=<%=article.getBnum()%>&pageNum=<%=currentPage%>">
					<img class="img_list" src="../bookimg/<%=article.getBimage()%>" alt="상세보기"/></a>
			</div>
			<div class="info">
				<br>
				<p><a href="bookcontent.jsp?bnum=<%=article.getBnum()%>&pageNum=<%=currentPage%>"><%=article.getBtitle() %></a>			
				<br>
				<p class="book_writer"><%=article.getAuthor()%></p>
			</div>
		</div>
	</article>
<% 	} %>
	<br>
	<div class="page">
<%
	if(count > 0) {
		int pageCount = count / pageSize + (count%pageSize == 0 ? 0 : 1);
		int startPage = 1;
		if(currentPage%10 != 0) {
			startPage = (int)(currentPage/8) * 10 + 1;
		}else {
			startPage = ((int)(currentPage/8)-1) *10 + 1;
		}
		
		int pageBlock = 10;
		int endPage = startPage + pageBlock - 1;
		if(endPage > pageCount) {
			endPage = pageCount;
		}
		
		if(startPage > 10) { %>
			<a href="booklist.jsp?pageNum=<%=startPage-10%>">[이전]</a>
<% 		}
		
		for(int i=startPage; i<=endPage; i++) { %>
			<a href="booklist.jsp?pageNum=<%=i%>">[<%=i%>]</a>
<% 		}
		
		if(endPage < pageCount) { %>
			<a href="booklist.jsp?pageNum=<%=startPage+10%>">[다음]</a>
<% 		}
	}
%>
	</div>
</section>
<footer>
	<jsp:include page="../module/footer.jsp" flush="false"/>
</footer>
</body>
</html>