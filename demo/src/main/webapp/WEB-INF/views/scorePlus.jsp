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
<title>MIT - 평가 더하기</title>

<!-- Detail PopUP창을 위해 필요한 css이다. (MODAL관련 css ) -->
<link rel="stylesheet" href="/resources/demo/css/juwonmodal.css" />



<link rel="apple-touch-icon" sizes="76x76"
	href="/resources/assets/img/apple-icon.png">
<link rel="icon" type="image/png" sizes="96x96"
	href="/resources/assets/img/favicon.png">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />

<meta
	content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0'
	name='viewport' />
<meta name="viewport" content="width=device-width" />



<!-- 로딩에 필요  -->
<link
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css"
	rel="stylesheet">

<!-- CORE CSS-->
<link href="/resources/demo/css/style.css" type="text/css"
	rel="stylesheet" media="screen,projection">



<!--  Fonts and icons     -->
<link href="/resources/assets/css/themify-icons.css" rel="stylesheet">
</head>

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

#snackbar {
    visibility: hidden; /* Hidden by default. Visible on click */
    min-width: 250px; /* Set a default minimum width */
    margin-left: -125px; /* Divide value of min-width by 2 */
    background-color: #AA7A55; /* Black background color */
    color: #fff; /* White text color */
    text-align: center; /* Centered text */
    border-radius: 2px; /* Rounded borders */
    padding: 16px; /* Padding */
    position: fixed; /* Sit on top of the screen */
    z-index: 1; /* Add a z-index if needed */
    left: 50%; /* Center the snackbar */
    top: 80px; /* 30px from the top */
}

/* Show the snackbar when clicking on a button (class added with JavaScript) */
#snackbar.show {
    visibility: visible; /* Show the snackbar */

/* Add animation: Take 0.5 seconds to fade in and out the snackbar. 
However, delay the fade out process for 2.5 seconds */
    -webkit-animation: fadein 0.5s, fadeout 0.5s 2.5s;
    animation: fadein 0.5s, fadeout 0.5s 2.5s;
}

/* Animations to fade the snackbar in and out */
@-webkit-keyframes fadein {
    from {top: 0; opacity: 0;} 
    to {top: 80px; opacity: 1;}
}

@keyframes fadein {
    from {top: 0; opacity: 0;}
    to {top: 80px; opacity: 1;}
}

@-webkit-keyframes fadeout {
    from {top: 80px; opacity: 1;} 
    to {top: 0; opacity: 0;}
}

@keyframes fadeout {
    from {top: 80px; opacity: 1;}
    to {top: 0; opacity: 0;}
}
</style>



