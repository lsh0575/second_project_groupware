<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../inc/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class = "mtotal">
	<h3 id="h3bold">PROJECT</h3>
	<div class="row">
		<div class="col-sm-4 nhpanel">
		<c:set var="psrn" value=""/>
			<table class="table table-hover">
			<tbody>
				<tr class="text-right nhbtn"><td colspan="4"><!-- <input type="button" class="btn btn-basic" value="프로젝트 추가" id="addproject" > -->
				<a href="#" id="addproject"><button class="btn overlay_btn"  >프로젝트 추가</button>	</a>
				</td></tr>
				<c:forEach var="i" items="${list}"  varStatus="status">
					<tr>
						<th scope="row">${list.size()-status.index}</th>
						<td><a href="#" class="project">${i.ptitle}</a></td>
						<td><input type="hidden"  class="hidden_psrn" value="${i.psrn}">
						<td><input type="hidden"  class="hidden_pstate" value="${i.pstate}">
					</tr>
				</c:forEach>
			</tbody>
			</table>
			  <!-- Modal -->
			  <div class="modal fade" id="addModal" role="dialog">
			    <div class="modal-dialog  modal-lg">
			    
			      <!-- Modal content-->
			      <div class="modal-content">
			        <div class="modal-header">
			          <h4>프로젝트 추가</h4>
			        </div>
			        <div class="modal-body">
			          <form action="${pageContext.request.contextPath}/project/p_insert" method="post">
			          <fieldset>
			          	<div class="form-group">
			          		<input type="hidden" id="pmgrid" name="pmgrid" value="${userid}"/>
			          		<label for="pstartdate">프로젝트 시작</label>
			          		<input type="date" id="pstartdate" name="pstartdate">
			           		<label for="penddate">프로젝트 종료</label>
			          		<input type="date" id="penddate" name="penddate">
			          	</div>
			          	<div class="form-group">
			          		<label for="ptitle">프로젝트명</label>
			          		<input type="text" id="ptitle" name="ptitle" class="form-control"> 
			          	</div>
			          	<div class="form-group">
			          		<label for="pcontent">설명</label>
			          		<textarea id="pcontent" name="pcontent" cols="40"  rows="10"   class="form-control"></textarea> 
			          	</div>
			          	<div class="form-group">
			          		<label for="pstate">진행상태</label>
			          		<select id="pstate" name="pstate">
			          			<option  value="진행">진행</option>
			          			<option  value="지연">지연</option>
			          			<option  value="미진행">미진행</option>
			          		</select> 
			          	</div>
			          	<div class="modal-footer">
				       <!--  	<input type="submit" class="btn btn-basic" id="submit" value="완료" > -->
				     <!--        <input type="button" class="btn btn-basic btn-default" data-dismiss="modal" value="취소"> -->
				           	<button type="submit" class="btn overlay_btn" id="submit" >완료</button>
				            <button class="btn overlay_btn2" data-dismiss="modal">취소</button>
			        	</div>
			          </fieldset>
			          </form>
			        </div>
			        
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
					          <h4>프로젝트 편집</h4>
					        </div>
					        <div class="modal-body">
					          <form action="${pageContext.request.contextPath}/project/p_update" method="post">
					          <fieldset>
					         	<!-- <input type="hidden" name="_method" value="PUT"/> -->
					          	<div class="form-group">
					          		<input type="hidden" id="psrn_edit" name="psrn" value=""/>
					          		<label for="pstartdate_edit">프로젝트 시작</label>
					          		<input type="date" id="pstartdate_edit" name="pstartdate" value="">
					          		
					          		<label for="penddate_edit">프로젝트 종료</label>
					          		<input type="date" id="penddate_edit" name="penddate" value="">
					          	</div>
					          	<div class="form-group">
					          		<label for="ptitle_edit">프로젝트명</label>
					          		<input type="text" id="ptitle_edit" name="ptitle" class="form-control" value=""> 
					          	</div>
					          	
					          	<div class="form-group">
					          		<label for="pcontent_edit">설명</label>
					          		<textarea id="pcontent_edit" name="pcontent" cols="40"  rows="10" class="form-control"></textarea> 
					          	</div>
					          	<div class="form-group">
					          		<label for="pstate_edit">진행상태</label>
					          		<select id="pstate_edit" name="pstate">
					          			<option  value="진행">진행</option>
					          			<option  value="지연">지연</option>
					          			<option  value="미진행">미진행</option>
					          		</select> 
					          	</div>
					          	<div class="modal-footer">
						<!--         	<input type="submit" class="btn btn-basic" id="submit" value="수정" > -->
					<!-- 	            <input type="button" class="btn btn-basic btn-default" data-dismiss="modal" value="취소"> -->
					        	<button type="submit" class="btn overlay_btn" id="submit" >수정</button>
						            <button class="btn overlay_btn2" data-dismiss="modal">취소</button>
					        	</div>
					          </fieldset>
					          </form>
					        </div>
					        
					      </div>
					      
					    </div>
						</div>
						<div class="modal fade" id="inviteModal" role="dialog">
							    <div class="modal-dialog   modal-lg">
							    
							      <!-- Modal content-->
							      <div class="modal-content">
							        <div class="modal-header">
							          <h4>멤버 초대</h4>
							        </div>
							        <div class="modal-body">
							        <p class="text-right"><!-- <input type="button" id="invite_select"class="btn btn-basic btn-xs" value="멤버 초대"> -->
							        <button id="invite_select" class="btn overlay_btn2">멤버 초대</button>
							        
							        </p>
							          <table class="table table-hover invitemembertable">
							          <caption>초대된 멤버</caption>
							          <tbody>
							          </tbody>
							          </table>
							        </div>
							        <div class="modal-footer">
		<!-- 					        	<input type="button" class="btn btn-basic" id="done" data-dismiss="modal" value="완료" >
							            <input type="button" class="btn btn-basic btn-default" data-dismiss="modal" value="취소"> -->
							          <button  class="btn overlay_btn" id="done" data-dismiss="modal">완료</button>
							           <button  class="btn overlay_btn2" data-dismiss="modal" >취소</button>
							        </div>
							      </div>
							    </div>
					</div>
				<div class="modal fade" id="invite_selectModal" role="dialog">
							    <div class="modal-dialog   modal-sm">
							    
							      <!-- Modal content-->
							      <div class="modal-content">
							        <div class="modal-header">
							          <h4>멤버 초대</h4>
							        </div>
							        <div class="modal-body">
							          <table class="table table-striped memberlist">
							          <caption>전체 멤버</caption>
							          <tbody>
							        	
							          </tbody>
							          </table>
							        </div>
							        <div class="modal-footer">
					<!-- 		        	<input type="submit" class="btn btn-basic" id="submit" data-dismiss="modal" value="완료" > -->
							       <!--      <input type="button" class="btn btn-basic btn-default" data-dismiss="modal" value="취소"> -->
							       <button type="submit" class="btn overlay_btn" id="submit" data-dismiss="modal" >완료</button>
							            <button  class="btn overlay_btn2" data-dismiss="modal" >취소</button>
							        </div>
							      </div>
							      
							    </div>
				</div>
		<div class="col-sm-8  result">
			 <div class="container">
				<p>
				<span>프로젝트 보기</span>
				<a href="#" class="btn overlay_btn2" id="edit">편집</a>
				</p>
				<hr/>
				<div>
				<p class="project_state nhfont_green"><small></small></p>
				<p class="nhfont_grey project_mgr"><small></small></p>
					<div class="form-group">
					<p><strong class="nhfontbig project_title"></strong></p>
					<p class="text-right  nhfont_grey project_regdate"><small></small></p>
					</div>
				</div>
				<hr/>
				<div>
					<p class="project_content"></p>
				</div>
				<div class="projecthidden_psrn" data-psrn=""></div>
				<div class="hidden_uid" data-uid=""></div>
				<div class="projecthidden_pstate" data-pstate=""></div>
				<div class="text-right sub_task">
