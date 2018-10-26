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
   <link rel="apple-touch-icon" sizes="76x76" href="/resources/assets/img/apple-icon.png">
   <link rel="icon" type="image/png" sizes="96x96" href="/resources/assets/img/favicon.png">
   <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />

   <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' name='viewport' />
    <meta name="viewport" content="width=device-width" />


     <!-- 로딩에 필요  -->
<link href = "https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" rel="stylesheet">

    <!-- CORE CSS-->
    <link href="/resources/demo/css/materialize.css" type="text/css" rel="stylesheet" media="screen,projection">
    <link href="/resources/demo/css/style.css" type="text/css" rel="stylesheet" media="screen,projection">


     <!-- //////// -->


     <!-- Bootstrap core CSS     -->
    <link href="/resources/assets/css/bootstrap.min.css" rel="stylesheet" />

    <!--  Paper Dashboard core CSS    -->
    <link href="/resources/assets/css/paper-dashboard.css" rel="stylesheet"/>


    <!--  CSS for Demo Purpose, don't include it in your project     -->
    <link href="/resources/assets/css/demo.css" rel="stylesheet" />


    <!--  Fonts and icons     -->
    <link href="http://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" rel="stylesheet">
    <link href='https://fonts.googleapis.com/css?family=Muli:400,300' rel='stylesheet' type='text/css'>
    <link href="/resources/assets/css/themify-icons.css" rel="stylesheet">
</head>

<body>
<%@include file="header.jsp"%>
       
       <!-- Start Page Loading -->
    <div id="loader-wrapper">
        <div id="loader"></div> 
        <div class="loader-section section-left"></div>
        <div class="loader-section section-right"></div>
    </div>
       
       
       
           <div class="content">
               <div class="container-fluid">
                   <div class="row">
                   
                   <!-- 1 -->
                   <div id="genre" v-cloak>
                       <div class="col-md-12" >
                           <div class="card">
                               <div class="header">
                                   <h4 class="title">선호 장르</h4>
                                   
                               </div>
                               <div class="content table-responsive table-full-width">
                                   <table class="table">
                                       <thead>
                                           <tr>
                                               <th class="text-center">순위</th>
                                               <th>장르</th>
                                               <th>편수</th>
                                               <th>점수</th>
                                               
                                           </tr>
                                       </thead>
                                       <tbody>
                                       
                                           <tr v-for = "(k,index) in items">
                                               <td class="text-center">{{index+1}}</td>
                                               <td>{{k.genre}}</td>
                                               <td>{{k.count}}</td>
                                               <td>{{k.avg}}</td>                                              
                                           </tr>
                                                                                                                                 
                                       </tbody>
                                   </table>
                               </div>
                           </div>
                       </div>
                      </div>
                       
                      
                      
                      <!-- 2 -->
                   <div id="actor" v-cloak>
                       <div class="col-md-12" >
                           <div class="card">
                               <div class="header">
                                   <h4 class="title">선호 배우</h4>
                                   
                               </div>
                               <div class="content table-responsive table-full-width">
                                   <table class="table">
                                       <thead>
                                           <tr>
                                               <th class="text-center">순위</th>
                                               <th>배우</th>
                                               <th>편수</th>
                                               <th>점수</th>
                                               
                                           </tr>
                                       </thead>
                                       <tbody>
                                       
                                           <tr v-for = "(k,index) in items">
                                               <td class="text-center">{{index+1}}</td>
                                               <td>{{k.actor}}</td>
                                               <td>{{k.count}}</td>
                                               <td>{{k.avg}}</td>                                            
                                           </tr>
                                                                                                                                 
                                       </tbody>
                                   </table>
                               </div>
                           </div>
                       </div>
                      </div>
                      
                      
                      
                      <!-- 3 -->
                   <div id="director" v-cloak>
                       <div class="col-md-12" >
                           <div class="card">
                               <div class="header">
                                   <h4 class="title">선호 감독</h4>
                                   
                               </div>
                               <div class="content table-responsive table-full-width">
                                   <table class="table">
                                       <thead>
                                           <tr>
                                               <th class="text-center">순위</th>
                                               <th>감독</th>
                                               <th>편수</th>
                                               <th>점수</th>
                                               
                                           </tr>
                                       </thead>
                                       <tbody>
                                       
                                           <tr v-for = "(k,index) in items">
                                               <td class="text-center">{{index+1}}</td>
                                               <td>{{k.director}}</td>
                                               <td>{{k.count}}</td>
                                               <td>{{k.avg}}</td>                                          
                                           </tr>
                                                                                                                                 
                                       </tbody>
                                   </table>
                               </div>
                           </div>
                       </div>
                      </div>
                      
                      
                      
                      
                      <!-- 4 -->
                   <div id="country" v-cloak>
                       <div class="col-md-12" >
                           <div class="card">
                               <div class="header">
                                   <h4 class="title">선호 국가</h4>
                                   
                               </div>
                               <div class="content table-responsive table-full-width">
                                   <table class="table">
                                       <thead>
                                           <tr>
                                               <th class="text-center">순위</th>
                                               <th>국가</th>
                                               <th>편수</th>
                                               <th>점수</th>
                                               
                                           </tr>
                                       </thead>
                                       <tbody>
                                       
                                           <tr v-for = "(k,index) in items">
                                               <td class="text-center">{{index+1}}</td>
                                               <td>{{k.country}}</td>
                                               <td>{{k.count}}</td>
                                               <td>{{k.avg}}</td>                                              
                                           </tr>
                                                                                                                                 
                                       </tbody>
                                   </table>
                               </div>
                           </div>
                       </div>
                      </div>
                      
                      <!--  5  -->
                      <div id="country" v-cloak>
                       <div class="col-md-12" >
                           <div class="card">
                               <div class="header">
                                   <h4 class="title">선호 태그 </h4>
                                   
                               </div>
                               <div class="content table-responsive table-full-width">
                                  <img src="/wordcloud/wordcloud_${map.session_id}.png" alt=""/>
                               </div>
                           </div>
                       </div>
                      </div>
                      
                      <!-- 5 end -->
                      
       
                       
                       <!--  //////////////////////////////////////////////////// -->
                       
                       
                       
                       
                   </div>
                
               </div>
           </div>
           
           

