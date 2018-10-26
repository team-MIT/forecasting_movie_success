<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@  taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c" %> <!-- 기본기능 -->
<%@  taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt" %> <!-- 포멧 기능 (형식지정)-->
<%@  taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn" %> <!-- 함수 기능 -->
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1.0, user-scalable=no">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="msapplication-tap-highlight" content="no">
  <meta name="description" content="Materialize is a Material Design Admin Template,It's modern, responsive and based on Material Design by Google. ">
  <meta name="keywords" content="materialize, admin template, dashboard template, flat admin template, responsive admin template,">
<title>Insert title here</title>

 <!-- Favicons-->
  <link rel="icon" href="/resources/demo/images/favicon/favicon-32x32.png" sizes="32x32">
  <!-- Favicons-->
  <link rel="apple-touch-icon-precomposed" href="/resources/demo/images/favicon/apple-touch-icon-152x152.png">
  <!-- For iPhone -->
  <meta name="msapplication-TileColor" content="#00bcd4">
  <meta name="msapplication-TileImage" content="/resources/demo/images/favicon/mstile-144x144.png">
  <!-- For Windows Phone -->


  <!-- CORE CSS-->
  
  <link href="/resources/demo/css/materialize.css" type="text/css" rel="stylesheet" media="screen,projection">
  <link href="/resources/demo/css/style.css" type="text/css" rel="stylesheet" media="screen,projection">
    <!-- Custome CSS-->    
    <link href="/resources/demo/css/custom/custom.css" type="text/css" rel="stylesheet" media="screen,projection">


  <!-- INCLUDED PLUGIN CSS ON THIS PAGE -->
  <link href="/resources/demo/js/plugins/prism/prism.css" type="text/css" rel="stylesheet" media="screen,projection">
  <link href="/resources/demo/js/plugins/perfect-scrollbar/perfect-scrollbar.css" type="text/css" rel="stylesheet" media="screen,projection">
  <link href="/resources/demo/js/plugins/chartist-js/chartist.min.css" type="text/css" rel="stylesheet" media="screen,projection">
  <link href="/resources/demo/js/plugins/magnific-popup/magnific-popup.css" type="text/css" rel="stylesheet" media="screen,projection">
  



<link href = "https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" rel="stylesheet">
  <link rel="apple-touch-icon" sizes="76x76" href="/resources/assets/img/apple-icon.png">
   <link rel="icon" type="image/png" sizes="96x96" href="/resources/assets/img/favicon.png">
   <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />

   <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' name='viewport' />
    <meta name="viewport" content="width=device-width" />


     <!-- 로딩에 필요  -->
    <link href = "https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" rel="stylesheet">

    <!-- CORE CSS-->
    <link href="resources/demo/css/materialize.css" type="text/css" rel="stylesheet" media="screen,projection">
    <link href="resources/demo/css/style.css" type="text/css" rel="stylesheet" media="screen,projection">


     <!-- //////// -->


     <!-- Bootstrap core CSS     -->
    <link href="resources/assets/css/bootstrap.min.css" rel="stylesheet" />

    <!--  Paper Dashboard core CSS    -->
    <link href="resources/assets/css/paper-dashboard.css" rel="stylesheet"/>


    <!--  CSS for Demo Purpose, don't include it in your project     -->
    <link href="resources/assets/css/demo.css" rel="stylesheet" />


    <!--  Fonts and icons     -->
    <link href="http://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" rel="stylesheet">
    <link href='https://fonts.googleapis.com/css?family=Muli:400,300' rel='stylesheet' type='text/css'>
    <link href="resources/assets/css/themify-icons.css" rel="stylesheet">
    
    
    <!-- Custome CSS-->    
  <!-- <link href="/resources/demo/css/custom/custom.css" type="text/css" rel="stylesheet" media="screen,projection"> -->
  <link href="resources/demo/css/plugins/media-hover-effects.css" type="text/css" rel="stylesheet" media="screen,projection">
    
<style>
[v-cloak] {
  display: none;
}

