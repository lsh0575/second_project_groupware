<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../inc/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="mtotal">
<h3 id="h3bold">PROJECT</h3>
	<p>
	<span>프로젝트 보기</span>
	<a href="#" class="btn btn-default" id="edit">편집</a>
	</p>
	<hr/>
	<div>
	<p class="project_state nhfont_green">
		<small>${data.pstate}</small>
		<span id="projectschedule">${data.pstartdate} ~ ${data.penddate}</span>
	</p>
	
	<p class="nhfont_grey project_mgr"><small>${data.pmgrid}</small></p>
		<div class="form-group">
		<p><strong class="nhfontbig project_title">${data.ptitle}</strong></p>
		<p class="text-right  nhfont_grey project_regdate"><small>${data.pregdate}</small></p>
		</div>
	</div>
	<hr/>
	<div>
		<p class="project_content">${data.pcontent}</p>
	</div>
	<div class="projecthidden_psrn" data-psrn="${data.psrn}"></div>
	<div class="hidden_uid" data-uid=""></div>
	<div class="text-right sub_task">
<!-- 		<input type="button" id="invite" value="멤버 초대" class="btn btn-default"> -->	
	<a href="#" id="invite"><button class="btn overlay_btn">멤버 초대</button></a>
		
		<a href="#"  id="task_psrn" class="btn btn-default">업무</a>
	</div>
</div>


<!--            -->
<div class="modal fade" id="editModal" role="dialog">
    <div class="modal-dialog  modal-lg">
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <h4>프로젝트 편집</h4>
        </div>
        <div class="modal-body">
          <form action="${pageContext.request.contextPath}/calendar/project_update" method="post">
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
          		<textarea id="pcontent_edit" name="pcontent" class="form-control"></textarea> 
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
	        	<input type="submit" class="btn btn-basic" id="submit" value="수정" >
	            <input type="button" class="btn btn-basic btn-default" data-dismiss="modal" value="취소">
        	</div>
          </fieldset>
          </form>
        </div>
        
      </div>
      
    </div>
</div>

<!--                  -->
<div class="modal fade" id="inviteModal" role="dialog">
			    <div class="modal-dialog   modal-lg">
			    
			      <!-- Modal content-->
			      <div class="modal-content">
			        <div class="modal-header">
			          <h4>멤버 초대</h4>
			        </div>
			        <div class="modal-body">
			        <p class="text-right"><input type="button" id="invite_select"class="btn btn-basic btn-xs" value="멤버 초대"></p>
			          <table class="table table-hover invitemembertable">
			          <caption>초대된 멤버</caption>
			          <tbody>
			          </tbody>
			          </table>
			        </div>
			        <div class="modal-footer">
			        	<input type="button" class="btn btn-basic" id="done" data-dismiss="modal" value="완료" >
			            <input type="button" class="btn btn-basic btn-default" data-dismiss="modal" value="취소">
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
			        	<input type="submit" class="btn btn-basic" id="submit" data-dismiss="modal" value="완료" >
			            <input type="button" class="btn btn-basic btn-default" data-dismiss="modal" value="취소">
			        </div>
			      </div>
			      
			    </div>
</div>

<script>
$(function() {
	projectUpdate();	
	inviteMemberList();
	memberList();
	invite();
});
function projectUpdate() {
	$("#edit").on("click", function	() {
		var psrn= $(".projecthidden_psrn").attr("data-psrn");
		//alert(psrn);
		$.ajax({
			url: "${pageContext.request.contextPath}/calendar/project_update?psrn=" + psrn, 
			type: "get", 
			contentType:"application/json; charset=UTF-8",
			dataType: "json",
			success: projectUpdateView,
			error :  function(xhr, status) { alert(status +"/"); }
		});
	});
}
function projectUpdateView(json) {
	console.log(json.data);
	$("#editModal #psrn_edit").val(json.data.psrn);
	$("#editModal #pstartdate_edit").val(json.data.pstartdate);
	$("#editModal #penddate_edit").val(json.data.penddate);
	$("#editModal #ptitle_edit").val(json.data.ptitle);
	$("#editModal #pcontent_edit").html(json.data.pcontent);
}
function memberList() {
	$("#invite_select").on("click", function () {
		var pgsrn = $(".projecthidden_psrn").attr("data-psrn");
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
 				 .append(  $("<a href='#' id= 'inviteBtn' title='invite' class='btn btn-default btn-xs'>").html("초대") ) 
 				 .appendTo(".memberlist tbody");
	});
}
function invite () {
	$(".memberlist").on("click","#inviteBtn", function() {
		var uid = $(this).closest("tr").find(".userid").text();
		var pgsrn = $(".projecthidden_psrn").attr("data-psrn");
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
function inviteMemberList() {
	$("#invite").on("click", function () {
		var pgsrn = $(".projecthidden_psrn").attr("data-psrn");
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
					 .append(  $("<td>").html( $("<a href='${pageContext.request.contextPath}/calendar/project_delete?uid="+member.userid+"&pgsrn="+member.pgsrn+"' id='nh_imgsize' title='deletemember'>").html("<img src='${pageContext.request.contextPath}/resources/img/delete.png' alt='delete.png'/>") ) )
					 .appendTo(".invitemembertable tbody");
	console.log(json.member.userid + " ==> userid");
	console.log(json.member.pgsrn  + "==> pgsrn");
	console.log(json.member.uid    + "==> uid");
	console.log(json.member.useremail    + "==> useremail");
		});
}
$(function() {
	var psrn = $(".projecthidden_psrn").attr("data-psrn");
	
	var result_member = "${result_member}";
	var result_mgr = "${result_mgr}";

	$("#task_psrn").hide();
	$("#edit , #invite").hide();
	
	
	if("${data.pstate}" != "미진행") {
		//var memberid = [];
	/* 	for(var i=0; i<${memberlist.size()}; i++) {
			memberid.push(json.memberlist[i].userid);
		} */
		
		
		var uid= "${userid}";
		//console.log(uid);
		//var result_task="false";
		/* for(var i of memberid ) { if( i  == uid ) { result_task = "true"; } } */
		
		if("${result_member}" == "true") {
			$("#task_psrn").show();
			$("#task_psrn").attr("href", "${pageContext.request.contextPath}/project/t_list?psrn="+json.data.psrn );
		} else {
			$("#task_psrn").hide();
		}
		
		if("${result_mgr}" == uid) {
			$("#edit , #invite").show();
			$("#task_psrn").show();
			$("#task_psrn").attr("href", "${pageContext.request.contextPath}/project/t_list?psrn="+json.data.psrn );
		} else {
			$("#edit , #invite").hide();
		}

	} else if( "${data.pstate}" == "미진행") {
		$("#edit , #invite").hide();
		$("#task_psrn").hide();
	}
	
	
	
	
	/* if(result_mgr == "true" ) {
		$("#edit , #invite").show();
		$("#task_psrn").show();
		$("#task_psrn").attr("href", "${pageContext.request.contextPath}/project/t_list?psrn="+psrn );
	}
	if (result_member == "true") {
		$("#edit , #invite").hide();
		$("#task_psrn").show();
		$("#task_psrn").attr("href", "${pageContext.request.contextPath}/project/t_list?psrn="+psrn );
	}  */
});

</script>
 <script>
	$(function() {
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
<%@ include file="../../inc/footer.jsp" %>