<!-- 					<input type="button" id="invite" value="멤버 초대" class="btn btn-default"> -->
					<button id="invite" class="btn overlay_btn">멤버 초대</button>
					<a href="#"  id="task_psrn" ><button class="btn overlay_btn">업무</button></a>
				</div>
			</div>
		</div>

	</div>
</div>

<script>
$(function() {
	$(".result	 .container").hide();
	projectDetail();
	projectUpdate();	
	inviteMemberList();
	memberList();
	invite();
	deletemember();
});
function deletemember() {
	$(".invitemembertable tbody").on("click", ".deletememberBtn", function() {
		//alert("버튼 입력");
		var uid = $(this).closest("tr").find("#uid").val();
		var pgsrn = $(".projecthidden_psrn").attr("data-psrn");
		console.log("......delete......."+uid);
		console.log("......delete......."+pgsrn);
		$.ajax({
			url : "${pageContext.request.contextPath}/project/delete?uid="+uid+"&pgsrn=" + pgsrn,
			//data : JSON.stringify ({uid : uid , pgsrn : pgsrn}) ,
			type : "get",
			dataType : "json",
			contentType : "application/json; charset=UTF-8",
			success : function(json) {
				alert(json.success);
			}
		});
	});
}
function invite () {
	$(".memberlist").on("click", "#inviteBtn", function() {
		//alert("dkdkdk");
		var uid = $(this).closest("tr").find(".userid").text();
		var pgsrn = $(".projecthidden_psrn").attr("data-psrn");
		//console.log(uid);
		//console.log(pgsrn);
		$.ajax({
			url : "${pageContext.request.contextPath}/project/invite?uid=" + uid + "&pgsrn=" + pgsrn,
			type : "get",
			dataType : "json",
			contentType : "application/json; charset=UTF-8",
			success : function(json) {
				var msg = json.success;
				alert(msg);
			},
			error : function(xhr, status, msg) {
				alert(status + "/" + msg);
			}
			});
	});
} 
function memberList() {
	$("#invite_select").on("click", function () {
		var pgsrn = $(".projecthidden_psrn").val();
		//alert(pgsrn);
		$.ajax({
			url : "${pageContext.request.contextPath}/project/memberlist?psrn="+ pgsrn,
			type: "get",
			dataType:"json",
			contentType : "application/json; charset=UTF-8",
			success: memberlistView,
			error : function(xhr, status) {
				alert(status + "/");
			}
		});
	});
}

