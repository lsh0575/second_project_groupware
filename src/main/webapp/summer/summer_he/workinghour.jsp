<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../../inc/header.jsp"%>
<div class="mtotal">
<div>
	<strong class="leftspace">근태 체크</strong>
	<!-- userid가 그룹장 id면 보이기 -->

<c:if test="${resultleader==1}">
<div class="dropdownwh">
  <button class="btn btn-default dropbtnwh">그룹원 근태 확인</button>
    <div class="dropdown-content">
</div>
</div>
</c:if>
</div>
<div class="bottomline workingcheck">
	<div class="row">
		<div class="col-sm-3">
			<div id="today"></div>
		</div>

<!-- 0:출퇴근x 1:출퇴근o 2:출근o퇴근x -->
		<fieldset id="btn_fieldset">
			<div class="col-sm-3">
				<div class="topspace">출근</div>
				<div id="gotime"></div>
				<c:if test="${result==0}">
<!-- 				<button class="btn btn-primary btnspace " id="gotowork">출근하기</button> -->
				<button class="btn overlay_btn" id="gotowork">출근하기</button>
				</c:if>	
				<c:if test="${result!=0}">
				<div class="textspace">${selectworkinghour.whgotime}</div>
				</c:if>
			</div>
			<div class="col-sm-3">
				<div class="topspace">퇴근</div>
				<div id="leavetime"></div>
				<c:if test="${result!=1}">
<!-- 				<button class="btn btn-primary btnspace" id="leavetowork">퇴근하기</button> -->
				<button class="btn overlay_btn" id="leavetowork">퇴근하기</button>
				</c:if>
				<c:if test="${result==1}">
				<div class="textspace">${selectworkinghour.whleavetime}</div>
				</c:if>
			</div>

			<div class="col-sm-3">
				<div class="topspace">근무시간</div>
				<div id="workinghour"></div>
				<c:if test="${result!=0}">
				<div id="workinghour1">${resulthour}<span>시간 </span>${resultmin}<span>분</span></div>
			</c:if>
			</div>
		</fieldset>
	</div>
</div>

<table class="table table-striped table-hover">
	<caption class="leftspace" id="currentmonth"></caption>
	<thead>
		<tr>
			<th scope="col"></th>
			<th scope="col">출근시간</th>
			<th scope="col">퇴근시간</th>
		</tr>
	</thead>

	<c:forEach var="list" items="${list}" varStatus="status">
		<tbody>
			<tr>
				<td class="whdate1">${list.whdate}</td>
				<td class="whgotime1">${list.whgotime}</td>
				<td class="whleavetime1">${list.whleavetime}</td>
				<td>
<!-- 					<button class="btn btn-primary editworkinghour" data-toggle="modal"
						data-target="#myModal">수정</button>	 -->
						<button class="btn overlay_btn editworkinghour" data-toggle="modal"
						data-target="#myModal">수정</button>
				<input type="hidden" name="whdate"   class="whdate" value="${list.whdate}" />
				<input type="hidden" name="wfcsrn"   class="wfcsrn" value="4" />
				<input type="hidden" name="whgotime" class="whgotime" value="${list.whgotime}" />
				<input type="hidden" name="whleavetime" class="whleavetime" value="${list.whleavetime}" />
				<input type="hidden" name="whsrn" class="whsrn" value="${list.whsrn}" />
				<input type="hidden" name="userid" class="userid" value="${list.userid}" /></td>
			</tr>
		</tbody>
	</c:forEach>
</table>



