<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>SUMMER 그룹 웨어</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="shortcuticon"
	href="${pageContext.request.contextPath}/resources/img/favicon.png"
	type="image/x-icon">
<link rel="icon"
	href="${pageContext.request.contextPath}/resources/img/favicon.png"
	type="image/x-icon">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<style>
@import
	url("https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css")
	;

* {
	box-sizing: border-box;
}

body {
	font-family: "Montserrat", sans-serif;
	margin: 0;
	padding: 0;
}

.wrapper {
	width: 100%;
	height: 100vh;
	display: flex;
	justify-content: center;
	align-items: center;
	background: white;
/* 	background: #ebecf0; */
	overflow: hidden;
}

.container {
	border-radius: 10px;
	/* box-shadow: -5px -5px 10px #fff, 5px 5px 10px #babebc; */
	position: absolute;
	width: 768px;
	min-height: 480px;
	overflow: hidden;
}

form {
	/* background: #ebecf0; */
	border: solid 1px black;
	display: flex;
	flex-direction: column;
	padding: 0 50px;
	height: 84%;
	justify-content: center;
	align-items: center;
	border-radius: 15px;
}

form input {
	background: #eee;
	padding: 16px;
	margin: 8px 0;
	width: 85%;
	border: 0;
	outline: none;
	border-radius: 20px;
	box-shadow: inset 7px 2px 10px #babebc, inset -5px -5px 12px #fff;
}

button {
	border-radius: 22px;
    border: none;
    outline: none;
    font-size: 12px;
    font-weight: bold;
    padding: 15px 45px;
    margin: 14px;
    letter-spacing: 1px;
    text-transform: uppercase;
    cursor: pointer;
    transition: transform 80ms ease-in;
}

.form_btn {
	box-shadow: -5px -5px 10px #fff, 5px 5px 8px #babebc;
}

.form_btn:active {
	box-shadow: inset 1px 1px 2px #babebc, inset -1px -1px 2px #fff;
}

.overlay_btn {
	/* background-color: #ff4b2b; */
	background-color: black;
	color: #fff;
	box-shadow: -1px -2px 10px white, 1px 2px 8px;
}

.sign-in-container {
	position: absolute;
	left: 0;
	width: 50%;
	height: 100%;
	transition: all 0.5s;
}

.sign-up-container {
	position: absolute;
	left: 0;
	width: 50%;
	height: 100%;
	opacity: 0;
	transition: all 0.5s;
}

.overlay-left {
	display: flex;
	flex-direction: column;
	padding: 0 50px;
	justify-content: center;
	align-items: center;
	position: absolute;
	right: 0;
	width: 50%;
	height: 100%;
	opacity: 0;
	background-color: black;
	/*  background-color: #ff4b2b; */
	color: #fff;
	transition: all 0.5s;
}

.overlay-right {
	display: flex;
	flex-direction: column;
	padding: 0 50px;
	justify-content: center;
	align-items: center;
	position: absolute;
	right: 0;
	width: 50%;
	height: 84%;
	/* background-color: #ff4b2b; */
	background-color: black;
	color: #fff;
	transition: all 0.5s;
	border-radius: 15px;
}

.container.right-panel-active .sign-in-container {
	transform: translateX(100%);
	opacity: 0;
}

.container.right-panel-active .sign-up-container {
	transform: translateX(100%);
	opacity: 1;
	z-index: 2;
}

.container.right-panel-active .overlay-right {
	transform: translateX(-100%);
	opacity: 0;
}

.container.right-panel-active .overlay-left {
	transform: translateX(-100%);
	opacity: 1;
	z-index: 2;
}

.social-links {
	margin: 20px 0;
}

h1.idSearch1 {
	font-weight: bold;
	margin: 0;
	color: white;
}

h1.passSearch {
	font-weight: bold;
	margin: 0;
	color: black;
}

p {
	font-size: 16px;
	font-weight: bold;
	letter-spacing: 0.5px;
	margin: 20px 0 30px;
}

span {
	font-size: 12px;
	color: #000;
	letter-spacing: 0.5px;
	margin-bottom: 10px;
}

.social-links div {
	width: 40px;
	height: 40px;
	display: inline-flex;
	justify-content: center;
	align-items: center;
	margin: 0 5px;
	border-radius: 50%;
	box-shadow: -5px -5px 10px #fff, 5px 5px 8px #babebc;
	cursor: pointer;
}

