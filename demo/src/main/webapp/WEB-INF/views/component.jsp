<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet" href="/resources/demo/css/juwonmodal.css" />

</head>
<body>


	<!DOCTYPE html>
<html>

<head>



<style>
.mc {
	border: 0px solid #000;
	padding-bottom: 20px
}

span {
	border: 1px solid #000;
	float: left;
	margin-right: 100px;
	padding: 50px;
}

div {
	padding-bottom: 10px
}
</style>



</head>

<body>



	<div id="mc"></div>



	<div id="bank"></div>



	<!-- mcComponent -->

	<template id="mcComponent">

	<div class='mc'>

		<select v-model='select'>

			<option>1</option>

			<option>2</option>

		</select> {{user}} : {{result}}

		<!-- v-on:click => 자신 component의 sendtobank 메서드를 호출한다. -->

		<button v-on:click='sendtobank'>send to bank</button>

		<br> <br>



		<!-- v-on:send => $.emit('send') 이벤트가 발생하면, parent component의 checkresult 메서드가 호출된다 -->

		<!-- v-bind:mypoint => parent data에 있는 point 변수 값을 child component가 사용하기 위해 mypoint라는 속성(props)에 담는다 -->

		<user-component v-on:send='checkresult' v-bind:mypoint='point'></user-component>

		<user-component v-on:send='checkresult' v-bind:mypoint='point'></user-component>



		<hr />

	</div>

	</template>



	<!-- userComponent -->

	<template id="userComponent">

	<div>

		<input type='text' v-model='user'><input type='text'
			v-model='num'>

		<!-- button click이벤트 발생 시 dosend method 호출 -->

		<button v-on:click='doSend'>send</button>

		<!-- mypoint 객체안에 해당 user이름의 속성 정보를 출력한다 -->

		<br> point : [ {{mypoint[user]}} ]

	</div>

	</template>





	<script src="/js/vue.js"></script>

	<script>
		// 서로 다른 component간에 데이터 전달하기 위해 사용 

		var bus = new Vue();

		// 사용자 component (child component) 

		Vue.component("userComponent", {

			template : "#userComponent",

			props : [ "mypoint" ], // parent component에 있는 point 변수를 사용하기 위해 선언 

			data : function() {

				return {

					user : "",

					num : 0

				};

			},

			methods : {

				doSend : function() {

					this.$emit("send", { // parent component의 checkresult method를 호출하도록 이벤트 발생 

						user : this.user,

						num : this.num

					});

				}

			}

		});

		// MC Component(parent) 

		new Vue({

			el : "#mc",

			template : "#mcComponent",

			data : function() {

				return {

					user : "",

					select : 0,

					result : false,

					point : {

						user1 : 0,

						user2 : 0

					}

				};

			},

			methods : {

				checkresult : function(obj) { // mc가 지정한 값과 동일한 경우, 해당 user에게 point 100 지급 

					this.user = obj.user;

					this.result = (obj.num === (this.select));

					if (this.result) {

						this.point[obj.user] += 100;

					}

				},

				sendtobank : function() { // user들이 모은 point를 bank에 전달하여 합산 

					bus.$emit("calc_total_point", this.point);

				}

			}

		});

		// bank Component (other component) 

		new Vue({

			el : "#bank",

			template : "<div> total point : {{total_point}} </div>",

			data : function() {

				return {

					total_point : 0

				};

			},

			created : function() { // bus를 통해 이벤트가 호출 시 동작할 수 있도록 listener지정  

				var self = this;

				bus.$on("calc_total_point", function(points) { // 모든 user의 point를 합산한다. 

					for ( var key in points) {

						self.total_point += points[key];

					}

				});

			}

		});
	</script>




</body>
</html>
