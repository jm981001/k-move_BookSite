<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="freeboard.FreeBoardDAO" %>
<%@ page import="freeboard.FreeBoardVO" %>
<%@ page import="reply.ReplyDAO" %>
<%@ page import="reply.ReplyVO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
	int num = Integer.parseInt(request.getParameter("num"));
	int pageNum = Integer.parseInt(request.getParameter("pageNum"));

	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd");
	FreeBoardDAO freeboardDAO = FreeBoardDAO.getInstance();
	FreeBoardVO article = freeboardDAO.getArticle(num);
	
	List<ReplyVO> replyList = null;
	int count = 0;
	
	ReplyDAO replyDAO = ReplyDAO.getInstance();
	count = replyDAO.getArticleCount(num);
	
	if(count > 0) {
		replyList = replyDAO.getArticles(num);
	}

%>

<html>
<head>
<title>도서 소개</title>
<link href="../css/common.css" rel="stylesheet" type="text/css">
<link href="../css/board.css" rel="stylesheet" type="text/css">
<script>
  function check_input() {
      if (!document.reply_form.reply.value)
      {
          alert("댓글을 입력하세요!");    
          document.reply_form.reply.focus();
          return;
      }
      document.reply_form.submit();
   }
  
  function del(num, pageNum) {
	  if (confirm("삭제하시겠습니까?")) {
		  location.href="deletePro.jsp?num=" + num + "&pageNum=" + pageNum;
	  }else {
		  location.href="list.jsp?pageNum=" + pageNum;
	  }
  }
</script>
</head>
<body>
<header>
  <jsp:include page="../module/header.jsp" flush="false"/>
</header>
<section>
  <h2>자유 게시판 > 내용 보기</h2>
  <div id="board_box">
    <ul id="view_content">
		<li>
			<span class="col1"><b>제 목 :</b> <%=article.getSubject()%> </span>
			<span class="col2"> <%=article.getWriter()%> | <%=sdf.format(article.getReg_date())%> </span>
		</li>
		<li>
			<%=article.getContent()%>
		</li>		
    </ul>
    
    <ul class="buttons">
<%
String id = (String) session.getAttribute("id");
	if(!(id==null) && id.equals(article.getWriter())) {
%>   
		<li><button onclick="location.href='updateForm.jsp?num=<%=article.getNum()%>&pageNum=<%=pageNum%>'">수정</button></li>
		<li><button onclick="del(<%=article.getNum()%>,<%=pageNum%>)">삭제</button></li>
		<li><button onclick="location.href='list.jsp?pageNum=<%=pageNum%>'">목록</button></li>
<%
} else {
%>
		<li><button onclick="location.href='list.jsp?pageNum=<%=pageNum%>'">목록</button></li>
<%
}
%>
	</ul>
<%
if (count > 0) {
%>
	<ul id="reply_content">
<% 
for(int i=0; i<replyList.size(); i++) {
	ReplyVO reply = replyList.get(i);
%>
	<li>
		<span class="col1"><%=reply.getRwriter() %></span>
		<span class="col2"><%=reply.getReply().replace("\r\n", "<br>") %></span>
		<span class="col3"><%=sdf2.format(reply.getRreg_date())%></span>
<%		if (!(id==null) && id.equals(reply.getRwriter())) { %>
			<span class="col4"><button onclick="location.href='replyDelete.jsp'">삭제</button></span>
		<% } %>
			</li>
<%		} %>
		</ul>
<% 		}%>
	<form name="reply_form" method="post" action="replyPro.jsp">
		<input type="hidden" name="rwriter" value="<%=id %>">
		<input type="hidden" name="ref" value="<%=article.getNum() %>">
		<input type="hidden" name="pageNum" value="<%=pageNum %>">
		<ul id="reply_form">
<%		if (id==null || id.equals("")) { %>
			<li> * 댓글은 회원만 가능합니다 * </li>
<%	} else { %>

		<li>
			<span class="col1"><%=id %></span>
			<span class="col2"><textarea name="reply"></textarea></span>
			<span class="col3"><button onclick="check_input()">입력</button></span>
		</li>
<%	} %>
		</ul>
	</form>	
  </div>
</section>
<footer>
  <jsp:include page="../module/footer.jsp" flush="false"/>
</footer>      
</body>
</html>