.social-links a {
	color: #000;
}

.social-links div:active {
	box-shadow: inset 1px 1px 2px #babebc, inset -1px -1px 2px #fff;
}

.forgetBtn {
	display: block;
	width: 100%;
	background: #ebecf0;
}

.sinUpForm1 {
	background-color: black;
}
input#passSearchKey {
    background: #eee;
    height: auto;
    padding: 16px;
    margin: 8px 0;
    width: 100%;
    border: 0;
    outline: none;
    border-radius: 20px;
    box-shadow: inset 7px 2px 10px #babebc, inset -5px -5px 12px #fff;
}
input#passSearchId {
    background: #eee;
    height: auto;
    padding: 16px;
    margin: 8px 0;
    width: 100%;
    border: 0;
    outline: none;
    border-radius: 20px;
    box-shadow: inset 7px 2px 10px #babebc, inset -5px -5px 12px #fff;
}
input#idSearchKey {
 background: #eee;
    height: auto;
    padding: 16px;
    margin: 8px 0;
    width: 150%;
    border: 0;
    outline: none;
    border-radius: 20px;
    box-shadow: inset 7px 2px 10px #babebc, inset -5px -5px 12px #fff;
}
.overlay_btn {
    /* background-color: #ff4b2b; */
    background-color: black;
    color: #fff;
    box-shadow: -1px -2px 10px white, 1px 2px 8px;
}
button.btn.overlay_btn.form_btn {
	border-radius: 22px;
    border: none;
    outline: none;
    font-size: 12px;
    font-weight: bold;
    padding: 15px 45px;
    margin: 14px;
    letter-spacing: 1px;
    text-transform: uppercase;
    cursor: pointer;
    transition: transform 80ms ease-in;
}
</style>

</head>
<body>
	<div class="wrapper">
		<div class="container">
			<div class="backBtn"><a href="#" onclick="history.go(-1);"><button>BACK</button></a></div>
			<div class="sign-up-container">
				<form>
					<h1>Create Account</h1>
					<span>or use your email for registration</span> <input
						type="hidden" placeholder="Name"> <input type="text"
						id="#" name="#" placeholder="ID"> <input type="password"
						id="#" name="#" placeholder="Password">
					<button type="submit" id="loginBtn" class="form_btn loginBtn">Sign
						Up</button>
				</form>
			</div>
			<div class="sign-in-container">
				<form action="${pageContext.request.contextPath}/account/pwSearch" id="passSearchForm" method="post">
					<h1 class="passSearch" style="text-align: center;">PASSWORD SEARCH</h1>
					<label for="passSearchId"></label>
					<input type="text" class="form-control" name="passSearchId" id="passSearchId" placeholder="아이디를 입력해주세요.">
					<label for="passSearchKey"></label>
					<input type="text" class="form-control" name="searchKey" id="passSearchKey" placeholder="이메일을 입력해주세요."/>
					<button type="submit" class="form_btn">Password Search</button>
				</form>
			</div>
			<div class="overlay-container">
				<div class="overlay-left">
					<h1>Welcome Back</h1>
					<p>To keep connected with us please login with your personal
						info</p>
					<button id="signIn" class="overlay_btn">Sign In</button>
				</div>
				<div class="overlay-right sinUpForm1">
					<form action="${pageContext.request.contextPath}/account/idSearch" id="idSearchForm" method="post">
					<h1 class="idSearch1">ID SEARCH</h1>
					<span> Forget ID? </span>
						<label for="idSearchKey"></label>
						<input type="text" class="form-control" name="searchKey" id="idSearchKey" placeholder="이메일을 입력해주세요."/>
					<button class="btn overlay_btn form_btn">ID Search</button>
				</form>
				</div>
			</div>
		</div>
	</div>
</body>

<script>
// 아이디 찾기 빈칸검사
$(document).ready(function(){
	$("#idSearchForm").on("submit",function(){
		if ($("#idSearchKey").val().trim()==""){
			alert('이메일을 입력바랍니다.');
			return false;
		}
	});
});
</script>

<script>
// 패스워드 찾기 빈칸검사
$(document).ready(function(){
	$("#passSearchForm").on("submit",function(){
		if ($("#passSearchKey").val().trim()==""){
			alert('아이디와 이메일을 입력바랍니다.');
			return false;
		}
	});
});
</script>

</html>