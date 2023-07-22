<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="shortcuticon"
	href="${pageContext.request.contextPath}/resources/img/favicon.png"
	type="image/x-icon">
<link rel="icon"
	href="${pageContext.request.contextPath}/resources/img/favicon.png"
	type="image/x-icon">
<!-- 사파리  -->
<title>SUMMER</title>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<!-- jQuery library -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<!-- Latest compiled JavaScript -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<!-- 날씨 api - fontawesome 아이콘 -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/summer_css.css">
</head>
<body>
	<div id="header">
		<h1 class="myhidden">MY COMPANY</h1>
		<nav class="navbar navbar-inverse hback">
			<h2 class="myhidden">주메뉴</h2>
			<div class="container-fluid headersize">
				<div class="navbar-header">
					<a class="navbar-brand logodesign" href="${pageContext.request.contextPath}/account/afterLoginMain">SUMMER</a>
				</div>
				<ul class="nav navbar-nav">
	 			<li><a href="${pageContext.request.contextPath}/project/p_list?uid=${userid}" class="fsize">프로젝트</a></li>
				<%-- 	<li class="dropdown"><a class="dropdown-toggle fsize"
						data-toggle="dropdown" href="#">근무관리 <span class="caret"></span></a>
						<ul class="dropdown-menu">
							<li><a href="${pageContext.request.contextPath}/work/workinghour" class="fsize">출/퇴근 관리</a></li>
							<li><a href="${pageContext.request.contextPath}/work/totaldayoff" class="fsize">연차 관리</a></li>
						</ul></li>  --%>

						<li><a href="${pageContext.request.contextPath}/work/workinghour" class="fsize">출/퇴근 관리</a></li>
							<li><a href="${pageContext.request.contextPath}/work/totaldayoff" class="fsize">연차 관리</a></li>
						</ul>

						<ul class="nav navbar-nav">
					<li><a href="${pageContext.request.contextPath}/work/workflow" class="fsize">전자결재</a></li>
					<li><a href="${pageContext.request.contextPath}/group/gmReadAll" class="fsize">조직도</a></li>
					<li><a href="${pageContext.request.contextPath}/calendar/myCalendar_go" class="fsize">캘린더</a></li>
</ul>

				<ul class="nav navbar-nav navbar-right">
					<li class="dropdown"><a class="dropdown-toggle fsize"
						data-toggle="dropdown" href="#">
						
						<%HttpSession httpsession = request.getSession();
					String userid = (String) httpsession.getAttribute("userid");
					%>
					<%= userid%>
						<span class="caret"></span></a>
						<ul class="dropdown-menu">
							<li><a href="${pageContext.request.contextPath}/project/invite_alarm">알림</a></li>
						         <li><a href="${pageContext.request.contextPath}/account/mmdRead">회원정보 수정</a></li>
	          <li><a href="${pageContext.request.contextPath}/account/logout">로그아웃</a></li>
						</ul></li>
				</ul>

			</div>
		</nav>
	</div>