function memberlistView(json) {
	$(".memberlist tbody").empty();
	console.log(json.memberlist);
	console.log($(".projecthidden_psrn").attr("data-psrn") );
	$.each(json.memberlist , function(idx, member) {
		$("<tr>").append($("<th scope='row'>"))
				 .append( $("<p>").html(member.username + "<small class='nhfont_grey userid'>" + member.userid + "</small>") )
 				 .append( $("<p class='nhfont_grey'>").html("<small>" + member.useremail +"</small>"   ) )
/*  				 .append(  $("<input type='hidden' name='pgsrn' id='pgsrn' >").html( $(".projecthidden_psrn").attr("data-psrn")   )   ) */
 				 .append(  $("<td>") )
/* 				 .append(  $("<a href='${pageContext.request.contextPath}/project/invite?uid="+member.userid+"&pgsrn="+ $(".projecthidden_psrn").attr("data-psrn") +"' title='invite' class='btn btn-default btn-xs'>").html("초대") )  	*/
				.append(  $("<a href='#' title='invite' id='inviteBtn' class='btn btn-default btn-xs'>").html("초대")  )
 				.appendTo(".memberlist tbody");
	});
}
function inviteMemberList() {
	$("#invite").on("click", function () {
		var pgsrn = $(".projecthidden_psrn").val();
		$.ajax({
			url : "${pageContext.request.contextPath}/project/invitememberlist?psrn=" + pgsrn,
			type: "get",
			dataType :"json",
			contentType:"application/json; charset=UTF-8",
			success : invitememeberlistView	 ,
			error : function(xhr, status) { alert(status +"/"); }
		});
	});
}
function invitememeberlistView(json) {
	
	//$("#inviteModal").find(".invitemembertable #nhnh").html(json.member);
	//var memberlist = json['memberlist'];
	$(".invitemembertable tbody").empty();
	$("<tr class='nhfont_bold'>").append( $("<th scope='row'>").html()   )
			 .append( $("<td>").html("프로젝트장")  )
			 .append(  $("<td colspan='2'>").html("${userid}")   )
			 .appendTo(".invitemembertable tbody");
		$.each(json.member , function(idx, member)	{
			$("<tr>").append(  $("<th scope='row'>").html() )
					 .append(  $("<td>").html(member.username)  )
					 .append(  $("<td>").html( $("<small class='nhfont_grey'>").html(member.userid +"/" + member.useremail) ) )
					 .append(   $("<input type='hidden' id='uid' name='uid'/>").val(member.userid)     )
					 .append(   $("<input type='hidden' id='pgsrn' name='pgsrn'/>").val(member.pgsrn)     )
					/*  .append(  $("<td>").html( $("<a href='${pageContext.request.contextPath}/project/delete?uid="+member.userid+"&pgsrn="+member.pgsrn+"' id='nh_imgsize' title='deletemember'>").html("<img src='${pageContext.request.contextPath}/resources/img/delete.png' alt='delete.png'/>") ) ) */
					 .append(  $("<td>").html( $("<a href='#' id='nh_imgsize' class='deletememberBtn' title='deletemember'>").html("<img src='${pageContext.request.contextPath}/resources/img/delete.png' alt='delete.png'/>") ) )
					 .appendTo(".invitemembertable tbody");
					/* 	console.log(json.member.userid + " ==> userid");
						console.log(json.member.pgsrn  + "==> pgsrn");
						console.log(json.member.uid    + "==> uid");
						console.log(json.member.useremail    + "==> useremail"); */
		});
}
function projectDetail() {
	$(".project").on("click", function() {
		$(".result .container").show();
		var psrn= $(this).closest("tr").find(".hidden_psrn").val();
		$(".projecthidden_psrn").attr("data-psrn", psrn);
		//console.log(psrn);
		$.ajax({
			url : "${pageContext.request.contextPath}/project/p_detail?psrn="+psrn ,
			type:"GET",
			dataType: "json",
			contentType : "application/json; charset=UTF-8",
			success : projectDetailResult, 
			error : function(xhr, status) { alert(status +"/"); }
		});
	});
}
function projectDetailResult(json) {

	$(".result .project_title ").html(json.data.ptitle);
	$(".result .project_content").html(json.data.pcontent);
	$(".result .project_mgr small").html(json.data.pmgrid);
	$(".result .project_regdate small").html(json.data.pregdate);
	$(".result .project_state small").html(json.data.pstate);
	var pstate = json.data.pstate;
	//console.log(pstate);
	
	if(pstate != "미진행") {
	
		var memberid = [];
		for(var i=0; i<json.memberlist.length; i++) {
			memberid.push(json.memberlist[i].userid);
		}
		
		
		var uid= "${userid}";
		//console.log(uid);
		var result_task="false";
		for(var i of memberid ) {
			if( i  == uid ) { result_task = "true"; }
		}
		if(result_task == "true") {
			$("#task_psrn").show();
			$("#task_psrn").attr("href", "${pageContext.request.contextPath}/project/t_list?psrn="+json.data.psrn );
		} else {
			$("#task_psrn").hide();
		}
		
		var result_pmgr = "false";
		if(json.data.pmgrid == uid) {
			$("#edit , #invite").show();
			$("#task_psrn").show();
			$("#task_psrn").attr("href", "${pageContext.request.contextPath}/project/t_list?psrn="+json.data.psrn );
		} else {
			$("#edit , #invite").hide();
		}

	} else if(pstate == "미진행") {
		$("#edit , #invite").hide();
		$("#task_psrn").hide();
	}
	

	//uid랑 psrn넘겨줘야 
	$(".result .projecthidden_psrn").html("<input type='hidden' class='hidden_psrn'").val(json.data.psrn);
	var psrn=json.data.psrn;

}

