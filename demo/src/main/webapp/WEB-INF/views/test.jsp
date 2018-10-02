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
<title>MIT - HOME</title>
<link rel="apple-touch-icon" sizes="76x76"
	href="/resources/assets/img/apple-icon.png">
<link rel="icon" type="image/png" sizes="96x96"
	href="/resources/assets/img/favicon.png">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />

<meta
	content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0'
	name='viewport' />
<meta name="viewport" content="width=device-width" />


<!-- Detail PopUP창을 위해 필요한 css이다. (MODAL관련 css ) -->
<link rel="stylesheet" href="/resources/demo/css/juwonmodal.css" />

<!-- 로딩에 필요  -->
<link
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css"
	rel="stylesheet">

<!-- CORE CSS-->

<link href="/resources/demo/css/style.css" type="text/css"
	rel="stylesheet" media="screen,projection">


<!-- //////// -->


<!-- Bootstrap core CSS     -->
<link href="/resources/assets/css/bootstrap.min.css" rel="stylesheet" />

<!--  Paper Dashboard core CSS    -->
<link href="/resources/assets/css/paper-dashboard.css" rel="stylesheet" />


<!--  CSS for Demo Purpose, don't include it in your project     -->
<link href="/resources/assets/css/demo.css" rel="stylesheet" />


<!--  Fonts and icons  -->
<link
	href="http://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css"
	rel="stylesheet">
<link href='https://fonts.googleapis.com/css?family=Muli:400,300'
	rel='stylesheet' type='text/css'>
<link href="/resources/assets/css/themify-icons.css" rel="stylesheet">

</head>

<style>
[v-cloak] {
	display: hidden;
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

body {
	background: #ccc;
}




/*-- RANKING  --*/
#ranking-slide {
	position: relative;
	width: 2000px;
	height: 1000px;
	margin: 50px 50px 100px 100px;
}

#ranking-slide>:not(img) {
	overflow: hidden;
	white-space: nowrap;
}

#ranking-slide>img {
	cursor: pointer;
	position: absolute;
	top: 50%;
	width: 45px;
	height: 60px;
	margin-top: -30px;
	border-radius: 5px;
	opacity: 0;
	-moz-transition: all 0.2s 0s ease;
	-webkit-transition: all 0.2s 0s ease;
	transition: all 0.2s 0s ease;
}

#ranking-slide:hover>img, #ranking-slide>img:hover {
	opacity: 1;
}

#ranking-slide>img:hover {
	background: #fff;
}

#ranking-slide>.prev {
	left: -45px;
	border-radius: 5px 0 0 5px;
}

#ranking-slide>.next {
	right: -45px;
	border-radius: 0 5px 5px 0;
}

[class*="trans0"] li {
	transition: all 0.8s 0s ease-in-out;
}

.trans01 li {
	transform: translateX(-1063px);
}

.trans02 li {
	transform: translateX(0);
}

#ranking-slide>img:before, #ranking-slide>img:after {
	content: "";
	position: absolute;
	left: 50%;
	display: block;
	width: 4px;
	height: 20px;
	background: #ef335f;
}

#ranking-slide>.prev:after, #ranking-slide>.next:before {
	-moz-transform: rotate(45deg);
	-ms-transform: rotate(45deg);
	-webkit-transform: rotate(45deg);
	transform: rotate(45deg);
}

#ranking-slide>.prev:before, #ranking-slide>.next:after {
	-moz-transform: rotate(-45deg);
	-ms-transform: rotate(-45deg);
	-webkit-transform: rotate(-45deg);
	transform: rotate(-45deg);
}

#ranking-slide>.prev:before, #ranking-slide>.next:before {
	top: 50%;
	margin: -4px 0 0 -4px;
	border-radius: 0 0 32% 32%;
}

#ranking-slide>.prev:after, #ranking-slide>.next:after {
	bottom: 50%;
	margin: 0 0 -4px -4px;
	border-radius: 32% 32% 0 0;
}

#ranking-slide li {
	display: inline-block;
	margin: 0 16px 0 0;
	letter-spacing: 0;
}

#ranking-slide li, #ranking-slide li>img {
	float: none;
	/* width: 162px;
	height: 162px; */
	width: 180px;
	height: 270px;
}

#ranking-slide li>img {
	cursor: pointer;
	position: relative;
	display: block;
	background: #efefef;
	border-radius: 5px;
	transition: all 0.2s 0s ease;
}

#ranking-slide li>img:hover {
	background: #f69;
}

#ranking-slide {
	/* height: 338px; */
	height: 500px;
	padding: 0;
}

#ranking-slide li:nth-child(n+2):nth-child(-n+5) {
	top: -280px;
}

