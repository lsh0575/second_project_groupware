<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../../inc/header.jsp"%>

<div class="mtotal">
<div class="row">
	<div class="col-sm-6">
		<div>
			<strong class="leftspace">최근 기안문서</strong> <a class="btn"
				href="${pageContext.request.contextPath}/work/workflowdraft">기안함
				바로가기</a>
				
				<!-- 아이디 그룹장이면 보이게 -->
				<c:if test="${result==1}">
				<a class="btn" href="${pageContext.request.contextPath}/work/groupWorkflow">
				그룹원 기안 확인하러 가기</a>
				</c:if>
		</div>
		<div class="row">
			<c:forEach var="list" items="${list}" varStatus="status">
				<div class="col-sm-4 lastworkflow">
					<strong class="wffontsize">결재명 : </strong>
					<c:choose>
						<c:when test="${list.wfcsrn==1}"><span class="wffontsize">휴가(1일) 신청</span></c:when>
						<c:when test="${list.wfcsrn==4}"><span class="wffontsize">출퇴근시간 수정 신청</span></c:when>
						<c:when test="${list.wfcsrn==2}"><span class="wffontsize">반차(오전) 신청</span></c:when>
						<c:when test="${list.wfcsrn==3}"><span class="wffontsize">반차(오후) 신청</span></c:when>
					</c:choose>
					<br /> <strong class="wffontsize">기안일 : </strong><span class="wffontsize">${list.wfdate}</span> <br />
					<strong class="wffontsize">기안상태 : </strong><span class="dayoffcolor wffontsize"> ${list.wfstatus}</span>
				</div>
				<c:set var="btest" value="true"/>
			</c:forEach>
		</div>
	</div>

	<div class="col-sm-6 bottomline workflowcheck">
		<strong class="leftspace">전자결재 목록</strong>
		<div class="bottomline"></div>
		<p>
		<button class="btn workflowpopup editworkinghour" data-toggle="modal"
				data-target="#workflowmodal1">출퇴근시간 수정 신청</button> 
				
		</p>
		<p>
			<button class="btn workflowpopup usedayoffoneday" data-toggle="modal"
				data-target="#workflowmodal2">휴가(1일) 사용 신청</button>
		</p>
		<p>
			<button class="btn workflowpopup usedayoffmhalfday"
				data-toggle="modal" data-target="#workflowmodal3">반차(오전) 사용
				신청</button>
		</p>

		<p>
			<button class="btn workflowpopup usedayoffhalfday"
				data-toggle="modal" data-target="#workflowmodal4">반차(오후) 사용
				신청</button>
		</p>
	</div>
</div>

<!-- 모달1 출퇴근시간 수정-->
<div class="modal fade" id="workflowmodal1" role="dialog">
	<div class="modal-dialog">

		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header" style="padding: 35px 50px;">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modalname"></h4>
			</div>
			<div class="modal-body modalsize" style="padding: 40px 50px;">
				<form role="form"
					action="${pageContext.request.contextPath}/work/insertWorkFlow"
					method="post">
					<div class="form-group">
						<label for="wfapplystartdate1">시작일</label> <input type="date"
							class="form-control" name="wfapplystartdate" id="wfapplystartdate1" value="">
					</div>
					
								<div class="form-group">
						<label for="wfapplyenddate1">종료일</label> <input type="date"
							class="form-control" name="wfapplyenddate" id="wfapplyenddate1" value="" readonly>
					</div>

					<div class="form-group">
						<label for="wfapplystarttime1">출근시간</label> <input type="text"
							class="form-control" name="wfapplystarttime" id="wfapplystarttime1" value="">
					</div>

					<div class="form-group">
						<label for="wfapplyendtime1">퇴근시간</label> <input type="text"
							class="form-control" name="wfapplyendtime" id="wfapplyendtime1" value="">
					</div>
				
				<input type="hidden" name="whsrn" id="whsrn" value="" />
				<input type="hidden" name="whdate" id="whdate1" value="" />
				<input type="hidden" name="whgotime" id="whgotime1" value="" />
				<input type="hidden" name="whleavetime" id="whleavetime1" value="" />
				<input type="hidden" name="wfcsrn" id="wfcsrn1" value="" />