<body>
	<%@include file="header.jsp"%>

	<!-- Start Page Loading -->
	<div id="loader-wrapper">
		<div id="loader"></div>
		<div class="loader-section section-left"></div>
		<div class="loader-section section-right"></div>
	</div>
	<div id="snackbar"><center> <p>저장되었습니다!</p>
	 <p>평가더하기가 끝나셨으면 우측 하단의 'finish'를 눌러주세요</p></center> </div>
		
	<p></p>
	
	<div class="vuejs" v-cloak>
		<detail modal-class="media-manager-details" v-show="showDetailModal"
			@close="showDetailModal=false">
		<p>Here is SLOT AREA</p>
		</detail>
		<%-- 	<div v-for="(item,index) in movieList" v-cloak>
			<div class="starRev" v-if="index < max">
				<span>
					<div class="col s12 m6 grid">
						<figure class="effect-zoe"> <img
							:src="'/image/'+item.movie+'_'+item.title+'_'+item.director+'.jpg'"
							style = " border-radius: 7px; width: 220px; height: 330px;"
							@click="handleImageDetails(item)" /> <figcaption
							style="width:220px; height:160px; background-color:#F2F2F2;">
						<!-- 이놈이 마우스올려놨을 때 흰색 배경 사이즈이다. -->
						<div
							style="display: table; margin-left: auto; margin-right: auto;">
							<span class="starR1" @mouseenter="starColor" @click="scoring">0.5</span>
							<span class="starR2" @mouseenter="starColor" @click="scoring">1</span>
							<span class="starR1" @mouseenter="starColor" @click="scoring">1.5</span>
							<span class="starR2" @mouseenter="starColor" @click="scoring">2</span>
							<span class="starR1" @mouseenter="starColor" @click="scoring">2.5</span>
							<span class="starR2" @mouseenter="starColor" @click="scoring">3</span>
							<span class="starR1" @mouseenter="starColor" @click="scoring">3.5</span>
							<span class="starR2" @mouseenter="starColor" @click="scoring">4</span>
							<span class="starR1" @mouseenter="starColor" @click="scoring">4.5</span>
							<span class="starR2" @mouseenter="starColor" @click="scoring">5</span>
						</div>
						<hr>
						<p style="font-size: 18px">
							<strong class="movie-title">{{item.title}}</strong>
						</p>
						</figcaption> </figure>
						<!-- <button class="waves-effect waves-light  btn" @click="showDetailModal=true">show
							register modal</button> -->
					</div>
				</span>
			</div>
		</div> --%>
		<div>
		<center><h3>각 영화에 대한 평가를 진행 해주세요</h3></center>
			<span>
				<div class="col s12 m12 grid">
					<figure class="effect-zoe starRev"
						v-for="(item,index) in movieList" v-if="index < max"
						style="min-width:230px;max-width:230px;"> <img
						:src="'/image/'+item.fileName+'.jpg'"
						style="border-radius: 7px; width: 220px; height: 330px;"
						@click="handleImageDetails(item)" /> <figcaption
						style="width:220px; height:160px; background-color:#F2F2F2;">
					<div style="display: table; margin-left: auto; margin-right: auto;">
						<span class="starR1" @mouseenter="starColor" @click="scoring">0.5</span>
						<span class="starR2" @mouseenter="starColor" @click="scoring">1</span>
						<span class="starR1" @mouseenter="starColor" @click="scoring">1.5</span>
						<span class="starR2" @mouseenter="starColor" @click="scoring">2</span>
						<span class="starR1" @mouseenter="starColor" @click="scoring">2.5</span>
						<span class="starR2" @mouseenter="starColor" @click="scoring">3</span>
						<span class="starR1" @mouseenter="starColor" @click="scoring">3.5</span>
						<span class="starR2" @mouseenter="starColor" @click="scoring">4</span>
						<span class="starR1" @mouseenter="starColor" @click="scoring">4.5</span>
						<span class="starR2" @mouseenter="starColor" @click="scoring">5</span>
					</div>
					<hr>
					<p style="font-size: 18px">
						<strong class="movie-title">{{item.title}}</strong>
					</p>
					</figcaption> </figure>
					<!-- <button class="waves-effect waves-light  btn" @click="showDetailModal=true">show
							register modal</button> -->
				</div>
			</span>
		</div>
		<div style="position: fixed; bottom: 30px; right: 40px">
			<!-- MODAL -->

			<!-- READMORE -->
			<a class="waves-effect waves-light  btn" @click='max=max+36'>READ
				MORE</a> <a class="waves-effect waves-light  btn" id="finish">
				finish </a>

		</div>
	</div>


	</div>
	</div>


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
<script type="text/javascript">

  $(document).ready(function() {
      $("#finish").click(function() {
          // 페이지 주소 변경(이동)
          location.href = "${pageContext.servletContext.contextPath}/startSpark/";
      });
  });
</script>

<script type="text/javascript">
var bus = new Vue();