<!--            <footer class="footer"> -->
<!--                <div class="container-fluid"> -->
<!--                    <nav class="pull-left"> -->
<!--                        <ul> -->
<!--                            <li> -->
<!--                                <a href="http://www.creative-tim.com"> -->
<!--                                    Creative Tim -->
<!--                                </a> -->
<!--                            </li> -->
<!--                            <li> -->
<!--                                <a href="http://blog.creative-tim.com"> -->
<!--                                   Blog -->
<!--                                </a> -->
<!--                            </li> -->
<!--                            <li> -->
<!--                                <a href="http://www.creative-tim.com/license"> -->
<!--                                    Licenses -->
<!--                                </a> -->
<!--                            </li> -->
<!--                        </ul> -->
<!--                    </nav> -->
<!--                <div class="copyright pull-right"> -->
<!--                        &copy; <script>document.write(new Date().getFullYear())</script>, made with <i class="fa fa-heart heart"></i> by <a href="http://www.creative-tim.com">Creative Tim</a> -->
<!--                    </div> -->
<!--                </div> -->
<!--            </footer> -->
           
       
   </div>
   
   
   <script src = "https://cdnjs.cloudflare.com/ajax/libs/vue/2.3.4/vue.js"></script>

<script>

  var genre = new Vue ({
    el: "#genre",
    data: {
      items : []
    },
    mounted: function() {
         <c:forEach var="vo" items="${map.genrelist}">
         this.items = this.items.concat ({
            id : "${vo.id}",
           genre : "${vo.genre}",
            count : "${vo.count}",
            avg : "${vo.avg}"
         });
         </c:forEach>
    }
  });
  
  var actor = new Vue ({
       el: "#actor",
       data: {
         items : []
       },
       mounted: function() {
            <c:forEach var="vo" items="${map.actorlist}">
            this.items = this.items.concat ({
               id : "${vo.id}",
               actor : "${vo.actor}",
               count : "${vo.count}",
               avg : "${vo.avg}"
            });
            </c:forEach>
       }
     });
  
  var director = new Vue ({
       el: "#director",
       data: {
         items : []
       },
       mounted: function() {
            <c:forEach var="vo" items="${map.directorlist}">
            this.items = this.items.concat ({
               id : "${vo.id}",
               director : "${vo.director}",
               count : "${vo.count}",
               avg : "${vo.avg}"
            });
            </c:forEach>
       }
     });
  
  var country = new Vue ({
       el: "#country",
       data: {
         items : []
       },
       mounted: function() {
            <c:forEach var="vo" items="${map.countrylist}">
            this.items = this.items.concat ({
               id : "${vo.id}",
               country : "${vo.country}",
               count : "${vo.count}",
               avg : "${vo.avg}"
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
    
  
<!-- ///////// -->
   
   
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
   
   
   

</html>