.mytable, tr, th, td {
  padding: 5px;
  border-collapse: collapse; 
  border:1px solid black;
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
<script src="https://code.jquery.com/jquery-3.2.1.min.js"> </script>

</head>
<body>
<%@include file="header.jsp"%>
<!-- <div id="app" v-cloak> -->
<!--        Start Page Loading -->
    <div id="loader-wrapper">
        <div id="loader"></div> 
        <div class="loader-section section-left"></div>
        <div class="loader-section section-right"></div>
    </div>
    
  
  
  
  <!-- ///////////////////////// -->
    <!-- START CONTENT -->
      <section id="content">

        <!--start container-->
        <div class="container">
          <div class="section">

<div id="vuejs" v-cloak>

            <p class="caption" ><h3><%=session.getAttribute("session_id") %> 님에게 추천하는 영화입니다</h3></p>
              <div class="divider"></div>
              
              <div class="masonry-gallery-wrapper">                
                <div class="popup-gallery">

                 <div class="gallary-sizer"></div>                
                   <div v-for="(a,index) in movieList" v-cloak >
                    <span>
                
                  <div class="gallary-item"><a :href="'/image/'+a.movie+'_'+a.title+'_'+a.director+'.jpg'" v-bind:title="a.title" v-bind:director="a.director" v-bind:rating="a.rating"
                   v-bind:genre="a.genre" v-bind:actor1="a.actor1" v-bind:country="a.country" v-bind:story="a.story" v-bind:r_date="a.r_date" v-bind:runningtime="a.runningtime" v-bind:vodNo="a.code" v-bind:rsvNo="a.code" ><img :src="'/image/'+a.movie+'_'+a.title+'_'+a.director+'.jpg'"/></a></div>

<!-- <div class="gallary-item"><a :href="'/image/'+a.movie+'_'+a.title+'_'+a.director+'.jpg'" v-bind:title="a.title" v-bind:director="a.director" v-bind:rating="a.rating" ><img :src="'/image/'+a.movie+'_'+a.title+'_'+a.director+'.jpg'"/></a></div> -->
                   
<!--                   <div class="gallary-item"><a href="/resources/demo/images/gallary/2.jpg" title="Winter Dance"><img src="/resources/demo/images/gallary/2.jpg"></a></div> -->
<!--                   <div class="gallary-item"><a href="/resources/demo/images/gallary/3.jpg" title="The Uninvited Guest"><img src="/resources/demo/images/gallary/3.jpg"></a></div> -->
<!--                   <div class="gallary-item"><a href="/resources/demo/images/gallary/4.jpg" title="Oh no, not again!"><img src="/resources/demo/images/gallary/4.jpg"></a></div> -->
<!--                   <div class="gallary-item"><a href="/resources/demo/images/gallary/5.jpg" title="Swan Lake"><img src="/resources/demo/images/gallary/5.jpg"></a></div> -->
<!--                   <div class="gallary-item"><a href="/resources/demo/images/gallary/6.jpg" title="The Shake"><img src="/resources/demo/images/gallary/6.jpg"></a></div> -->
<!--                   <div class="gallary-item"><a href="/resources/demo/images/gallary/7.jpg" title="Who's that, mommy?"><img src="/resources/demo/images/gallary/7.jpg"></a></div> -->
<!--                   <div class="gallary-item"><a href="/resources/demo/images/gallary/8.jpg" title="Who's that, mommy?"><img src="/resources/demo/images/gallary/8.jpg"></a></div> -->

                    </span>
                  </div>

                </div> 
             </div>
</div>

          </div> 
        </div>
        <!--end container-->
      </section>
      <!-- END CONTENT -->
  
<script src = "https://cdnjs.cloudflare.com/ajax/libs/vue/2.3.4/vue.js"></script>

<script>


  var app2 = new Vue ({
       el: "#vuejs",
       data: {
          movieList : []
       },
       mounted: function() {
            <c:forEach var="vo" items="${map.list2}"> 
            this.movieList = this.movieList.concat ({
                 movie:"${vo.movie}",
                title:"${vo.title}",
                director:"${vo.director}",
                rating : "${vo.rating}",
                genre : "${vo.genre}",
                actor1 : "${vo.actor1}",
                country : "${vo.country}",
                story : "${vo.story}",
                r_date : "${vo.r_date}",
                runningtime : "${vo.runningtime}",                
                code: "${vo.code}"
            });
            </c:forEach>
       }
     });
  
  
  </script>

<!--  로딩에 필요  -->
        
   <!-- jQuery Library -->
    <script type="text/javascript" src="/resources/demo/js/plugins/jquery-1.11.2.min.js"></script>
    <!--materialize js-->
    <script type="text/javascript" src="/resources/demo/js/materialize.js"></script>
   
   
  <!--  이거 없음 로딩 계속 지속됨  -->
  <!--plugins.js - Some Specific JS codes for Plugin Settings-->
    <script type="text/javascript" src="/resources/demo/js/plugins.js"></script>
    
    
    
    <!-- Toast Notification -->
    <script type="text/javascript">
    // Toast Notification
    $(window).load(function() {
        setTimeout(function() {
            Materialize.toast('<span>Hiya! I am a toast.</span>', 1500);
        }, 1500);
        setTimeout(function() {
            Materialize.toast('<span>You can swipe me too!</span>', 3000);
        }, 5000);
        setTimeout(function() {
            Materialize.toast('<span>You have new order.</span><a class="btn-flat yellow-text" href="#">Read<a>', 3000);
        }, 15000);
    });
    </script>
    
</body>

   <!--   Core JS Files. Extra: PerfectScrollbar + TouchPunch libraries inside jquery-ui.min.js   -->
   <script src="/resources/assets/js/jquery-1.10.2.js" type="text/javascript"></script>
   <script src="/resources/assets/js/jquery-ui.min.js" type="text/javascript"></script>
   <script src="/resources/assets/js/bootstrap.min.js" type="text/javascript"></script>

   <!--  Forms Validations Plugin -->
   <script src="/resources/assets/js/jquery.validate.min.js"></script>

   <!--  Plugin for Date Time Picker and Full Calendar Plugin-->
   <script src="/resources/assets/js/moment.min.js"></script>

   <!--  Date Time Picker Plugin is included in this js file -->
   <script src="/resources/assets/js/bootstrap-datetimepicker.js"></script>

   <!--  Select Picker Plugin -->
   <script src="/resources/assets/js/bootstrap-selectpicker.js"></script>

   <!--  Checkbox, Radio, Switch and Tags Input Plugins -->
   <script src="/resources/assets/js/bootstrap-checkbox-radio-switch-tags.js"></script>

   <!-- Circle Percentage-chart -->
   <script src="/resources/assets/js/jquery.easypiechart.min.js"></script>

   <!--  Charts Plugin -->
   <script src="/resources/assets/js/chartist.min.js"></script>

   <!--  Notifications Plugin    -->
   <script src="/resources/assets/js/bootstrap-notify.js"></script>

   <!-- Sweet Alert 2 plugin -->
   <script src="/resources/assets/js/sweetalert2.js"></script>

   <!-- Vector Map plugin -->
   <script src="/resources/assets/js/jquery-jvectormap.js"></script>

   <!--  Google Maps Plugin    -->
   <script src="https://maps.googleapis.com/maps/api/js"></script>

   <!-- Wizard Plugin    -->
   <script src="/resources/assets/js/jquery.bootstrap.wizard.min.js"></script>

   <!--  Bootstrap Table Plugin    -->
   <script src="/resources/assets/js/bootstrap-table.js"></script>

   <!--  Plugin for DataTables.net  -->
   <script src="/resources/assets/js/jquery.datatables.js"></script>

   <!--  Full Calendar Plugin    -->
   <script src="/resources/assets/js/fullcalendar.min.js"></script>

   <!-- Paper Dashboard PRO Core javascript and methods for Demo purpose -->
   <script src="/resources/assets/js/paper-dashboard.js"></script>

   <!-- Paper Dashboard PRO DEMO methods, don't include it in your project! -->
   <script src="/resources/assets/js/demo.js"></script>
   
     
    <!--materialize js-->
    <script type="text/javascript" src="/resources/demo/js/materialize.js"></script>
    <!--prism-->
    <script type="text/javascript" src="/resources/demo/js/plugins/prism/prism.js"></script>
    <!--scrollbar-->
    <script type="text/javascript" src="/resources/demo/js/plugins/perfect-scrollbar/perfect-scrollbar.min.js"></script>
    <!-- chartist -->
    <script type="text/javascript" src="/resources/demo/js/plugins/chartist-js/chartist.min.js"></script>   

    <!-- masonry -->
    <script src="/resources/demo/js/plugins/masonry.pkgd.min.js"></script>
    <!-- imagesloaded -->
    <script src="/resources/demo/js/plugins/imagesloaded.pkgd.min.js"></script>    
    <!-- magnific-popup -->
    <script type="text/javascript" src="/resources/demo/js/plugins/magnific-popup/jquery.magnific-popup.min.js"></script>   
    
    <!--plugins.js - Some Specific JS codes for Plugin Settings-->
    <script type="text/javascript" src="/resources/demo/js/plugins.js"></script>
    <!--custom-script.js - Add your own theme custom JS-->
    <script type="text/javascript" src="/resources/demo/js/custom-script.js"></script>

    <script type="text/javascript">
      /*
       * Masonry container for Gallery page
       */
      var $containerGallery = $(".masonry-gallery-wrapper");
      $containerGallery.imagesLoaded(function() {
        $containerGallery.masonry({
            itemSelector: '.gallary-item img',
           columnWidth: '.gallary-sizer',
           isFitWidth: true
        });
      });

      //popup-gallery
      $('.popup-gallery').magnificPopup({
         delegate: 'a',
         type: 'image',
         closeOnContentClick: true,    
         fixedContentPos: true,
         tLoading: 'Loading image #%curr%...',
         mainClass: 'mfp-no-margins mfp-with-zoom',
         gallery: {
          enabled: true,
          navigateByImgClick: true,
          preload: [0,1] // Will preload 0 - before current, and 1 after the current image
         },
         image: {
        	// verticalFit: true,
  			//markup: '<div class = "mfp-figure">' +
  			//		'<div class = "mfp-close"></div>' +
  			//		'<div class = "mfp-img"></div>' +
  			//		'<div class = "mfp-title"></div>' +
  			//		'<div class = "mfp-bottom-bar">' +
  			//		'<div class = "mfp-counter"></div>' +
  			//		'</div>' + '</div>',
        	  tError: '<a href="%url%">The image #%curr%</a> could not be loaded.',
          titleSrc: function(item) {
//              return item.el.attr('rating') + '<small>by Marsel Van Oosten</small>';                
                var str = item.el.attr('title');                                
                var ss = str.replace(/@/gi,":");
                var ss2 = ss.replace(/&/gi,"%"); //제목 
                var ra = item.el.attr('rating'); //평점
                var starscore = '';
                if(ra == 0.5){
                	starscore = '<span class="starR1 on">0.5</span><span class="starR2">1</span><span class="starR1">1.5</span><span class="starR2">2</span><span class="starR1">2.5</span><span class="starR2">3</span><span class="starR1">3.5</span><span class="starR2">4</span><span class="starR1">4.5</span><span class="starR2">5</span>';
                }
                else if(ra == 1){
                	starscore = '<span class="starR1 on">0.5</span><span class="starR2 on">1</span><span class="starR1">1.5</span><span class="starR2">2</span><span class="starR1">2.5</span><span class="starR2">3</span><span class="starR1">3.5</span><span class="starR2">4</span><span class="starR1">4.5</span><span class="starR2">5</span>';
                }

                else if(ra == 1.5){
                	starscore = '<span class="starR1 on">0.5</span><span class="starR2 on">1</span><span class="starR1 on">1.5</span><span class="starR2">2</span><span class="starR1">2.5</span><span class="starR2">3</span><span class="starR1">3.5</span><span class="starR2">4</span><span class="starR1">4.5</span><span class="starR2">5</span>';
                }
                else if(ra == 2){
                	starscore = '<span class="starR1 on">0.5</span><span class="starR2 on">1</span><span class="starR1 on">1.5</span><span class="starR2 on">2</span><span class="starR1">2.5</span><span class="starR2">3</span><span class="starR1">3.5</span><span class="starR2">4</span><span class="starR1">4.5</span><span class="starR2">5</span>';
                }
                else if(ra == 2.5){
                	starscore = '<span class="starR1 on">0.5</span><span class="starR2 on">1</span><span class="starR1 on">1.5</span><span class="starR2 on">2</span><span class="starR1 on">2.5</span><span class="starR2">3</span><span class="starR1">3.5</span><span class="starR2">4</span><span class="starR1">4.5</span><span class="starR2">5</span>';
                }
                else if(ra == 3){
                	starscore = '<span class="starR1 on">0.5</span><span class="starR2 on">1</span><span class="starR1 on">1.5</span><span class="starR2 on">2</span><span class="starR1 on">2.5</span><span class="starR2 on">3</span><span class="starR1">3.5</span><span class="starR2">4</span><span class="starR1">4.5</span><span class="starR2">5</span>';
                }
                else if(ra == 3.5){
                	starscore = '<span class="starR1 on">0.5</span><span class="starR2 on">1</span><span class="starR1 on">1.5</span><span class="starR2 on">2</span><span class="starR1 on">2.5</span><span class="starR2 on">3</span><span class="starR1 on">3.5</span><span class="starR2">4</span><span class="starR1">4.5</span><span class="starR2">5</span>';
                }
                else if(ra == 4){
                	starscore = '<span class="starR1 on">0.5</span><span class="starR2 on">1</span><span class="starR1 on">1.5</span><span class="starR2 on">2</span><span class="starR1 on">2.5</span><span class="starR2 on">3</span><span class="starR1 on">3.5</span><span class="starR2 on">4</span><span class="starR1">4.5</span><span class="starR2">5</span>';
                }
                else if(ra == 4.5){
                	starscore = '<span class="starR1 on">0.5</span><span class="starR2 on">1</span><span class="starR1 on">1.5</span><span class="starR2 on">2</span><span class="starR1 on">2.5</span><span class="starR2 on">3</span><span class="starR1 on">3.5</span><span class="starR2 on">4</span><span class="starR1 on">4.5</span><span class="starR2">5</span>';
                }
                else if(ra == 5){
                	starscore = '<span class="starR1 on">0.5</span><span class="starR2 on">1</span><span class="starR1 on">1.5</span><span class="starR2 on">2</span><span class="starR1 on">2.5</span><span class="starR2 on">3</span><span class="starR1 on">3.5</span><span class="starR2 on">4</span><span class="starR1 on">4.5</span><span class="starR2 on">5</span>';
                }
                var no = item.el.attr('vodNo');                
               return starscore+'<br><h3>'+ ss2+' </h3>'+'<p></p>'+ '<a href="http://nstore.naver.com/tvstore/detail.nhn?mcode='+no+'" target="_blank">VOD 구매</a><p></p>' +'감독 : '+ item.el.attr('director') +'<p></p>장르 : '+ item.el.attr('genre')+'<p></p>'+'배우 : '+ item.el.attr('actor1')
               +'<p></p>'+'국가 : '+ item.el.attr('country')+'<p></p>'+'개봉일 : '+ item.el.attr('r_date')+'<p></p>'+'상영 시간  : '+ item.el.attr('runningtime')
               +'<p></p>'+'줄거리 : '+ item.el.attr('story')
               +'<p> </p>'+'<p> </p>'+'<p> </p>'+'<p> </p>';
//                 +'<p></p>'+'VOD 구매 :'+no+'<p></p>'+'예매 하기 : '+ no +'<p></p>'+'<p></p>'+'<p></p>'+'<p></p>';
               
               
               //return '<h3>'+item.el.attr('ss')+'</h3>' +'<p></p>'+ item.el.attr('director') +'<p></p>'+'평점 : '+ item.el.attr('rating');
          },
         zoom: {
          enabled: true,
          duration: 300 // don't foget to change the duration also in CSS
         }
        
        }
      });
    
    </script>


</html>