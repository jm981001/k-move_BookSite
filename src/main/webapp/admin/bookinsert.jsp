<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String managerId = (String) session.getAttribute("managerId");
	if(managerId==null || managerId.equals("")) {
		response.sendRedirect("main.jsp");	
	} else {
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>도서 소개</title>
<link href="../css/common.css" rel="stylesheet" type="text/css">
<link href="../css/admin.css" rel="stylesheet" type="text/css">
<script>
  function check_input() {
      if (!document.book_form.bkind.value)
      {
          alert("분류를 선택하세요!");
          document.book_form.bkind.focus();
          return;
      }
      if (!document.book_form.btitle.value)
      {
          alert("제목을 입력하세요!");    
          document.book_form.btitle.focus();
          return;
      }
      if (!document.book_form.author.value)
      {
          alert("저자를 입력하세요!");    
          document.book_form.author.focus();
          return;
      }
      if (!document.book_form.pubcom.value)
      {
          alert("출판사를 입력하세요!");    
          document.book_form.pubcom.focus();
          return;
      }
      if (!document.book_form.pubdate.value)
      {
          alert("출판일을 입력하세요!");    
          document.book_form.pubdate.focus();
          return;
      }
      if (!document.book_form.page.value)
      {
          alert("페이지를 입력하세요!");    
          document.book_form.page.focus();
          return;
      }
      if (!document.book_form.bcontent.value)
      {
          alert("도서 내용을 입력하세요!");    
          document.book_form.bcontent.focus();
          return;
      }
      if (!document.book_form.bimage.value)
      {
          alert("도서 이미지를 입력하세요!");    
          document.book_form.bimage.focus();
          return;
      }
      document.book_form.submit();
   }
</script>
</head>
<body>
<header>
  <jsp:include page="header.jsp" flush="false"/>
</header>
<section>
  <h2>관리자 페이지 > 도서 관리 > 도서 등록</h2>
  <div id="bookform_box">
  <form  name="book_form" method="post" enctype="multipart/form-data" action="bookinsertPro.jsp">
   	 <ul id="book_form">
		<li>
			<span class="col1">&nbsp;&nbsp;분류선택</span>
			<span class="col2">
				<select name="bkind">
           			<option value="100">컴퓨터</option>
           			<option value="200">외국어</option>
           			<option value="300">문학</option>
       			</select>		
			</span>
		</li>		
   		<li>
   			<span class="col1">&nbsp;&nbsp;제&nbsp;&nbsp;&nbsp;목</span>
   			<span class="col2"><input name="btitle" type="text"></span>
   		</li>
   		<li>
			<span class="col1">&nbsp;&nbsp;저&nbsp;&nbsp;&nbsp;자</span>
			<span class="col2"><input name="author" type="text"></span>
		</li>
		<li>
			<span class="col1">&nbsp;&nbsp;출 판 사</span>
			<span class="col2"><input name="pubcom" type="text"></span>
		</li>
		<li>
			<span class="col1">&nbsp;&nbsp;출 판 일</span>
			<span class="col2"><input name="pubdate" type="date"></span>
		</li>
		<li>
			<span class="col1">&nbsp;&nbsp;페 이 지</span>
			<span class="col2"><input name="page" type="text"></span>
		</li>	    	
   		<li id="text_area">	
   			<span class="col1">&nbsp;&nbsp;내&nbsp;&nbsp;&nbsp;용</span>
   			<span class="col2">
   				<textarea name="bcontent"></textarea>
   			</span>
   		</li>
   		<li>
		     <span class="col1">&nbsp;&nbsp;도서 이미지</span>
		     <span class="col2"><input type="file" name="bimage"></span>
		</li>
    </ul>
   	<ul class="buttons">
		<li><button type="button" onclick="check_input()">등 록</button></li>
		<li><button type="button" onclick="location.href='booklist.jsp'">목 록</button></li>
	</ul>
  </form>
  </div>
</section>
</body>
</html>
<%} %>