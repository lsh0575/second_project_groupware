<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="../../../inc/header.jsp" %>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

	<div class="container">
		<h3 class="text-center">${param.groupname}</h3>
		<div class="form-group text-right">
		<div class="row">
			<div class="col-sm-6 text-left">
				<h4>그룹 멤버 현황</h4>
			</div>
			<div class="col-sm-4"></div>
			<div class="col-sm-2">
			<input type="hidden" id="hidden_groupno" value="${param.groupno}"/>
			<c:if test="${param.summer_user_userid == sessionScope.userid}">
				<button class="btn overlay_btn btn-block memberAdd" data-toggle="modal" data-target="#invite_selectModal">멤버 초대</button>
			</c:if>
			</div>
		</div>
		</div> 
		<!--  					-->
		<!-- 현재 프로젝트에 소속된 인원 -->
		<!--  					-->
		<table class="table table-bordered">
		    <thead>
		      <tr class="active">
		        <th>NO</th> <th>그룹(조직) 명</th> <th>그룹원</th> <th>직책</th>
		        <th>전화번호</th> <th>가입날짜</th> 
		        <!-- 그룹장이 아니면 멤버 삭제버튼을 볼 수 없음 -->
		        <c:if test="${param.summer_user_userid == sessionScope.userid}">
		        	<th>멤버삭제</th>
		        </c:if>
		      </tr>
		    </thead>
		    <tbody class="memberlist">
		      <c:forEach var="sgroup" items="${gdRead}" varStatus="status">
		      <tr>	
					<td>${gdRead.size() - status.index}</td>
					<td>${sgroup.groupname}</td>
					<td>${sgroup.userid}</td>
					<td>${sgroup.positionlist}</td>
					<td>${sgroup.userphone}</td>
					<td>${sgroup.imList[0].idate}</td>
		        	<!-- 그룹장이 아니면 멤버 삭제버튼을 볼 수 없음 -->
					<c:if test="${param.summer_user_userid == sessionScope.userid}">
						<td>
						<!-- 멤버 삭제 버튼 -->
						<%-- 	<input type="button" class="btn btn-basic memberDelete" value="멤버 삭제" data-userid="${sgroup.userid}"> --%>
							<button type="button" class="btn overlay_btn memberDelete" data-userid="${sgroup.userid}">멤버 삭제</button>
						</td>
					</c:if>
		      </tr>
		      </c:forEach>
		    </tbody>
		  </table>
		  <div class="row groupDetailBtn">
			<div class="col-sm-4"> 
			  <c:if test="${param.summer_user_userid == sessionScope.userid}">
				<a href="${pageContext.request.contextPath}/group/gUpdate?groupno=${param.groupno}"><button class="btn overlay_btn btn-block">그룹명 수정</button></a>
			  </c:if>	
			</div>
			<div class="col-sm-4"> <a  href="${pageContext.request.contextPath}/group/gmReadAll"><button class="btn overlay_btn2 btn-block">목 록</button></a> </div>
			<div class="col-sm-4">
			  <c:if test="${param.summer_user_userid == sessionScope.userid}">	
				<a   href="${pageContext.request.contextPath}/group/gDelete?groupno=${param.groupno}"><button class="btn overlay_btn btn-block">그룹 삭제</button></a> 
			  </c:if>
			</div>
		  </div>
		<!--  					  -->
		<!-- 현재 프로젝트에 소속된 인원 끝 -->
		<!--  					  -->
		
		<!-- 				    -->
		<!--  프로젝트 초대 리스트 시작 -->
		<!--  			        -->
		<div class="form-group text-right">
		<div class="row">
			<div class="col-sm-6 text-left"><h4>멤버 초대 현황</h4></div>
			<div class="col-sm-6"></div>
		</div>
		</div> 
		<table class="table table-bordered">
		    <thead>
		      <tr class="active">
		        <th scope="col">NO</th> 
		        <th scope="col">그룹(조직) 명</th> 
		        <th scope="col">담당자</th> 
		        <th scope="col">직책</th> <th>전화번호</th>
		        <th scope="col">가입날짜</th> <th>초대수락여부</th>
		        <!-- 그룹장이 아니면 초대취소 버튼을 볼 수 없음 -->
		        <c:if test="${param.summer_user_userid == sessionScope.userid}">
		        	<th>초대취소</th>
		        </c:if>
		      </tr>
		    </thead>
		    <tbody>
		     <c:forEach var="sgroup" items="${gdRead2}" varStatus="status">
		      <tr>
			    <td>${gdRead2.size() - status.index}</td>
			    <td>${sgroup.groupname}</td>
			    <td>${sgroup.userid}</td>
			    <td>${sgroup.positionlist}</td>
			    <td>${sgroup.userphone}</td>
			    <td>${sgroup.imList[0].iaccept}</td>
			    <td>${sgroup.imList[0].idate}</td>
		        <!-- 그룹장이 아니면 초대취소 버튼을 볼 수 없음 -->
			    <c:if test="${param.summer_user_userid == sessionScope.userid}">
				    <td>
