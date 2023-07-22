<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../../inc/header.jsp"%>

<div class="mtotal">
<strong class="leftspace">결재할 문서</strong>
<span>(전자결재명을 클릭할 경우, 해당 기안 상세보기가 가능합니다.)</span>
<div class="bottomline"></div>

<table class="table table-striped table-hover">
	<thead>
		<tr>
			<th scope="col" class="tcenter">문서번호</th>
			<th scope="col" class="tcenter">기안일</th>
			<th scope="col" class="tcenter">전자결재명</th>
			<th scope="col" class="tcenter">시작시간</th>
			<th scope="col" class="tcenter">종료시간</th>
			<th scope="col" class="tcenter">기안자</th>
			<th scope="col" class="tcenter">진행상태</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="list" items="${list}" varStatus="status">
			<tr>
				<td class="tcenter">${status.count}</td>
				<td class="tcenter">${list.wfdate}</td>

				<td class="tcenter"><input type="hidden" class="wfsrn"
					value="${list.wfsrn}" />
					<p class="workflowpopup detailworkflow" data-toggle="modal"
						data-target="#workflowmodal">
						<c:choose>
							<c:when test="${list.wfcsrn==1}">
					휴가1일신청
				</c:when>

							<c:when test="${list.wfcsrn==2}">
					반차(오전) 신청
				</c:when>

							<c:when test="${list.wfcsrn==3}">
					반차(오후) 신청
				</c:when>

							<c:when test="${list.wfcsrn==4}">
					출퇴근시간 수정 신청
				</c:when>
						</c:choose>
					</p></td>
				<td class="tcenter">${list.wfapplystarttime}</td>
				<td class="tcenter">${list.wfapplyendtime}</td>
				<td class="tcenter">${list.userid}</td>
				<td class="tcenter">${list.wfstatus}</td>
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
				<form role="form"
					action="${pageContext.request.contextPath}/work/checkworkflow"
					method="post" name="workflowform">
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

					<input type="hidden" name="wfcsrn" id="wfcsrn" value="" />
					<input type="hidden" name="userid" id="userid" value="" />
					<input type="hidden" name="wfsrn" id="wfsrn" value="" />
					<input type="hidden" name="whsrn" id="whsrn" value="" />

<!-- 					<button type="submit" class="btn btn-success btn-block checkbtn1" id="accept">승인</button>
					<button type="submit" class="btn btn-success btn-block checkbtn2" id="reject">반려</button> -->
										<button type="submit" class="btn overlay_btn btn-block checkbtn1" id="accept">승인</button>
					<button type="submit" class="btn overlay_btn btn-block checkbtn2" id="reject">반려</button>
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
		$(".detailworkflow").on("click", function() {
			//alert("test");
			var wfsrn = $(this).closest("tr").find(".wfsrn").val();
		
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
					var wfstatus = json.wfstatus;
					var wfapplystartdate = json.wfapplystartdate;
					var wfapplyenddate = json.wfapplyenddate;
					var wfapplystarttime = json.wfapplystarttime;
					var wfapplyendtime = json.wfapplyendtime;
					var wfsrn = json.wfsrn;
					var wfcsrn = json.wfcsrn;
					var userid = json.userid;
					//console.log(wfstatus);
					
					if(wfstatus != '진행중') {
				
						$("#accept").hide();
						$("#reject").hide();
					}
								
					$("#wfapplystartdate1").val(wfapplystartdate);
					$("#wfapplyenddate1").val(wfapplyenddate);
					$("#wfapplystarttime1").val(wfapplystarttime);
					$("#wfapplyendtime1").val(wfapplyendtime);
					$("#wfsrn").val(wfsrn);
					$("#userid").val(userid);
					$("#wfcsrn").val(wfcsrn);
				},
				error : function() {
					alert("관리자에게 문의 바랍니다.");
				}
			}); 
			
			$(".checkbtn1").on("click", function() {
				document.workflowform.action ="${pageContext.request.contextPath}/work/checkworkflow?check=OK";
			});
			
			$(".checkbtn2").on("click", function() {
				document.workflowform.action ="${pageContext.request.contextPath}/work/checkworkflow?check=NO";
			});
		});
	});
</script>


<%@ include file="../../inc/footer.jsp"%>