<!-- 					<button type="submit" class="btn btn-success btn-block">기안하기</button> -->
					<button type="submit" class="btn overlay_btn btn-block">기안하기</button>
				</form>
			</div>
			<div class="modal-footer">
<!-- 				<button type="button" class="btn btn-danger btn-default pull-left"
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

<!-- 모달2 휴가(1일) 사용 신청-->
<div class="modal fade" id="workflowmodal2" role="dialog">
	<div class="modal-dialog">

		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header" style="padding: 35px 50px;">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modalname2"></h4>
			</div>
			<div class="modal-body modalsize" style="padding: 40px 50px;">
				<form role="form"
					action="${pageContext.request.contextPath}/work/insertWorkFlow"
					method="post">
					<div class="form-group">
						<label for="wfapplystartdate2">시작일</label> <input type="date"
							class="form-control" id="wfapplystartdate2" name="wfapplystartdate" value="">
					</div>

					<div class="form-group">
						<label for="wfapplyenddate2">종료일</label> <input type="date"
							class="form-control" id="wfapplyenddate2" name="wfapplyenddate" value="">
					</div>

					<div class="form-group">
						<label for="wfapplystarttime2">출근시간</label> <input type="text"
							class="form-control" id="wfapplystarttime2" name="wfapplystarttime" value="" readonly>
					</div>

					<div class="form-group">
						<label for="wfapplyendtime2">퇴근시간</label> <input type="text"
							class="form-control" id="wfapplyendtime2" name="wfapplyendtime" value="" readonly>
					</div>
					
						<input type="hidden" name="whdate" id="whdate1" value="" />
				<input type="hidden" name="whgotime" id="whgotime1" value="" />
				<input type="hidden" name="whleavetime" id="whleavetime1" value="" />
					<input type="hidden" name="wfcsrn" id="wfcsrn2" value="" />
		<!-- 			<button type="submit" class="btn btn-success btn-block">기안하기</button> -->
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

<!-- 모달3 -->
<div class="modal fade" id="workflowmodal3" role="dialog">
	<div class="modal-dialog">

		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header" style="padding: 35px 50px;">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modalname3"></h4>
			</div>
			<div class="modal-body modalsize" style="padding: 40px 50px;">
				<form role="form"
					action="${pageContext.request.contextPath}/work/insertWorkFlow"
					method="post">
					<div class="form-group">
						<label for="wfapplystartdate3">시작일</label> <input type="date"
							class="form-control" id="wfapplystartdate3" name="wfapplystartdate" value="">
					</div>

					<div class="form-group">
						<label for="wfapplyenddate3">종료일</label> <input type="date"
							class="form-control" id="wfapplyenddate3" name="wfapplyenddate" value="">
					</div>

					<div class="form-group">
						<label for="wfapplystarttime3">출근시간</label> <input type="text"
							class="form-control" name="wfapplystarttime" id="wfapplystarttime3" value="" readonly>
					</div>

					<div class="form-group">
						<label for="wfapplyendtime3">퇴근시간</label> <input type="text"
							class="form-control" name="wfapplyendtime" id="wfapplyendtime3" value="" readonly>
					</div>
					
						<input type="hidden" name="whdate" id="whdate1" value="" />
				<input type="hidden" name="whgotime" id="whgotime1" value="" />
				<input type="hidden" name="whleavetime" id="whleavetime1" value="" />
					<input type="hidden" name="wfcsrn" id="wfcsrn3" value="" />
		<!-- 			<button type="submit" class="btn btn-success btn-block">기안하기</button> -->
					<button type="submit" class="btn overlay_btn btn-block">기안하기</button>
				</form>
			</div>
			<div class="modal-footer">
<!-- 				<button type="button" class="btn btn-danger btn-default pull-left"
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

