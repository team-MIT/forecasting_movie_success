<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@  taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- 기본기능 -->
<%@  taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- 포멧 기능 (형식지정)-->
<%@  taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!-- 함수 기능 -->
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/bulma/0.3.1/css/bulma.min.css" />

<style>
[v-cloak] {
	display: none;
}

.mytable, tr, th, td {
	padding: 5px;
	border-collapse: collapse;
	border: 1px solid black;
}

.starR1 {
	background:
		url('http://miuu227.godohosting.com/images/icon/ico_review.png')
		no-repeat -52px 0;
	background-size: auto 100%;
	width: 13px;
	height: 28px;
	float: left;
	text-indent: -9999px;
	cursor: pointer;
}

.starR2 {
	background:
		url('http://miuu227.godohosting.com/images/icon/ico_review.png')
		no-repeat right 0;
	background-size: auto 100%;
	width: 13px;
	height: 28px;
	float: left;
	text-indent: -9999px;
	cursor: pointer;
}

.starR1.on {
	background-position: 0 0;
}

.starR2.on {
	background-position: -15px 0;
}

.starR.on {
	background-position: 0 0;
}
</style>
</head>
<body>
	<h1>#root div태그 위쪽</h1>
	<div id="root">
		<div>

			<button class="button" @click="showRegisterModal=true">show
				register modal</button>
			<my-modal v-show="showRegisterModal" @close="showRegisterModal=false">
			Here is SLOT AREA </my-modal>
			<h1>KJWKJW</h1>
			</my-modal>
		</div>
	</div>

	<script src="https://cdnjs.cloudflare.com/ajax/libs/vue/2.3.4/vue.js"></script>
	<!--  <script src="resources/modal/js/main.js"></script>  -->
	<script type="text/javascript">

/* 
*	$emit은 속성찾는 녀석이다.
*	slot태그는 template태그와 태그 사이의 text를 가져오는 녀석이다.
*
*/
Vue.component('my-modal',{
	template:`
		<div class="modal is-active">
		<div class="modal-background"></div>
		<div class="modal-content">
			<!-- Any other Bulma elements you want  -->
			<div class="box">
			   <div style="display:table; margin-left:auto; margin-right:auto;">
               <span class="starR1">0.5</span>
               <span class="starR2" >1</span>
               <span class="starR1" >1.5</span>
               <span class="starR2">2</span>
               <span class="starR1" >2.5</span>
               <span class="starR2" >3</span>
               <span class="starR1">3.5</span>
               <span class="starR2">4</span>
               <span class="starR1" >4.5</span>
               <span class="starR2">5</span> </div>
               <hr>
			
			/* <slot></slot>
				<p class="image is-4by3">
		    	<!--<img :src="'/image/'+item.movie+'_'+item.title+'_'+item.director+'.jpg'" style="width:220px; height:330px"/> -->
		    </p> */
			</div>
				
			
		</div>
		<button class="modal-close" @click="$emit('close')"></button>	
	</div>
	`
})
new Vue({
	el: '#root',
	data:{
		showLoginModal:false,
		showRegisterModal:false
	}
})

var EventBus = new Vue();

</script>
</body>
</html>