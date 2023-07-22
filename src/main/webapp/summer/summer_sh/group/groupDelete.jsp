<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../../inc/header.jsp" %>

	<div class="container">
	  <h3>그룹 삭제</h3>
	  <form action="${pageContext.request.contextPath}/group/gDelete" method="post">
	    <input type="hidden" name="groupno" value="${param.groupno}" class="form-control" />
	    <div class="form-group">
	      <label for="userpass">비밀번호</label>
	      <input type="password" name="userpass" id="userPass" class="form-control">
	      <span>(*) 수정, 삭제 시 필수입니다.</span>
	    </div>
	    <div class="form-group">
<!-- 	      <input type="submit" value="확인"> -->
<!-- 	      <input type="reset" onclick="history.go(-1);" value="취소"> -->
	      <button type="submit" class="btn overlay_btn">확인</button>
	      <button type="reset" onclick="history.go(-1);" class="btn overlay_btn2">취소</button>
	    </div>
	  </form>
	</div>

<%@ include file="../../../inc/footer.jsp" %>