<!-- 모달4 -->
<div class="modal fade" id="workflowmodal4" role="dialog">
	<div class="modal-dialog">

		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header" style="padding: 35px 50px;">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modalname4"></h4>
			</div>
			<div class="modal-body modalsize" style="padding: 40px 50px;">
				<form role="form"
					action="${pageContext.request.contextPath}/work/insertWorkFlow"
					method="post">
					<div class="form-group">
						<label for="wfapplystartdate4">시작일</label> <input type="date"
							class="form-control" id="wfapplystartdate4" name="wfapplystartdate" value="">
					</div>

					<div class="form-group">
						<label for="wfapplyenddate4">종료일</label> <input type="date"
							class="form-control" id="wfapplyenddate4" name="wfapplyenddate" value="">
					</div>

					<div class="form-group">
						<label for="wfapplystarttime4">출근시간</label> <input type="text"
							class="form-control" name="wfapplystarttime" id="wfapplystarttime4" value="" readonly>
					</div>

					<div class="form-group">
						<label for="wfapplyendtime4">퇴근시간</label> <input type="text"
							class="form-control" name="wfapplyendtime" id="wfapplyendtime4" value="" readonly>
					</div>
					
				<input type="hidden" name="whdate" id="whdate1" value="" />
				<input type="hidden" name="whgotime" id="whgotime1" value="" />
				<input type="hidden" name="whleavetime" id="whleavetime1" value="" />
				<input type="hidden" name="wfcsrn" id="wfcsrn4" value="" />
<!-- 					<button type="submit" class="btn btn-success btn-block">기안하기</button> -->
					<button type="submit" class="btn overlay_btn btn-block">기안하기</button>
				</form>
			</div>
			<div class="modal-footer">