const app2 =new Vue({
    el: ".vuejs",
    data: {
      movieList : [],
      max: 36,
      showDetailModal:false
    },  
     mounted: function() {
          <c:forEach var="vo" items="${detailList}">
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
    	this.movieList.movie=item.movie;
    	this.movieList.title=item.title;
    	this.movieList.director=item.director;
    	this.movieList.company=item.company;
    	this.movieList.country=item.country;
    	this.movieList.genre=item.genre;
    	this.movieList.grade=item.grade;
    	this.movieList.actor1=item.actor1;
    	this.movieList.actor2=item.actor2;
    	this.movieList.story=item.story;
    	this.movieList.r_date=item.r_date;
    	this.movieList.runningtime=item.runningtime;
    	this.movieList.fileName=item.fileName;
	    bus.$emit('imageTransport', this.movieList);
		
	   // this.$emit('custom-event-aaa', item);
	      
	    /*
	    	sender() {
            EventBus.$emit('message', this.text);	// "message"라는 이벤트를 시작한다. 
        },
        onReceive(text) {
            this.receiveText = text;
        }
	    */
    	
      }
      ,scoring(event) {
         var val=$(event.target).html();
         var title= $(event.target).parent().parent().find('p > .movie-title').html();
         
         $.ajax({
            url: '/starScore',
            type: 'POST',
            data:{"title":title,"rating":val}
         });
         
         var x = document.getElementById("snackbar");

         // Add the "show" class to DIV
         x.className = "show";

         // After 3 seconds, remove the show class from DIV
         setTimeout(function(){ x.className = x.className.replace("show", ""); }, 3000);
      
      }
      
   },
   components:{
	   /* 'detail': child */
	   detail: {
	    	template: `
			<div class="modal is-active">
			  <div class="modal-background"  @click="$emit('close')"></div>
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
								<img style = "border: 5px solid lightgray; border-radius: 7px; -moz-border-radius: 7px;-khtml-border-radius: 7px;-webkit-border-radius: 7px;width: 220px; height: 330px;":src="'/image/'+fileName+'.jpg'"  @click="handleImageDetails(item)" />
							</td>
							<td style="border:hidden;">
								<p><span class="age12"><strong> {{grade}} |</strong> {{title}} <hr></p>
								<p><strong>개봉 |</strong> {{r_date}} </p>
								<p><strong>상영 시간 |</strong> {{runningtime}} </p>
								<p><strong>장르 |</strong> {{genre}} </p>
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
					<!--</section> 
					
					
					
					-->
				</div>
				  <!--
				  <div class="moviebig">
					<p class="mobiglf"><img id="imgMoviePhoster" src="//image.maxmovie.com/movieinfo/image/poster/movie/Max2017AntMan4.jpg" onerror="javascript:isImg('imgMoviePhoster');" alt="앤트맨과 와스프" width="209" height="300" onclick="javascript:void(viewBigPoster());" style="cursor:pointer;"></p>
					<div class="mobigrf">
						<p class="mobtit"><span class="age12">12</span>앤트맨과 와스프<br><strong>Ant-Man and the Wasp</strong></p>
						<p class="vmstar"><span><em style="width:87.5%"></em></span> <strong>8.75</strong> <a href="movie_info_point.asp?m_id=M000104313&amp;tab=4"><img src="/img/movie_new/btn_subm.gif" alt="평가하기"></a></p> 
						<p class="mdate">개봉 2018년 07월 04일 <span>|</span> 118분 <span>|</span> 액션, SF <span>|</span> 미국 </p>
						
						<p class="mdir"><strong>감독</strong> <a href="movie_actor_info.asp?m_id=M000104313&amp;p_id=P000010328">페이튼 리드</a></p>
						<p class="mdiract"><strong>배우</strong> <a href="movie_actor_info.asp?m_id=M000104313&amp;p_id=P000033155">폴 러드</a> , <a href="movie_actor_info.asp?m_id=M000104313&amp;p_id=P000072052">에반젤린 릴리</a> , <a href="movie_actor_info.asp?m_id=M000104313&amp;p_id=P000001225">미셸 파이퍼</a> , <a href="movie_actor_info.asp?m_id=M000104313&amp;p_id=P000001180">마이클 더글라스</a> <a href="movie_info_face.asp?tab=2&amp;m_id=M000104313" class="mdmore">더보기</a></p>
						<p><span><a href="javascript:facebookShare('http://movie.nate.com/movie_new/movie_info_movie.asp?m_id=M000104313');"><img src="../img/nate_movie/bl_nm_facebook.png" alt="페이스북"></a><a href="javascript:twitterShare('앤트맨과 와스프', 'http://movie.nate.com/movie_new/movie_info_movie.asp?m_id=M000104313');"><img src="../img/nate_movie/bl_nm_twitter.png" alt="트위터"></a>
						
						</span></p><p class="movbt"><a href="/reserve/reserve_01.asp?firstStep=movie&amp;m_id=M000104313"><img src="/img/movie_new/btn_mreserve_b.gif" alt="예매하기"></a></p>
					</div>
				</div>
				  -->
				
	 		   	 <!--<iframe width="100%" height="100%" src="http://movie.nate.com/movie_new/movie_info_movie.asp?m_id=M000104313" name="test" id="test" frameborder="0" scrolling="yes" align="left" longdesc="출처 : [네이트:영화]">이 브라우저는 iframe을 지원 X </iframe> -->
	 		   	 
			    <footer class="modal-card-foot"><center>
			    </footer>
			  </div>
			</div>
			`
	    	,	
	         created : function() { // bus를 통해 이벤트가 호출 시 동작할 수 있도록 listener지정  		부모의 data에 접근하고싶다면 $on과 $emit 를 통해서 접근 가능하다!!
		        var self = this;
				bus.$on("imageTransport", function(list) { // 모든 user의 point를 합산한다. 
				self.movie=list.movie;
				self.title=list.title;
				self.director=list.director;		//alert를 통해서 진행순서를 보면 처음에 handleImageDetails(item) 호출되고 emit를 통해서 $on으로 간
				self.company=list.company;
				self.country=list.country;
				self.genre=list.genre;
				self.grade=list.grade;
				self.actor1=list.actor1;
				self.actor2=list.actor2;
				self.story=list.story;
				self.r_date=list.r_date;
				self.runningtime=list.runningtime;
				self.fileName=list.fileName;
				});
	
			}, 
			methods:{
				starColor2(event){
			         $(event.target).parent().children('span').removeClass('on');
			         $(event.target).addClass('on').prevAll('span').addClass('on');
			         return false;
			      }
			      ,scoring2(event){
			         var val=$(event.target).html();
			         var title= $(event.target).parent().parent().find('header > p').html();
			         
			         $.ajax({
			            url: '/starScore',
			            type: 'POST',
			            data:{"title":title,"rating":val}
			         });
			      }
				
			},
			
	}
}
})
 