<div class="modal fade" id="myModal" role="dialog">
	<div class="modal-dialog">

		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header" style="padding: 35px 50px;">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4>출퇴근시간 수정</h4>
			</div>
			<div class="modal-body modalsize" style="padding: 40px 50px;">
				<form role="form"
					action="${pageContext.request.contextPath}/work/insertWorkFlow"
					method="post">
					<div class="form-group">
						<label for="wfapplystartdate">시작일</label> <input type="text"
							class="form-control" name="wfapplystartdate"
							id="wfapplystartdate" value="" readonly>
					</div>

					<div class="form-group">
						<label for="wfapplyenddate">종료일</label> <input type="text"
							class="form-control" name="wfapplyenddate" id="wfapplyenddate"
							value="" readonly>
					</div>

					<div class="form-group">
						<label for="wfapplystarttime">출근시간</label> <input type="text"
							class="form-control" name="wfapplystarttime"
							id="wfapplystarttime" value="">
					</div>

					<div class="form-group">
						<label for="wfapplyendtime">퇴근시간</label> <input type="text"
							class="form-control" name="wfapplyendtime" id="wfapplyendtime"
							value="">
					</div>

					<input type="hidden" name="whdate" id="whdate" value="" />
					<input type="hidden" name="whsrn" id="whsrn" value="" />
					<input type="hidden" name="whgotime" id="whgotime" value="" />				
					<input type="hidden" name="whleavetime" id="whleavetime" value="" />
					<input type="hidden" name="wfcsrn"  class="wfcsrn" value="4" />

<!-- 					<button type="submit" class="btn btn-success btn-block">기안하기</button> -->
					<button type="submit" class="btn overlay_btn btn-block">기안하기</button>
				</form>
			</div>
			<div class="modal-footer">
				<!-- <button type="button" class="btn btn-danger btn-default pull-left"
					data-dismiss="modal">
					<span class="glyphicon glyphicon-remove"></span>취소
				</button> -->
				<button type="button" class="btn overlay_btn2 pull-left"
					data-dismiss="modal">
					<span class="glyphicon glyphicon-remove"></span>취소
				</button>
			</div>
		</div>
	</div>
