<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../../inc/header.jsp" %>

<div class = "mtotal">
<h3 id="h3bold">TASK</h3>
	<div class="row">
		<div class="col-sm-4 nhpanel">
		
          <form action="${pageContext.request.contextPath}/project/t_complete" method="POST">
          <fieldset>  
            <input type="hidden" id="hidden_psrn" name="psrn" value="${psrn}"> 		
			<table class="table table-hover">
			<colgroup>
				<col width="5%">
				<col width="70%">
				<col width="10%">
				<col width="15%">
			</colgroup>
			<tbody>
				<tr class="text-right nhbtn">
				<th scope="row">
					<input type="submit" id="done_submit" class="btn btn-basic btn-sm" value="완료">
				</th>
				<td colspan="3">
<!-- 					<input type="button" id="addtask" class="btn btn-basic " value="업무 추가" > -->
				<button  id="addtask" class="btn overlay_btn" type="button">업무 추가</button> 
				</td>
				</tr>
				<c:forEach var="i" items="${tasks}"  varStatus="status">
					<tr>
						<th scope="row">
							<input type="checkbox" name="checked" value="${i.tsrn}" class="done_check">
						</th>
						<td><a href="#" class="task">${i.ttitle}</a></td>
						<td class="nhfont_grey">${i.tmgrid}
						<input type="hidden" id="hidden_tsrn" name="tsrn" value="${i.tsrn}">
						</td>
						<td class="nhfont_green"><small>|${i.tstate}</small></td>
					</tr> 
				</c:forEach>

			</tbody>
			</table>
			</fieldset>
			</form>
			</div>
				  <!-- Modal -->
			  	<div class="modal fade" id="addModal" role="dialog">
			    <div class="modal-dialog  modal-lg">
				<!-- Modal content-->
			      <div class="modal-content">
			        <div class="modal-header">
			          <h4>업무 추가</h4>
			        </div>
			        <div class="modal-body">
			          <form action="${pageContext.request.contextPath}/project/t_insert" method="POST">
			          <fieldset>  
			          	<div class="form-group">
			          		<span><strong>담당자</strong></span>
			          		<p class="text-info">
			          			<input type="text" id="tmgrid" name="tmgrid" class="form-control" value="${userid}">
			          			<input type="hidden" id="psrn" name="psrn" value="${psrn}">
			          		</p>
			          		
			          	</div>
			          	<div class="form-group">
			          		<label for="ttitle">업무명</label>
			          		<input type="text" id="ttitle" name="ttitle" class="form-control"> 
			          	</div>
			          	<div class="form-group">
			          		<label for="tcontent">설명</label>
			          		<textarea id="tcontent" name="tcontent" class="form-control" cols="40"  rows="10" ></textarea> 
			          	</div>
			          	<div class="modal-footer">
<!-- 			        	<input type="submit" class="btn btn-basic" id="submit" value="완료" >
			            <input type="button" class="btn btn-basic btn-default" data-dismiss="modal" value="취소"> -->
			           <button type="submit" class="btn overlay_btn" id="submit" >완료</button>
			           <button  class="btn overlay_btn2" data-dismiss="modal" >취소</button>
			       		</div>
			          </fieldset>
			          </form>
			        </div>
			        
			      </div>
				</div>
				</div>
			
				
				  <!-- Modal -->
			  	<div class="modal fade" id="editModal" role="dialog">
			    <div class="modal-dialog  modal-lg">
				<!-- Modal content-->
			      <div class="modal-content">
			        <div class="modal-header">
			          <h4>업무 편집</h4>
			        </div>
			        <div class="modal-body">
			          <form action="${pageContext.request.contextPath}/project/t_update" method="POST">
			          <fieldset>  
			 <!--            <input type="hidden" name="_method" value="PUT"/> -->
			          	<div class="form-group">
			          		<span><strong>담당자</strong></span>
			          		<p class="text-info">
			          			<small class="nhfont_grey tmgrid_edit" ></small>
			          			<input type="hidden" id="tmgrid_edit" name="tmgrid" class="form-control" value="" >
			          			<input type="hidden" id="psrn_edit" name="psrn" value="">
			          			<input type="hidden" id="tsrn_edit" name="tsrn" value="">
			          		</p>
			          		
			          	</div>
			          	<div class="form-group">
			          		<label for="ttitle_edit">업무명</label>
			          		<input type="text" id="ttitle_edit" name="ttitle" class="form-control" value=""> 
			          	</div>
			          	<div class="form-group">
			          		<label for="tcontent_edit">설명</label>
			          		<textarea id="tcontent_edit" name="tcontent" class="form-control" cols="40"  rows="10" ></textarea> 
			          	</div>
			          	<div class="form-group">
			          		<label for="tstate_edit">업무상태</label>
			          		<select id="tstate_edit" name="tstate">
			          			<option value="진행">진행</option>
			          			<option value="완료">완료</option>
			          		</select>
			          		
			          	</div>
			          	<div class="modal-footer">
<!-- 			        	<input type="submit" class="btn btn-basic" id="submit" value="완료" >
			            <input type="button" class="btn btn-basic btn-default" data-dismiss="modal" value="취소"> -->
			            <button type="submit" class="btn overlay_btn" id="submit" >완료</button>
			            <button class="btn overlay_btn2" data-dismiss="modal">취소</button>
			       		</div>
			          </fieldset>
			          </form>
			        </div>
			        
			      </div>
				</div>
				</div>
		
		<div class="col-sm-8 result">
			<div class="container">
				<p>
				<span>업무 보기</span>