<!-- 				<button type="button" class="btn btn-danger btn-default pull-left"
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
$(function() {
	$(".editworkinghour").on("click", function() {
		let date = new Date();
		var year = date.getFullYear();
		var month = ("0" + (1 + date.getMonth())).slice(-2);
		var day = ("0" + date.getDate()).slice(-2);
		var today = year + "-" + month + "-" + day;
		
		$.ajax({
			url : "${pageContext.request.contextPath}/work/workflowcategoryview?wfcsrn=4",
			type : "GET",
			dataType : "json",
			contentType: "application/json; charset=UTF-8",
			success : function(json){
				//console.log(json);
				var wfcname = json.wfcname;
				var wfcstarttime = json.wfcstarttime;
				var wfcendtime = json.wfcendtime;
				var wfcsrn = json.wfcsrn;
				

				var modalnameselector = document.querySelector(".modalname");
				modalnameselector.innerHTML = wfcname;
				
				$("#wfapplystartdate1").val(today);
				$("#wfapplyenddate1").val(today);
				$("#wfapplystarttime1").val(wfcstarttime);
				$("#wfapplyendtime1").val(wfcendtime);
				$("#wfcsrn").val(wfcsrn);
				
			}, error: function(json){
	   	      	console.log("test-error");
	   		} 
		});
	});
	
	$("#wfapplystartdate1").on("change", function() {
		//console.log(document.getElementById('whdate1').value);
		//alert("test");
		var whdate = document.getElementById('wfapplystartdate1').value;
		//console.log(whdate);
		$.ajax({
			url : "${pageContext.request.contextPath}/work/selectWorkingHour",
			type : "GET",
			data : {
				"whdate" : whdate
			},
			contentType: "application/json; charset=UTF-8",
			success : function(json){
				//console.log(json);
				var whdate1 = json.whdate;
				var whgotime1 = json.whgotime;
				var whleavetime1 = json.whleavetime;	
				var whsrn1 = json.whsrn;
				//console.log(whdate1);
				//console.log(whsrn);
				$("#whsrn").val(whsrn1);
				$("#wfapplystarttime1").val(whgotime1);
				$("#wfapplyendtime1").val(whleavetime1);
				$("#wfapplyenddate1").val(whdate1);
				$("#whdate1").val(whdate1);
				$("#wfcsrn1").val(4);
			}, 
			error: function (json) {
			      console.log("error");
			   }
		});
	});	

	$(".usedayoffoneday").on("click", function() {
		
		let date = new Date();
		var year = date.getFullYear();
		var month = ("0" + (1 + date.getMonth())).slice(-2);
		var day = ("0" + date.getDate()).slice(-2);
		var today = year + "-" + month + "-" + day;
		
		$.ajax({
			url : "${pageContext.request.contextPath}/work/workflowcategoryview?wfcsrn=1",
			type : "GET",
			dataType : "json",
			contentType: "application/json; charset=UTF-8",
			success : function(json){
				//console.log(json);
				var wfcname = json.wfcname;
				var wfcstarttime = json.wfcstarttime;
				var wfcendtime = json.wfcendtime;
				var wfcsrn = json.wfcsrn;
				var wfsrn = json.wfsrn;

				var modalname2selector = document.querySelector(".modalname2");
				modalname2selector.innerHTML = wfcname;
				
				$("#wfapplystartdate2").val(today);
				$("#wfapplyenddate2").val(today);
				$("#wfapplystarttime2").val(wfcstarttime);
				$("#wfapplyendtime2").val(wfcendtime);
				$("#wfcsrn2").val(wfcsrn);
				
			}, error: function(json){
	   	      	console.log("test-error");
	   		} 
		});

	});
	
	$(".usedayoffmhalfday").on("click", function() {
		let date = new Date();
		var year = date.getFullYear();
		var month = ("0" + (1 + date.getMonth())).slice(-2);
		var day = ("0" + date.getDate()).slice(-2);
		var today = year + "-" + month + "-" + day;
		
		$.ajax({
			url : "${pageContext.request.contextPath}/work/workflowcategoryview?wfcsrn=2",
			type : "GET",
			dataType : "json",
			contentType: "application/json; charset=UTF-8",
			success : function(json){
				//console.log(json);
				var wfcname = json.wfcname;
				var wfcstarttime = json.wfcstarttime;
				var wfcendtime = json.wfcendtime;
				var wfcsrn = json.wfcsrn;

				var modalname3selector = document.querySelector(".modalname3");
				modalname3selector.innerHTML = wfcname;
				
				$("#wfapplystartdate3").val(today);
				$("#wfapplyenddate3").val(today);
				$("#wfapplystarttime3").val(wfcstarttime);
				$("#wfapplyendtime3").val(wfcendtime);
				$("#wfcsrn3").val(wfcsrn);
				
			}, error: function(json){
	   	      	console.log("test-error");
	   		} 
		});

	});
	
	$(".usedayoffhalfday").on("click", function() {
		let date = new Date();
		var year = date.getFullYear();
		var month = ("0" + (1 + date.getMonth())).slice(-2);
		var day = ("0" + date.getDate()).slice(-2);
		var today = year + "-" + month + "-" + day;
		
		$.ajax({
			url : "${pageContext.request.contextPath}/work/workflowcategoryview?wfcsrn=3",
			type : "GET",
			dataType : "json",
			contentType: "application/json; charset=UTF-8",
			success : function(json){
				//console.log(json);
				var wfcname = json.wfcname;
				var wfcstarttime = json.wfcstarttime;
				var wfcendtime = json.wfcendtime;
				var wfcsrn = json.wfcsrn;

				var modalname4selector = document.querySelector(".modalname4");
				modalname4selector.innerHTML = wfcname;
				
				$("#wfapplystartdate4").val(today);
				$("#wfapplyenddate4").val(today);
				$("#wfapplystarttime4").val(wfcstarttime);
				$("#wfapplyendtime4").val(wfcendtime);
				$("#wfcsrn4").val(wfcsrn);
				
			}, error: function(json){
	   	      	console.log("test-error");
	   		} 
		});

	});
	
	
});

</script>

<%@ include file="../../inc/footer.jsp"%>