<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../../inc/header.jsp"%>

<div class="mtotal">
<strong class="leftspace">기안함</strong>
<div class="bottomline"></div>

<table class="table">
	<thead>
		<tr>
			<th scope="col" class="tcenter">NO</th>
			<th scope="col" class="tcenter">시작일</th>
			<th scope="col" class="tcenter">종료일</th>
			<th scope="col" class="tcenter">전자결재명</th>
			<th scope="col" class="tcenter">기안상태</th>
			<th scope="col" class="tcenter">기안일</th>
			<th scope="col" class="tcenter">기안삭제</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="list" items="${list}" varStatus="status">
			<tr>
				<td class="tcenter">${status.count}</td>
				<td class="tcenter">${list.wfapplystartdate}</td>
				<td class="tcenter">${list.wfapplyenddate}</td>
				<td class="tcenter">
				<input type="hidden" name="wfsrn" class="wfsrn" value="${list.wfsrn}"/>
				<p class="btn workflowpopup detailworkflow" data-toggle="modal"
						data-target="#workflowmodal">
				<c:choose>
						<c:when test="${list.wfcsrn==1}">휴가(1일) 신청</c:when>
						<c:when test="${list.wfcsrn==4}">출퇴근시간 수정</c:when>
						<c:otherwise>반차(오전/오후) 신청</c:otherwise>
					</c:choose></p></td>
				<td class="tcenter">${list.wfstatus}</td>
				<td class="tcenter">${list.wfdate}</td>
				<td class="tcenter"><p class="btn">
						<a href="${pageContext.request.contextPath}/work/deleteworkflow?wfsrn=${list.wfsrn}&userid=${list.userid}">기안
							삭제</a>
					</p></td>
			</tr>
		</c:forEach>
	</tbody>
</table>

<!-- 모달1 -->
<div class="modal fade" id="workflowmodal" role="dialog">
	<div class="modal-dialog">

		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header" style="padding: 35px 50px;">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modalname"></h4>
			</div>
			<div class="modal-body modalsize" style="padding: 40px 50px;">
				<form role="form" action="#" method="post" name="workflowform">
					<div class="form-group">
						<label for="wfapplystartdate1">시작일</label> <input type="date"
							class="form-control" name="wfapplystartdate"
							id="wfapplystartdate1" value="" readonly>
					</div>

					<div class="form-group">
						<label for="wfapplyenddate1">종료일</label> <input type="date"
							class="form-control" name="wfapplyenddate" id="wfapplyenddate1"
							value="" readonly>
					</div>

					<div class="form-group">
						<label for="wfapplystarttime1">시작시간</label> <input type="text"
							class="form-control" name="wfapplystarttime"
							id="wfapplystarttime1" value="" readonly>
					</div>

					<div class="form-group">
						<label for="wfapplyendtime1">종료시간</label> <input type="text"
							class="form-control" name="wfapplyendtime" id="wfapplyendtime1"
							value="" readonly>
					</div>

					<input type="hidden" name="userid" id="userid" value="" /> <input
						type="hidden" name="wfsrn" id="wfsrn" value="" /> <input
						type="hidden" name="whsrn" id="whsrn" value="" />

				</form>
			</div>
			<div class="modal-footer">
<!-- 				<button type="button" class="btn btn-primary btn-default pull-left"
					data-dismiss="modal">
					<span class="glyphicon glyphicon-remove"></span>확인
				</button> -->
								<button type="button" class="btn overlay_btn btn-default pull-left"
					data-dismiss="modal">
					<span class="glyphicon glyphicon-remove"></span>확인
				</button>
			</div>
		</div>
	</div>
</div>
</div>

<script>
$(function() {
	$(".detailworkflow").on("click", function() {
		//alert("test");
		var wfsrn = $(this).closest("tr").find(".wfsrn").val();
		//console.log(wfsrn);
		$.ajax({
			url : "${pageContext.request.contextPath}/work/detailWorkflow",
			type : "GET",
			data : {
				"wfsrn" : wfsrn
			},
			dataType : "json",
			contentType : "application/json; charset=UTF-8",
			success : function(json) {
				//$(".workflowmodal").load("/insertWorkFlow");
				
				var wfapplystartdate = json.wfapplystartdate;
				var wfapplyenddate = json.wfapplyenddate;
				var wfapplystarttime = json.wfapplystarttime;
				var wfapplyendtime = json.wfapplyendtime;
				var wfsrn = json.wfsrn;
				var userid = json.userid;
							
				$("#wfapplystartdate1").val(wfapplystartdate);
				$("#wfapplyenddate1").val(wfapplyenddate);
				$("#wfapplystarttime1").val(wfapplystarttime);
				$("#wfapplyendtime1").val(wfapplyendtime);
				$("#wfsrn").val(wfsrn);
				$("#userid").val(userid);
				
			},
			error : function() {
				alert("관리자에게 문의 바랍니다.");
			}
		}); 
	});
});
</script>

<%@ include file="../../inc/footer.jsp"%>