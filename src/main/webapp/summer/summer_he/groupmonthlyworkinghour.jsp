<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../../inc/header.jsp"%>
<div class="mtotal">
<strong class="leftspace">${username}</strong>

<table class="table table-striped table-hover">
	<caption class="leftspace" id="currentmonth"></caption>
	<thead>
		<tr>
			<th scope="col">날짜</th>
			<th scope="col">출근시간</th>
			<th scope="col">퇴근시간</th>
		</tr>
	</thead>

	<c:forEach var="list" items="${list}" varStatus="status">
		<tbody>
			<tr>
				<td class="whdate">${list.whdate}</td>
				<td class="whgotime">${list.whgotime}</td>
				<td class="whleavetime">${list.whleavetime}</td>
			</tr>
		</tbody>
	</c:forEach>
</table>
</div>
<script>
let date = new Date();
var year = date.getFullYear();
var month = ("0" + (1 + date.getMonth())).slice(-2);
var selectmonth = year + "-" + month;
var selectormonth = document.querySelector("#currentmonth");
selectormonth.innerHTML = selectmonth;

</script>

<%@ include file="../../inc/footer.jsp"%>