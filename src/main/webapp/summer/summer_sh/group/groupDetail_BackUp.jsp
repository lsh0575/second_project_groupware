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
			<button class="btn overlay_btn btn-block memberAdd" data-toggle="modal" data-target="#invite_selectModal">멤버 초대</button>
				<!-- ${pageContext.request.contextPath}/group/inviteInsert?groupname=${param.groupname} -->
			</div>
		</div>
		</div> 
		<!--  					-->
		<!-- 현재 프로젝트에 소속된 인원 -->
		<!--  					-->
		<table class="table table-bordered">
		    <thead>
		      <tr class="active">
		        <th>NO</th> <th>그룹(조직) 명</th> <th>담당자</th> <th>직책</th>
		        <th>전화번호</th> <th>가입날짜</th> <th>멤버삭제</th>
		      </tr>
		    </thead>
		    <tbody>
		      <c:forEach var="sgroup" items="${gdRead}" varStatus="status">
		      <tr>	
					<td>${gdRead.size() - status.index}</td>
					<td>${sgroup.groupname}</td>
					<td>${sgroup.userid}</td>
					<td>${sgroup.positionlist}</td>
					<td>${sgroup.userphone}</td>
					<td>${sgroup.imList[0].idate}</td>
					<td>
<!-- 					<input type="button" id="gdCancle" name="gdCancle" value="멤버 삭제" class="btn btn-basic"> -->
					<button type="button" id="gdCancle" name="gdCancle" class="btn overlay_btn">멤버 삭제</button>
					</td>
		      </tr>
		      </c:forEach>
		    </tbody>
		  </table>
		  <div class="row groupDetailBtn">
			<div class="col-sm-4"> <a  href="${pageContext.request.contextPath}/group/gUpdate?groupno=${param.groupno}"><button type="button" class="btn overlay_btn btn-block">그룹명 수정</button></a></div>
			<div class="col-sm-4"> <a  href="${pageContext.request.contextPath}/group/gmReadAll"><button type="button" class="btn overlay_btn2 btn-block" >목 록</button></a> </div>
			<div class="col-sm-4"> <a  href="${pageContext.request.contextPath}/group/gDelete?groupno=${param.groupno}"><button type="button" class="btn overlay_btn btn-block" >그룹 삭제</button></a> </div>
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
		        <th>NO</th> 
		        <th>그룹(조직) 명</th> 
		        <th>담당자</th> 
		        <th>직책</th> <th>전화번호</th>
		        <th>가입날짜</th> <th>초대수락여부</th> <th>초대취소</th>
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
			    <td>
<!-- 			      <input type="button" id="sg2Cancle" name="sg2Cancle" value="초대 취소" class="btn btn-basic"> -->
			      <button type="button" id="sg2Cancle" name="sg2Cancle" class="btn overlay_btn2">초대 취소</button>
			    </td>
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
<!--           <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button> -->
          <button type="button" class="btn overlay_btn2" data-dismiss="modal">닫기</button>
          <!-- 필요한 버튼들 -->
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
	
	<script>
$(document).ready(function() {
  $(".memberAdd").click(function() {
    $.ajax({
      url: "${pageContext.request.contextPath}/account/loadNonGroupMembers",
      type: "GET",
      dataType: "json",
      success: function(json) {
    	console.log('json ->' + json);

        // 데이터를 가지고 모달 창에 표시하는 로직을 작성
        // var modalBody = $("#invite_selectModal .modal-body");
        // modalBody.empty(); // 모달 내용 초기화

        // 데이터를 순회하며 행을 생성하여 모달에 추가
        for (var i = 0; i < json.length; i++) {
        var id = json[i];
        // console.log('..........' + id);
        var tr =  $("<tr>");
        var td1 = $("<td>").html(id);
        var td2 = $("<button type='button' class='btn overlay_btn'>")
          /* var row = "<tr>" +
            "<td>" + json[i].userid + "</td>" +
            "<td>" + json[i].username + "</td>"; */
          /* modalBody.append(row); */
        tr.append(td1).append(td2); /* 버튼 및 링크 추가 */
        $(".result1").append(tr); 

        }

        // 모달 창 열기
        $("#invite_selectModal").modal("show");
      },
      error: function(xhr, status, error) {
        // 에러 처리
        console.error(error);
      }
    });
  });
});
</script>
	
	</div>
</body>

<%@ include file="../../../inc/footer.jsp" %>