</div>
</div>
<script>

	//현재 날짜, 시간 불러오기
	let date = new Date();
	var year = date.getFullYear();
	var month = ("0" + (1 + date.getMonth())).slice(-2);
	var day = ("0" + date.getDate()).slice(-2);
	var today = year + "-" + month + "-" + day;

	var hours = ('0' + date.getHours()).slice(-2);
	var minutes = ('0' + date.getMinutes()).slice(-2);
	var seconds = ('0' + date.getSeconds()).slice(-2);
	var time = hours + ":" + minutes + ":" + seconds;

	//현재 날짜 미리 띄우기
	$(function() {
		var selector = document.querySelector("#today");
		selector.innerHTML = today + "<div class='actfont'>" + time + "</div>";
	});

	//수정버튼 눌렀을 때
	// <button class="btn btn-primary editworkinghour" data-toggle="modal" data-target="#myModal">수정</button>
	$(function() {
		$(".editworkinghour" ).click( function() { 
			
			var whsrn       = $(this).closest("td").find(".whsrn").val();
			var whdate      = $(this).closest("td").find(".whdate").val();
			var whgotime    = $(this).closest("td").find(".whgotime").val();
			var whleavetime = $(this).closest("td").find(".whleavetime").val();
			var userid       = $(this).closest("td").find(".userid").val();  
			 
			console.log( whsrn  + "/" + whdate + "/" + whgotime + "/" + whleavetime + "/" +userid);
			
			//$("#whsrn").val(whsrn);
			$("#wfapplystartdate").val(whdate);
			$("#wfapplyenddate").val(whdate);
			$("#wfapplystarttime").val(whgotime);
			$("#wfapplyendtime").val(whleavetime);
			$("#whsrn").val(whsrn);
			$("#whgotime").val(whgotime);
			$("#whleavetime").val(whleavetime);
			$("#whdate").val(whdate);
			
			/*
			document.getElementById('whsrn').value = whsrn;
			document.getElementById('wfapplystartdate').value = whdate;
			document.getElementById('wfapplyenddate').value = whdate;
			document.getElementById('wfapplystarttime').value = whgotime;
			document.getElementById('wfapplyendtime').value = whleavetime;
			document.getElementById('userid').value = userid;

			*/

		});
	});

	//현재 날짜, 시간 1초마다 메서드 호출
	setInterval(function() {
		let date = new Date();
		var year = date.getFullYear();
		var month = ("0" + (1 + date.getMonth())).slice(-2);
		var day = ("0" + date.getDate()).slice(-2);
		var today = year + "-" + month + "-" + day;

		var hours = ('0' + date.getHours()).slice(-2);
		var minutes = ('0' + date.getMinutes()).slice(-2);
		var seconds = ('0' + date.getSeconds()).slice(-2);
		var currenttime = hours + ":" + minutes + ":" + seconds;
		var selector = document.querySelector("#today");
		selector.innerHTML = today + "<div class='actfont'>" + currenttime
				+ "</div>";
	}, 1000);

	//테이블캡션
	var selectmonth = year + "-" + month;
	var selectormonth = document.querySelector("#currentmonth");
	selectormonth.innerHTML = selectmonth

	//출근버튼 + 데이터 insert
	$(function() {
		$("#gotowork").on("click", function() {

			let date = new Date();
			var year = date.getFullYear();
			var month = ("0" + (1 + date.getMonth())).slice(-2);
			var day = ("0" + date.getDate()).slice(-2);
			var today = year + "-" + month + "-" + day;

			var hours = ('0' + date.getHours()).slice(-2);
			var minutes = ('0' + date.getMinutes()).slice(-2);
			var seconds = ('0' + date.getSeconds()).slice(-2);
			var gotime = hours + ":" + minutes;

			var gotimerecord = document.querySelector("#gotime");
			gotimerecord.innerHTML = gotime;
			//$("#gotimerecord").html(gotime);

			const gotimeelement = document.getElementById('gotime');

			$.ajax({
				url : "${pageContext.request.contextPath}/work/gotimeinsert",
				type : "GET",
				data : {
					"whgotime" : gotimeelement.innerText,
					"whleavetime" : gotimeelement.innerText,
					"whdate" : today,
				},
				/* {'userid':${sessionScope.userid}} */
				success : function(data) {
					$("#gotowork").addClass("disabled");
				},
				error : function() {
					alert("관리자에게 문의 바랍니다.");
				}
			});

			$("#gotowork").unbind('click');

		});
	});

	//퇴근버튼 + 데이터 insert	
	$("#leavetowork").on("click",function() {
						//console.log($("#gotime").html());
						let date = new Date();
						var year = date.getFullYear();
						var month = ("0" + (1 + date.getMonth())).slice(-2);
						var day = ("0" + date.getDate()).slice(-2);
						var today = year + "." + month + "." + day;

						var hours = ('0' + date.getHours()).slice(-2);
						var minutes = ('0' + date.getMinutes()).slice(-2);
						var seconds = ('0' + date.getSeconds()).slice(-2);
						var leavetime = hours + ":" + minutes;

						var leavetimerecord = document
								.querySelector("#leavetime");
						leavetimerecord.innerHTML = leavetime;

						const leavetimeelement = document.getElementById('leavetime');
						//console.log(leavetimeelement.ineerTEXT); 

						$.ajax({
									url : "${pageContext.request.contextPath}/work/leavetimeupdate",
									type : "POST",
									data : {
										"whleavetime" : leavetimeelement.innerText,
									},
									success : function(data) {
										$("#leavetowork").addClass("disabled");
									},
									error : function() {
										alert("관리자에게 문의 바랍니다.");
									}
								});

						$("#leavetowork").unbind('click');
					});
	
	$(function() {
		$(".dropdownwh").on("click", function() {
			$(".dropdown-content").empty();
			//alert("test");
			$.ajax({
				url : "${pageContext.request.contextPath}/work/groupWorkingHour",
				type : "GET",
				success : function(json) {
					//console.log(json);
					var dropdownselector = document.querySelector(".dropdown-content");
				
					for(var i = 0; i < json.length; i++) {
						var groupusername = json[i].username;
						var groupuserid = json[i].userid;
						//console.log(groupusername);
						var a = $("<a href='${pageContext.request.contextPath}/work/monthlyWorkingHour?userid="+groupuserid+"&username="+groupusername+"'>");
						var text = groupusername;

						a.append(text);					
						$(".dropdown-content").append(a);
					}	
				},
				error : function() {
					alert("관리자에게 문의 바랍니다.");
				}
			});
		});
	});
</script>

<%@ include file="../../inc/footer.jsp"%>
