<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
	<meta charset="UTF-8" />
	<link rel="apple-touch-icon" sizes="76x76" href="/resources/assets/img/apple-icon.png">
	<link rel="icon" type="image/png" sizes="96x96" href="/resources/assets/img/favicon.png">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />

	<title>MIT-Movie ForeCast</title>

	<meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' name='viewport' />
    <meta name="viewport" content="width=device-width" />


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
    <nav class="navbar navbar-transparent navbar-absolute">
        <div class="container">
            <div class="navbar-header">
                <a class="navbar-brand" href="/test">MIT</a>
            </div>
        </div>
    </nav>

    <div class="wrapper wrapper-full-page">
        <div class="full-page login-page" data-color="" data-image="/resources/assets/img/background/background-2.jpg">
        <!--   you can change the color of the filter page using: data-color="blue | azure | green | orange | red | purple" -->
            <div class="content">
                <div class="container">
                    <div class="row">
                        <div class="col-md-4 col-sm-6 col-md-offset-4 col-sm-offset-3">
                            <form action="/joinPost" method="post">
                                <div class="card" data-background="color" data-color="blue">
                                    <div class="header">
                                        <h3 class="title">SIGN UP</h3>
                                    </div>
                                    <div class="content">
                                        <div class="form-group">
                                            <label>I D</label>
                                            <input type="text" name = "id" placeholder="Id" class="form-control input-no-border">
                                        </div>
                                        <div class="form-group">
                                            <label>Password</label>
                                            <input type="password" name = "pw" placeholder="Password" class="form-control input-no-border">
                                        </div>
                                        <div class="form-group">
                                            <label>Password-Confirm</label>
                                            <input type="password" name = "pwConfirm" placeholder="Password-Confirm" class="form-control input-no-border">
                                        </div>
                                    </div>
                                    <div class="footer text-center">
                                        <button type="submit" class="btn btn-fill btn-wd "> SIGN UP</button>
                                        <div class="forgot">
                                            <a href="/login"> BACK </a>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

        	<footer class="footer footer-transparent">
                <div class="container">
                    <div class="copyright text-center">
                    	&copy; <script>document.write(new Date().getFullYear())</script>.07.20, made with <i class="fa fa-heart heart"></i>KMS KJW YTW YMS LYB<i class="fa fa-heart heart"></i> by <a href="https://github.com/team-MIT/forecasting_movie_success">MIT - Project Member Site(Git)</a>
                	</div>
                </div>
            </footer>
        </div>
    </div>
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

	<script type="text/javascript">
        $().ready(function(){
            demo.checkFullPageBackgroundImage();

            setTimeout(function(){
                // after 1000 ms we add the class animated to the login/register card
                $('.card').removeClass('card-hidden');
            }, 700)
        });
	</script>

</html>
