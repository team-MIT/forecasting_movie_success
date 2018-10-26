<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>Insert title here</title>

<script src="https://code.jquery.com/jquery-3.2.1.min.js">
</script>

<script>
    $(document).ready(function() {
        $("#btnSave").click(function() {
        	alert(" Movie Insert move");
            document.form1.submit();
        });
    });
</script>

</head>

<body>
 <h3> 글 작성 </h3>
 <form name="form1" method="post" action="${pageContext.servletContext.contextPath}/testinsert">
<%-- <input type="hidden" name="id" id="id" value="${session_id}" > --%>

    <div>
        TITLE
      <input name="TITLE" id="TITLE" size="80" placeholder="TITLE ">
    </div>
    <div>
        Director
      <input name="DIRECTOR" id="DIRECTOR" size="80" placeholder="Director ">
    </div>
    <div>
        Company
      <input name="COMPANY" id="COMPANY" size="80" placeholder="COMPANY ">
    </div>
    <div>
        Month
      <input name="MONTH" id="MONTH" size="80" placeholder="MONTH ">
    </div>
    <div>
        Type
      <input name="TYPE" id="TYPE" size="80" placeholder="TYPE ">
    </div>
    <div>
        Country
      <input name="COUNTRY" id="COUNTRY" size="80" placeholder="COUNTRY ">
    </div>
    <div>
         Screen
      <input name="SCREEN" id="SCREEN" size="80" placeholder="SCREEN ">
    </div>
    <div>
         Viewer
      <input name="VIEWER" id="VIEWER" size="80" placeholder="VIEWER ">
    </div>
    <div>
        Genre
      <input name="GENRE" id="GENRE" size="80" placeholder="GENRE ">
    </div>
    
    <div>
        Grade
      <input name="GRADE" id="GRADE" size="80" placeholder="GRADE ">
    </div>
    
    <div style="width:650px; text-align: center;">
        <button type="button" id="btnSave">확인</button>
        <button type="reset">취소</button>
    </div>
</form>
 
  
</body>
</html>