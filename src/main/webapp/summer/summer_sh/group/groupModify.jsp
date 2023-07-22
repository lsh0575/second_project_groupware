<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../../inc/header.jsp" %>

	<div class="container body-top">
	<form action="${pageContext.request.contextPath}/group/gUpdate" method="post" >
		<fieldset>
		  <h4>그룹(조직)명 수정</h4>
		  <br/>
			<div>
				<input type="hidden" name="groupno" value="${param.groupno}" class="form-control" />
			 	<label for="sgroup">그룹 선택(*)</label>&emsp;
		        <label for="company">회사</label>
				<input type="radio" id="company" name="sgroup" value="1" >&emsp;
				<label for="team">팀</label>
				<input type="radio" id="team" name="sgroup" value="2" >&emsp;
				<label for="personal">개인</label>
				<input type="radio" id="personal" name="sgroup" value="3" checked >
			</div><br/>
				<div class="form-group">
					<label for="sgroup">그룹명 입력(*)</label>
					<input type="text" class="form-control" id="sgroup" name="groupname" placeholder="그룹명을 입력해주세요"/>
				</div>
				<div class="form-group">
					<label for="userPass">비밀번호 입력(*)</label>
					<input type="password" class="passForm form-control" id="userPass" name="userpass" placeholder="비밀번호를 입력해주세요"/>
				</div>
		<div class="form-group text-center">
			<div class="col-sm-6">
<!-- 				<input type="submit" class="btn btn-success btn-block" value="확 인"/> -->
				<button type="submit" class="btn overlay_btn btn-block">확인</button>
			</div>
			<div class="col-sm-6">
				<a href="${pageContext.request.contextPath}/group/gmReadAll"><button class="btn overlay_btn2 btn-block" type="button">취소</button></a>
			</div>
		</div>
		</fieldset>
	</form>
	</div>


<%@ include file="../../../inc/footer.jsp" %>