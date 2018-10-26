<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@  taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c" %> <!-- 기본기능 -->
<%@  taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt" %> <!-- 포멧 기능 (형식지정)-->
<%@  taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn" %> <!-- 함수 기능 -->
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<link href = "https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" rel="stylesheet">

<style>
[v-cloak] {
  display: none;
}

.mytable, tr, th, td {
  padding: 5px;
  border-collapse: collapse; 
  border:1px solid black;
}

</style>

<script src="https://code.jquery.com/jquery-3.2.1.min.js"> </script>

</head>
<body>


<div id="app" v-cloak>

  <table class="mytable">

    <tr>    
    <th>NO</th>
    <th>USERID</th>
    <th>PW</th>
    </tr>
        
    <!--
      v-for 블록 안에서
      현재 항목의 인덱스에 대한 두 번째 전달인자 옵션을 제공합니다.
     -->
     
<%--     	<c:forEach var="vo" items="${map.list}"> --%>
    		
<!-- 		    <tr> -->
<%-- 		        <td>${vo.TITLE}</td> --%>
<%-- 		        <td>${vo.DIRECTOR}</td> --%>
<%-- 		        <td>${vo.COMPANY}</td> --%>
<%-- 		        <td>${vo.MONTH}</td> --%>
<%-- 		        <td>${vo.TYPE}</td>		         --%>
<%-- 		        <td>${vo.COUNTRY}</td> --%>
<%-- 		        <td>${vo.SCREEN}</td> --%>
<%-- 		        <td>${vo.VIEWER}</td> --%>
<%-- 		        <td>${vo.GENRE}</td>		         --%>
<%-- 		        <td>${vo.GRADE}</td> --%>
<!-- 		    </tr> -->
<%-- 		    </c:forEach>          --%>
    
                           
<!--     <tr v-for="(bbs, index) in bbsList"> -->
<!--       <td>{{index}}</td> <td>{{bbs.title}}</td><td>{{bbs.director}}</td><td>{{bbs.company}}</td><td>{{bbs.month}}</td><td>{{bbs.type}}</td><td>{{bbs.country}}</td><td>{{bbs.screen}}</td><td>{{bbs.viewer}}</td><td>{{bbs.genre}}</td><td>{{bbs.grade}}</td> -->
<!--     </tr> -->      
       
       <tr v-for = "k in items">        
        <td>{{k.no}}</td>
        <td>{{k.id}}</td>
        <td>{{k.pw}}</td>     
       </tr>

<!--          <tr v-for="k in items" > -->
<!--             <td> k </td> -->
<!--          </tr> -->

  </table>
</div>
<script src = "https://cdnjs.cloudflare.com/ajax/libs/vue/2.3.4/vue.js"></script>
<script>
  var app = new Vue ({
    el: "#app",
    data: {
      items : []
    },
    mounted: function() {
     	 <c:forEach var="vo" items="${map.list}">
         this.items = this.items.concat ({
        	no : "${vo.no}",          
	        id : "${vo.id}",
	        pw : "${vo.pw}"
         });
         </c:forEach>
    }
  });
  
  </script>


</body>
</html>