/*

전역 컴포넌트를 등록하려면, Vue.component(tagName, options)를 사용한다.
지역 컴포넌트를 등록하려면, 옵션객체 내에 components 아래에 선언해준다.


부모가 값을 전달해줄 때는,

Vue와 관계없는 정적인 값인 경우
<car name="안녕하세요"></car>

Vue의 모델값인 경우,
<car :name="여기에 뷰 모델명을 지정"></car>

로 설정해준다.

그 값을 컴포넌트가 부모로부터 받기 위해서는 props 배열로 선언해주고,
props: ['변수명1', '변수명2', ...]

이렇게 선언해주어야만 값으로 전달받게 된다.




자식 컴포넌트와의 통신을 하기 위한 방법 중 하나로 이벤트를 사용할 수 있다. 자식 요소로부터 오는 이벤트를 받기 위해 v-on:이벤트명="이벤트핸들러" 를 선언한다. 여기에서 선언한 이벤트명으로 자식 요소에서 this.$emit('이벤트명', ...파라메터들)로 부모에게 알려줄 수 있다.

부모 자식간의 이벤트를 통한 커뮤니케이션은 사실 vuex 등을 사용해서 단방향 구조를 구성하면 쓸일이 많지 않지만, 재사용을 위한 플러그인 모듈을 만들때는 유용하다.



beforeCreate
인스턴스가 방금 초기화 된 후 데이터 관찰 및 이벤트 / 감시자 설정 전에 동기적으로 호출 됩니다.

created
인스턴스가 작성된 후 동기적으로 호출됩니다. 이 단계에서 인스턴스는 데이터 처리, 계산된 속성, 메서드, 감시/이벤트 콜백 등과 같은 옵션 처리를 완료합니다. 그러나 마운트가 시작되지 않았으므로 $el 속성을 아직 사용할 수 없습니다.

beforeMount
마운트가 시작되기 바로 전에 호출됩니다. render 함수가 처음으로 호출 됩니다.
이 훅은 서버측 렌더링 중 호출되지 않습니다

mounted
el이 새로 생성된 vm.$el로 대체된 인스턴스가 마운트 된 직후 호출됩니다. 루트 인스턴스가 문서 내의 엘리먼트에 마운트 되어 있으면, mounted가 호출 될 때 vm.$el도 문서 안에 있게 됩니다.
이 훅은 서버측 렌더링 중 호출되지 않습니다

beforeUpdate
가상 DOM이 다시 렌더링되고 패치 전 데이터가 변경되면 호출됩니다.
이 훅에서 더 많은 상태 변경을 수행할 수 있으며 추가로 재 렌더링을 트리거하지 않습니다.
이 훅은 서버측 렌더링 중 호출되지 않습니다

updated
데이터 변경 후 호출되어 가상 DOM이 다시 렌더링되고 패치 됩니다.
이 훅이 호출되면 엘리먼트의 DOM이 업데이트 된 상태가 되어 이 훅에서 DOM 종속적인 연산을 할 수 있습니다. 그러나 대부분의 경우 무한루프가 발생할 수 있으므로 훅에서 상태를 변경하면 안됩니다. 상태 변화에 반응하기 위해서 계산된 속성 또는 [감시자(#watch)를 사용하는 것이 더 좋습니다.
이 훅은 서버측 렌더링 중 호출되지 않습니다

activated
keep-alive 인 컴포넌트가 활성화 될 때 호출됩니다.
이 훅은 서버측 렌더링 중 호출되지 않습니다

deactivated
keep-alive인 컴포넌트가 비활성화 될 때 호출됩니다.
이 훅은 서버측 렌더링 중 호출되지 않습니다

beforeDestroy
Vue 인스턴스가 제거되기 전에 호출됩니다. 이 단계에서 인스턴스는 아직 완벽하게 작동합니다.
이 훅은 서버측 렌더링 중 호출되지 않습니다

destroyed
Vue 인스턴스가 제거된 후 호출됩니다. 이 훅이 호출되면 Vue 인스턴스의 모든 디렉티브가 바인딩 해제 되고 모든 이벤트 리스너가 제거되며 모든 하위 Vue 인스턴스도 삭제됩니다.
이 훅은 서버측 렌더링 중 호출되지 않습니다

*/
 

</script>

<!--  여기서 내가 추가해준 것은 .css 링크걸어주는 태그와 juwonmodal.css의 수정과 component의 추가 및 component template 태그 추가  -->


</html>