function projectUpdate() {
	$("#edit").on("click", function	() {
		var psrn= $(".projecthidden_psrn").val();
		//alert(psrn);
		$.ajax({
			url: "${pageContext.request.contextPath}/project/p_update?psrn=" + psrn, 
			type: "get", 
			contentType:"application/json; charset=UTF-8",
			dataType: "json",
			success: projectUpdateView,
			error :  function(xhr, status) { alert(status +"/"); }
		});
	});
}
function projectUpdateView(json) {
	$("#editModal #psrn_edit").val(json.data.psrn);
	$("#editModal #pstartdate_edit").val(json.data.pstartdate);
	$("#editModal #penddate_edit").val(json.data.penddate);
	$("#editModal #ptitle_edit").val(json.data.ptitle);
	$("#editModal #pcontent_edit").html(json.data.pcontent);
}
</script>
 <script>
		$(function() {
			$("#addproject").on("click", function() {
				//모달안의 내용 비우기
				
				$("#addModal").modal();
				$("#addModal").find('form')[0].reset();
				
			});
			$("#edit").on("click",function() {
				$("#editModal").modal();
			});
			$("#invite").on("click",  function() {
				
			   	$("#inviteModal").modal();
			});
			$("#invite_select").on("click", function() {
				$("#invite_selectModal").modal();
			});
		});
	</script>
	<!-- 알림창 띄우기  -->
	<script>
		var result = '${success}';
		console.log(result);
		if(result =="fail_deleteMember") {alert("멤버 삭제에 실패했습니다."); history.go(-1);}
		else if(result.length != 0) { alert(result); }
</script>
<%@ include file="../../inc/footer.jsp" %>