#ranking-slide li:nth-child(6) {
	/* margin: 175px 16px 0 -712px; */
	margin: 230px 16px 0 -785px;	/* 이 구간이 6~9까지의 위치조정임. */
}

#ranking-slide li:nth-child(n+10):nth-child(-n+15) {
	top: -230px;
	left: 0;
}

#ranking-slide li:nth-child(n+7):nth-child(-n+9), #ranking-slide li:nth-child(12n+17),
	#ranking-slide li:nth-child(12n+18), #ranking-slide li:nth-child(12n+19),
	#ranking-slide li:nth-child(12n+20), #ranking-slide li:nth-child(12n+21)
	{
	margin: 175px 16px 0 0;
}

#ranking-slide li:nth-child(12n+22), #ranking-slide li:nth-child(12n+23),
	#ranking-slide li:nth-child(12n+24), #ranking-slide li:nth-child(12n+25),
	#ranking-slide li:nth-child(12n+26), #ranking-slide li:nth-child(12n+27)
	{
	top: -175px;
}

#ranking-slide li:nth-child(12n+16) {
	margin: 175px 16px 0 -1068px;
}

#ranking-slide li:nth-of-type(12n+4), #ranking-slide li:nth-of-type(12n+8)
	{
	clear: none;
}

#ranking-slide li:first-child, #ranking-slide li:first-child>img {
	/* width: 336px;
	height: 335px; */
	width: 400px;
	height: 550px;
	margin: 0 16px 0 0;
}

#ranking-slide {
	counter-reset: number;
}

#ranking-slide li {
	position: relative;
}

#ranking-slide li:before {
	content: counter(number);
	counter-increment: number;
	position: absolute;
	top: 7px;
	left: 7px;
	display: inline-block;
	width: 22px;
	height: 22px;
	line-height: 22px;
	color: #fff;
	background: #f69;
	font-size: 1.2rem;
	text-align: center;
	z-index: 1;
}

#ranking-slide  li:first-child:before {
	width: 25px;
	height: 25px;
	line-height: 25px;
	font-size: 1.5rem;
}

</style>


<body>
		<%@include file="header.jsp"%>

	<div id="vuejs" v-cloak>
	<center><h2>흥행 예측 차트</h2></center>
		<!-- Start Page Loading -->
		<div id="loader-wrapper">
			<div id="loader"></div>
			<div class="loader-section section-left"></div>
			<div class="loader-section section-right"></div>
		</div>
		<detail modal-class="media-manager-details" v-show="showDetailModal"
			@close="showDetailModal=false">
		<p>Here is SLOT AREA</p>
		</detail>
		<p></p><p></p><p></p><p></p><p></p><p></p>
		<p></p><p></p><p></p><p></p><p></p><p></p>

		
<center>
		<span id="ranking-slide">
			<ol style = "width:1400px">
				<li v-for="(item,index) in movieList" v-if="index < max">
					<img :src="'/default/'+item.fileName+'.jpg'"
					@click="handleImageDetails(item)" /> <!-- 이놈이 마우스올려놨을 때 흰색 배경 사이즈이다.  -->
				</li>
			</ol>
		</span>
</center>

	</div>
	</div>

	</div>


	<!--   Core JS Files. Extra: PerfectScrollbar + TouchPunch libraries inside jquery-ui.min.js   -->
	<script src="/resources/assets/js/jquery-1.10.2.js"
		type="text/javascript"></script>
	<script src="/resources/assets/js/jquery-ui.min.js"
		type="text/javascript"></script>
	<script src="/resources/assets/js/bootstrap.min.js"
		type="text/javascript"></script>

	<!-- Paper Dashboard PRO Core javascript and methods for Demo purpose -->
	<script src="/resources/assets/js/paper-dashboard.js"></script>



	<script src="https://cdnjs.cloudflare.com/ajax/libs/vue/2.3.4/vue.js"></script>



	<script>
var bus = new Vue();