<!-- 				<a href="#" class="btn btn-default" id="edit">편집</a>
				<a href="#" class="btn btn-default" id="delete">삭제</a> -->
				<a href="#"  id="edit"><button class="btn overlay_btn2">편집</button></a>
				<a href="#" id="delete"><button class="btn overlay_btn2">삭제</button></a>
				</p>
				<hr/>
				<div>
				<p class="task_state nhfont_green"><small></small></p>
				<p class="nhfont_grey task_mgr"><small></small></p>
					<div class="form-group">
					<p><strong class="nhfontbig task_title"></strong></p>
					<p class="text-right  nhfont_grey task_regdate"><small></small></p>
					</div>
				</div>
				<hr/>
				<div>
					<p class="task_content"></p>
				</div>
				<div class="taskhidden_tsrn" data-tsrn=""></div>
				<div class="hidden_uid" data-uid=""></div>
				
			</div>
		</div>
	</div>
</div>
<script>
$(function() {
	$(".result .container").hide();
	taskDetail();
	taskUpdate();
/* 	taskComplete(); */
/* 	taskDelete(); */
/*
	$("#done_submit").on("click", function() {
		var para = [];
		$("input:checkbox[name='checked']:checked").each(function(i) {
			var check = $(this).val();
			para.push(check);
		});
		var param = { tsrn : para };
		//alert(para);
	 	$.ajax({
			url : "${pageContext.request.contextPath}/t_complete",
			traditional : true,
			data : JSON.stringify({ tsrn : para }) ,
			type : "get",
			contentType : "application/json; charset=UTF-8",
			dataType : "json",
			error : function(xhr, status) { alert(status + "/"); },
			success : function() {
				alert("성공~!");
			}
		}); 
	});
		*/
});

function taskUpdate() {
	$("#edit").on("click", function(){
		var tsrn = $(".taskhidden_tsrn").attr("data-tsrn");
		//alert(tsrn);
		$.ajax({
			url: "${pageContext.request.contextPath}/project/t_update",
			data : {"tsrn" : tsrn} , 
			type:"get",
			contentType : "application/json; charset=UTF-8",
			dataType :"json",
			success : taskUpdateView,
			error : function(xhr, status) { $(".result").html("error"); }
		});
	});
}
function taskUpdateView(json) {
	$("#tmgrid_edit").val(json.task_view.tmgrid);
	$("#psrn_edit").val(json.task_view.psrn);
	$("#ttitle_edit").val(json.task_view.ttitle);
	$("#tcontent_edit").html(json.task_view.tcontent);
	$("#tstate_edit").val(json.task_view.tstate);
	$(".tmgrid_edit ").html(json.task_view.tmgrid);
	$("#tsrn_edit").val(json.task_view.tsrn);
}
function taskDetail () {
	$(".task").on("click", function() {
		//alert("김나형");
		$(".result .container").show();
		var psrn = $(this).closest("tr").find("#hidden_psrn").val();
		var tsrn = $(this).closest("tr").find("#hidden_tsrn").val();
		$.ajax({
			url : "${pageContext.request.contextPath}/project/t_detail",
			data: {"tsrn" : tsrn },
			type: "GET",
			dataType: "json",
			contentType : "application/json; charset=UTF-8",
			success : taskDetailView ,
			error : function() { $(".result").html("error"); }
		});
	});
}
function taskDetailView(json) {
	$(".result .task_title ").html(json.task.ttitle);
	$(".result .task_content").html(json.task.tcontent);
	$(".result .task_mgr small").html(json.task.tmgrid);
	$(".result .task_regdate small").html(json.task.tregdate);
	$(".result .task_state small").html(json.task.tstate);
	$(".result .taskhidden_tsrn").attr("data-tsrn", json.task.tsrn);
	
	var uid = "${userid}";
	if(json.task.tmgrid == uid) {
		$("#delete").attr("href", "${pageContext.request.contextPath}/project/t_delete?no="+json.task.tsrn);
	} else {
		$("#delete, #edit").hide();
		
	}
	
	
	
	
	//alert(   $(".taskhidden_tsrn").attr("data-tsrn")   );
	//$(".result .projecthidden_psrn").html("<input type='hidden' class='hidden_psrn'").val(json.data.psrn);
	//var psrn=json.data.psrn;
}
	
</script>
<script>
$(function(){
  $("#addtask").on("click",function(){
	 $("#addModal").find('form')[0].reset();
    $("#addModal").modal();
	});
/*   $("#edit").on("click", function() {
	 	//alert("김나형");
	    $("#editModal").modal();
	});
*/
});
</script>
<script>
 $(function(){
	$("#edit").on("click", function() {
	   $("#editModal").modal();
	});
});
</script>
 <!-- 알림창 띄우기  -->
<script>
	var result = '${success}';
	console.log(result);
	if(result =="fail_deletetask") {alert("업무 삭제에 실패했습니다."); history.go(-1);}
	else if(result.length != 0) { alert(result); }
</script>
	
<%@ include file="../../inc/footer.jsp" %>