<%-- 				      <input type="button" class="btn btn-basic inviteCancel" value="초대 취소" data-userid="${sgroup.userid}"> --%>
				      <button type="button" class="btn overlay_btn inviteCancel" data-userid="${sgroup.userid}">초대 취소</button>
				    </td>
			    </c:if>
		      </tr>
		      </c:forEach>
		    </tbody>
		  </table>
		<!-- 				    -->
		<!--  프로젝트 초대 리스트 끝  -->
		<!--  			        -->
		
		<!--  		MODAL	START		-->
		<!--  		MODAL	START		-->
		<!--  		MODAL	START		-->
		<!--		 모달 				-->
		<!-- 모달 내용 추가 -->
		<div class="modal fade" id="invite_selectModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		        <h4 class="modal-title" id="myModalLabel">멤버 초대</h4>
		      </div>
		      <div class="modal-body">
		        <table class="table table-bordered">
		          <thead>
		            <tr>
		              <th>아이디</th>
		              <th>수락/거절</th>
		              <!-- 필요한 추가 정보들 -->
		            </tr>
		          </thead>
		          <tbody class="result1"> </tbody>
		        </table>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn overlay_btn2 modal_close" data-dismiss="modal">닫기</button>
		      </div>
		    </div>
		  </div>
		</div>
		<!--  		MODAL	END		-->
		<!--  		MODAL	END		-->
		<!--  		MODAL	END		-->
		
	<script>
	function deleteGroup(userid) {
	    if (confirm('그룹을 삭제하시겠습니까?')) {
	        var form = document.createElement('form');
	        form.setAttribute('method', 'post');
	        form.setAttribute('action', '${pageContext.request.contextPath}/group/gDelete');
	
	        var input = document.createElement('input');
	        input.setAttribute('type', 'hidden');
	        input.setAttribute('name', 'summer_user_userid');
	        input.setAttribute('value', userid);
	
	        form.appendChild(input);
	        document.body.appendChild(form);
	
	        form.submit();
	    }
	}
	</script>
	
	<!-- JavaScript 코드 추가 -->
	<script>
	$(document).ready(function() {
	  $(".memberAdd").click(function() {
	    $.ajax({
	      url: "${pageContext.request.contextPath}/account/loadNonGroupMembers",
	      type: "GET",
	      dataType: "json",
	      success: function(json) {
	        for (var i = 0; i < json.length; i++) {
	          var id = json[i];
	          var tr =  $("<tr>");
	          var td1 = $("<td>").html(id);
	          var td2 = $("<td>").html("<button class='inviteBtn btn overlay_btn'>초대</button>");
	          tr.append(td1).append(td2);
	          $(".result1").append(tr);
	        }
	
	        // 모달 창 열기
	        $("#invite_selectModal").modal("show");
	      },
	      error: function(xhr, status, error) {
	        console.error(error);
	      }
	    });
	  });
	
	  // 초대 버튼 클릭 시 이벤트 처리
	  $(document).on("click", ".inviteBtn", function() {
	    var uid = $(this).closest("tr").find("td:first").text();
	    var pgsrn = $("#hidden_groupno").val();
	    $.ajax({
	      url: "${pageContext.request.contextPath}/invit/inviteInsert",	
	      type: "GET",
	      data: { "uid" : uid, "pgsrn": pgsrn },
	      success: function(response) {
	        alert("멤버가 초대 되었습니다.");
	      },
	      error: function(xhr, status, error) {
	        console.error(error);
	        alert('초대에 실패 하였습니다.');
	      }
	    });
	  });
	  
	  // 모달 닫기 버튼 클릭 시 페이지 새로고침을 통해 멤버 초대 현황에 ID 찍히게 처리
	  $(document).on("click", ".modal_close", function() {
	    location.reload();
	  });
	  
	});
	
	// 멤버 삭제 버튼 클릭 시 이벤트 처리
	$(document).ready(function() {
	  $(document).on("click", ".memberDelete", function() {
		  //alert("test");
	    var uid = $(this).data("userid");
	    var pgsrn = "${param.groupno}";
	    $.ajax({
	      url: "${pageContext.request.contextPath}/invit/inviteDelete?uid="+uid+"&pgsrn="+pgsrn,
	      type: "DELETE",
	      //data: { "uid": uid, "pgsrn": pgsrn},
	      success: function(json) {
	        // 멤버 삭제 성공 시 행을 제거하거나 화면을 새로고침할 수 있습니다.
	        alert("멤버가 삭제되었습니다.");
	        location.reload(); // 화면 새로고침
	      },
	      error: function(xhr, status, error) {
	        console.error(error);
	      }
	    });
	  });
	});
	
	// 초대 취소 버튼 클릭 시 이벤트 처리
	$(document).ready(function() {
	  $(document).on("click", ".inviteCancel", function() {
		  //alert("test");
	    var uid = $(this).data("userid");
	    var pgsrn = "${param.groupno}";
	    $.ajax({
	      url: "${pageContext.request.contextPath}/invit/inviteDelete?uid="+uid+"&pgsrn="+pgsrn,
	      type: "DELETE",
	      //data: { "uid": uid, "pgsrn": pgsrn},
	      success: function(json) {
	        // 멤버 삭제 성공 시 행을 제거하거나 화면을 새로고침할 수 있습니다.
	        alert("초대가 취소되었습니다.");
	        location.reload(); // 화면 새로고침
	      },
	      error: function(xhr, status, error) {
	        console.error(error);
	      }
	    });
	  });
	});
	</script>
	</div>
</body>

<%@ include file="../../../inc/footer.jsp" %>