const app = new Vue({
    el: "#vuejs",
    data: {
      movieList : [],
      max: 9,
      showDetailModal:false
      
    },  
    mounted: function(){
          <c:forEach var="vo" items="${detailList2}">   
          var tit = "${vo.title}";
          var dir = "${vo.director}";
           this.movieList = this.movieList.concat({
        	   movie:"${vo.movie}",
	           title:tit,
	           director:dir,
	           company:"${vo.company}",
	           country:"${vo.country}",
	           genre:"${vo.genre}",
	           grade:"${vo.grade}",
	           actor1:"${vo.actor1}",
	           actor2:"${vo.actor2}",
	           story:"${vo.story}",
	           r_date:"${vo.r_date}",
	           runningtime:"${vo.runningtime}",
	           fileName:"${vo.fileName}"
           });
        </c:forEach>
   },
   methods:{
      starColor(event) {
         $(event.target).parent().children('span').removeClass('on');
         $(event.target).addClass('on').prevAll('span').addClass('on');
         return false;
      },
      handleImageDetails(item) {
      	this.showDetailModal=true;
      	this.movieList.fileName=item.fileName;
    	this.movieList.title=item.title;
    	this.movieList.director=item.director;    	
    	this.movieList.country=item.country;
    	this.movieList.genre=item.genre;
    	this.movieList.grade=item.grade;
    	this.movieList.actor1=item.actor1;    	
    	this.movieList.story=item.story;
    	this.movieList.r_date=item.r_date;
    	this.movieList.runningtime=item.runningtime;
  	    bus.$emit('imageTransport', this.movieList);
      },
      scoring(event) {
         var val=$(event.target).html();
         var title= $(event.target).parent().parent().find('p > .movie-title').html();
         
         $.ajax({
            url: '/starScore',
            type: 'POST',
            data:{"title":title,"rating":val}
         });
      }
      
   },
   components:{
	   /* 'detail': child */
	   detail: {
	    	template: `
			<div class="modal is-active">
			  <div class="modal-background" style="bottom:0; left:0;position:absolute;right:0;top:0;background-color:rgba(10,10,10,.86)" @click="$emit('close')"></div>
			  <div class="modal-card" style="width:60%; height:80%">
			    <header class="modal-card-head">
			    <h2 style="color:787878;">{{title}}</h2>
			      <p class="modal-card-title"></p>
			      <button class="delete" aria-label="close" @click="$emit('close')"></button>
			    </header>
			   <!-- <section class="modal-card-body" style="width:50%; height:100%"> -->
			   <div class="modal-card-body" style="width:100%; height:100%;">
			      <!-- Content ... -->
				    <table style="width:90%;border:hidden;" valign="top" >
				    	<tr style="text-align:left;border:hidden">
					    	<td style="border:hidden;width:250px; height:350px;">
								<img style = "border: 5px solid lightgray; border-radius: 7px; -moz-border-radius: 7px;-khtml-border-radius: 7px;-webkit-border-radius: 7px;width: 220px; height: 330px;":src="'/default/'+fileName+'.jpg'"/>
							</td>
							<td style="border:hidden;">
								<p><strong> {{grade}}|</strong> {{title}} <hr></p>
								<p><strong>개봉 |</strong> {{r_date}}</p>
								<p><strong>상영 시간 |</strong> {{runningtime}} </p>
								<p><strong>장르 |</strong> {{genre}}</p>
								<p><strong>국가 |</strong> {{country}}</p>
								<p><strong>감독 |</strong> {{director}}</a></p>
								<p><strong>배우 |</strong> {{actor1}}</p>
							</td>
						</tr>
						<tr style="text-align:left;border:hidden">
							<td  colspan="2">
								<h3><strong>줄거리</strong></h3><hr>
	                            {{story}}
							</td>
						</tr>
						<tr style="text-align:left;border:hidden">
							<td>
								
							</td>
						</tr>
						
					</table>
				</div>
				 
			    <footer class="modal-card-foot">
			    </footer>
			  </div>
			</div>
			`
	    	,	
	         created : function() { // bus를 통해 이벤트가 호출 시 동작할 수 있도록 listener지정  		부모의 data에 접근하고싶다면 $on과 $emit 를 통해서 접근 가능하다!!
		        var self = this;
				bus.$on("imageTransport", function(list) { // 모든 user의 point를 합산한다. 
					self.fileName = list.fileName;		
				    self.title = list.title
					self.country=list.country;
					self.director = list.director;
					self.genre=list.genre;			
					self.grade = list.grade;
					self.actor1=list.actor1;
					self.story=list.story;
					self.r_date=list.r_date;
					self.runningtime=list.runningtime;
				});
	
			} 

	}
}
})
</script>
	<script>
var div = document.getElementById('ranking-slide');

function prev(){
	div.className = 'trans02';
}

function next(){
	div.className = 'trans01';
}


$(function() {
    var count = $('#rank-list li').length;
    var height = $('#rank-list li').height();

    function step(index) {
        $('#rank-list ol').delay(2000).animate({
            top: -height * index,
        }, 500, function() {
            step((index + 1) % count);
        });
    }

    step(1);
});

</script>

	<!--  로딩에 필요  -->

	<!-- jQuery Library -->
	<script type="text/javascript"
		src="/resources/demo/js/plugins/jquery-1.11.2.min.js"></script>
	<!--materialize js-->
	<script type="text/javascript" src="/resources/demo/js/materialize.js"></script>


	<!--  이거 없음 로딩 계속 지속됨  -->
	<!--plugins.js - Some Specific JS codes for Plugin Settings-->
	<script type="text/javascript" src="/resources/demo/js/plugins.js"></script>


</body>




</html>