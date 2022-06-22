<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="freeboard.FreeBoardDAO" %>
<%@ page import="freeboard.FreeBoardVO" %>
<%@ page import="reply.ReplyDAO" %>
<%@ page import="reply.ReplyVO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
//페이지처리
	int pageSize = 10;
	String pageNum = null;

	pageNum = request.getParameter("pageNum");
	if(pageNum == null) {
		pageNum = "1";
	}
	
	int currentPage = Integer.parseInt(pageNum);    // 1			/2 
	int startRow = (currentPage - 1) * pageSize + 1;//(1-1)*10+1=1	/(2-1)*10+1=11
	int endRow = currentPage * pageSize;			//1*10=10		/(2*10)=20
	
	int number = 0; //현재 페이지의 시작 번호
	//-----------------
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");	

	List<FreeBoardVO> articleList = null;
	int count = 0; //총 글수

	FreeBoardDAO freeboardDAO = FreeBoardDAO.getInstance();
	count = freeboardDAO.getArticleCount();
	
	if (count > 0) {
		articleList = freeboardDAO.getArticles(startRow, endRow);
	}
	
	number = count - (currentPage - 1) * pageSize; //14-(1-1)*10=14 / 14-(2-1)*10=4
		
	int replycount = 0;
	ReplyDAO replyDAO = ReplyDAO.getInstance();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>도서 소개</title>
<link href="../css/common.css" rel="stylesheet" type="text/css">
<link href="../css/board.css" rel="stylesheet" type="text/css">
</head>
<body>
<header>
  <jsp:include page="../module/header.jsp" flush="false"/>
</header>
<section>
  <h2>자유 게시판 > 목록 보기</h2>
  <div id="board_box">
  <ul id="board_list">
	<li>
		<span class="col1"><b>번호</b></span>
		<span class="col2"><b>제 목</b></span>
		<span class="col3"><b>글쓴이</b></span>
		<span class="col4"><b>등록일</b></span>
		<span class="col5"><b>조회</b></span>
	</li>

<%
for(int i=0; i<articleList.size(); i++) {
  		FreeBoardVO article = articleList.get(i);
  		replycount = replyDAO.getArticleCount(article.getNum());
%> 
	<li>
		<span class="col1"><%=number--%></span>
		<span class="col2"><a href="content.jsp?num=<%=article.getNum()%>&pageNum=<%=currentPage%>"><%=article.getSubject()%></a>
			<span class="replycount">
<% 		if(replycount > 0) { %>
				[<%=replycount %>]
<%		} %>
			</span>
		</span>
		<span class="col3"><%=article.getWriter()%></span>
		<span class="col4"><%=sdf.format(article.getReg_date())%></span>
		<span class="col5"><%=article.getReadcount()%></span>
	</li>
<% 	} %>  
  </ul>	
  <br>
  <div class="page">
<%
	if(count > 0) {
		int pageCount = count / pageSize + (count%pageSize == 0 ? 0 : 1); // 14/10+1=2
		int startPage = 1;
		if(currentPage%10 != 0) {
			startPage = (int)(currentPage/10) * 10 + 1; // (14/10)*10+1=11 / (2/10)*10+1=1
		} else {
			startPage = ((int)(currentPage/10)-1) * 10 + 1; // (10/10-1)*10+1=1 / (20/10-1)*10+1=11
		}
		
		int pageBlock = 10;
		int endPage = startPage + pageBlock - 1; // 1+10-1=10 / 11+10-1=20
		if(endPage > pageCount) {
			endPage = pageCount;
		}
		
		if(startPage > 10 ) { %>
			<a href="list.jsp?pageNum=<%=startPage-10%>">[이전]</a>
<%		}
		
		for(int i=startPage; i<=endPage; i++) { %>
			<a href="list.jsp?pageNum=<%=i%>">[<%=i%>]</a>
<%		}
		
		if(endPage < pageCount ) { %>
			<a href="list.jsp?pageNum=<%=startPage+10%>">[다음]</a>
<%		}
	}
%>
  </div>
  
  <ul class="buttons">
  	<li>
<%
	String id = (String) session.getAttribute("id");
	if(id==null || id.equals("")) { %>  	
		<a href="javascript:alert('로그인 후 이용해 주세요!')"><button>글쓰기</button></a>
<%	} else { %>			
  		<button onclick="location.href='writeForm.jsp'">글쓰기</button>
<% 	} %>
  	</li>
  </ul>
 
 </div>
</section>
<footer>
  <jsp:include page="../module/footer.jsp" flush="false"/>
</footer>
</body>
</html>