<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<head>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"> </script>

</head>
<body>
	
			<table>			
			<tr>
            <td><img src="/resources/imagePost/그녀는 거짓말을 너무 사랑해_코이즈미 노리히로.jpg" alt="" /></td>	
			</tr>
	        <tr> 
<%-- 			<img src="${pageContext.servletContext.contextPath}/resources/imagePost/다녀올게_김태연.jpg" alt="" />	              --%>
             <td> <img src="resources/imagePost/다녀올게_김태연.jpg" alt="" /></td>	      
	        </tr>
	        <tr>
<%-- 			<img src="${pageContext.servletContext.contextPath}/resources/imagePost/독전_이해영.jpg" alt="" />	              --%>
            <td>   <img src="resources/imagePost/독전_이해영.jpg" alt="" /> </td>	 
	        </tr>
	        </table>

 
<input id="input-1-ltr-alt-xs" name="input-1-ltr-alt-xs" class="kv-ltr-theme-svg-alt rating-loading" value="1" dir="ltr" data-size="xs">
<br/>
<input id="input-2-ltr-alt-sm" name="input-2-ltr-alt-sm" class="kv-ltr-theme-svg-alt rating-loading" value="2" dir="ltr" data-size="sm">
<br/>
<input id="input-3-ltr-alt-md" name="input-3-ltr-alt-md" class="kv-ltr-theme-svg-alt rating-loading" value="3" dir="ltr" data-size="md">
<br/>
<input id="input-4-ltr-alt-lg" name="input-4-ltr-alt-lg" class="kv-ltr-theme-svg-alt rating-loading" value="4" dir="ltr" data-size="lg">
<br/>
<input id="input-5-ltr-alt-xl" name="input-5-ltr-alt-xl" class="kv-ltr-theme-svg-alt rating-loading" value="5" dir="ltr" data-size="xl">
<br/>


</body>
<script>
$(document).on('ready', function() {
    $('.kv-ltr-theme-svg-alt').rating({
        hoverOnClear: false,
        theme: 'krajee-svg',       
        containerClass: 'is-heart',
        filledStar: '<span class="krajee-icon krajee-icon-heart"></span>',
        emptyStar: '<span class="krajee-icon krajee-icon-heart"></span>',
        defaultCaption: '{rating} hearts',
        starCaptions: function (rating) {
            return rating == 1 ? 'One heart' : rating + ' hearts';
        }
    });
});

</script>