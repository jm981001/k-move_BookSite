<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="member.MemberDAO" %>
<%@ page import="member.MemberVO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
String managerId = (String) session.getAttribute("managerId");
if(managerId==null || managerId.equals("")) {
	response.sendRedirect("main.jsp");	
} else {

	//페이지처리
	int pageSize = 20;
	String pageNum = null;

	pageNum = request.getParameter("pageNum");
	if(pageNum == null) {
		pageNum = "1";
	}
	
	int currentPage = Integer.parseInt(pageNum);    // 1			/2 
	int startRow = (currentPage - 1) * pageSize + 1;//(1-1)*10+1=1	/(2-1)*10+1=11
	int endRow = currentPage * pageSize;			//1*10=10		/(2*10)=20
	//-----------------
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");	

	List<MemberVO> articleList = null;
	int count = 0; //총 글수
	int number = 0; //현재 페이지의 시작 번호

	MemberDAO memberDAO = MemberDAO.getInstance();
	count = memberDAO.getArticleCount();
	
	if (count > 0) {
		articleList = memberDAO.getArticles(startRow, endRow);
	}
	
	number = count - (currentPage - 1) * pageSize; //14-(1-1)*10=14 / 14-(2-1)*10=4
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>도서 소개</title>
<link href="../css/common.css" rel="stylesheet" type="text/css">
<link href="../css/admin.css" rel="stylesheet" type="text/css">
<script>
function check(id) {
	  var ret = confirm("삭제하시겠습니까??");
	  if(ret == true) { 
		  document.location.href="memberdelete.jsp?id=" + id + "&pageNum=<%=currentPage%>";
      } else {
  	      return;
      }      
 }
</script>
</head>
<body>
<header>
  <jsp:include page="header.jsp" flush="false"/>
</header>
<section>
  <h2>관리자 페이지 > 회원 관리</h2>
  <div id="member_box">
  <ul id="member_list">
	<li>
		<span class="col1"><b>번호</b></span>
		<span class="col2"><b>아이디</b></span>
		<span class="col3"><b>이름</b></span>
		<span class="col4"><b>가입일</b></span>
		<span class="col5"><b>삭제</b></span>
	</li>

<%
for(int i=0; i<articleList.size(); i++) {
  		MemberVO article = articleList.get(i);
%> 
	<li>
		<span class="col1"><%=number--%></span>
		<span class="col2"><%=article.getId()%></span>
		<span class="col3"><%=article.getName()%></span>
		<span class="col4"><%=sdf.format(article.getReg_date())%></span>
		<span class="col5"><button type="button" onclick="check('<%=article.getId()%>')">삭제</button></span>
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
			<a href="memberlist.jsp?pageNum=<%=startPage-10%>">[이전]</a>
<%		}
		
		for(int i=startPage; i<=endPage; i++) { %>
			<a href="memberlist.jsp?pageNum=<%=i%>">[<%=i%>]</a>
<%		}
		
		if(endPage < pageCount ) { %>
			<a href="memberlist.jsp?pageNum=<%=startPage+10%>">[다음]</a>
<%		}
	}
%>
  </div>
 
 </div>
</section>
</body>
</html>
<%} %>