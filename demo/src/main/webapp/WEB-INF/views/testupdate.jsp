<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.2.1.min.js">
</script>

<script>
$(document).ready(function() {
    $("#btnUpdete").click(function() {
    	alert(" Movie update move");
        document.form1.submit();
    });
});

</script>
</head>

<body>

  <form name = "form1" method="post" action="${pageContext.servletContext.contextPath}/update">
   DIRECTOR : <input name = "DIRECTOR" id= "DIRECTOR" size="80%" value="${vo.DIRECTOR}" placeholder="감독을 입력해주세요"><br><br>
   COMPANY : <input name = "COMPANY" id= "COMPANY" size="80%" value="${vo.COMPANY}" placeholder="배급사를 입력해주세요"><br><br>
      
   <input type="hidden" name="TITLE" id= "TITLE" value="${vo.TITLE}">
  <button type="button" id="btnUpdete"> UPDATE </button>   
 </form>
  
</body>

</html>