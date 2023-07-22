<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../../inc/header.jsp"%>

<!-- 회원탈퇴 폼 -->
<div class="container body-top">

	<form action="<%-- ${pageContext.request.contextPath}/account/uDelete --%>"
		method="post" id="form">
		<fieldset>
			<legend class="text-center">${sessionScope.userid}님 회원 탈퇴 페이지</legend>
			<input type="hidden" name="userid" value="${sessionScope.userid}" class="form-control" />
			<div class="form-group">
				<strong>회원 탈퇴를 원하시면 비밀번호를 입력해주세요.</strong>
			</div>
			<div class="form-group">
				<label for="inputPass">비밀 번호 입력(*)</label>
				<input type="password" class="form-control" id="inputPass" name="userpass" placeholder="비밀번호를 입력해주세요" />
			</div>
			<div class="form-group text-center">
				<div class="col-sm-6">
		<!-- 			<input type="submit" class="btn btn-success btn-block" value="확인" /> -->
					<button type="submit" class="btn overlay_btn btn-block" >확인</button>
				</div>
				<div class="col-sm-6">
					<button type="button" class="btn overlay_btn2 btn-block" onclick="javascript:history.go(-1)">취소</button>
				</div>
			</div>
		</fieldset>
	</form>
</div>
<!-- 회원탈퇴 폼 -->
<script>
	$(document).ready(function() {
		$("#form").on("submit", function() {
			if ($("#inputPass").val().trim() === "") {
				alert('비밀번호를 입력해주세요.');
				$("#inputPass").focus();
				return false;
			}
		});
	});
	/* function removeMember() {
		if (window.confirm("탈퇴 하시면 자동 로그아웃 됩니다.")) {
			location.href = "${pageContext.request.contextPath}/account/uDelete";
		}
	} */
</script>
	

<%@ include file="../../../inc/footer.jsp"%>

