<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../../inc/header.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="container">
	<h2>조직도</h2>
	<div class="form-group text-right">
<%-- 		<input type="button"
			onClick="location.href='${pageContext.request.contextPath}/group/gaInsert'"
			id="groupAdd" name="groupAdd" value="그룹 추가" class="btn btn-basic"> --%>
			<button type="button" onClick="location.href='${pageContext.request.contextPath}/group/gaInsert'"
			id="groupAdd" name="groupAdd" class="btn overlay_btn">그룹 추가</button>
	</div>
	<p class="text-right">(*) 조직 이름 클릭 시 조직 상세보기가 가능합니다.</p>
	<table class="table table-bordered">
		<thead>
			<tr class="active">
				<th>NO</th>
				<th>조직</th>
				<th>그룹장(이름)</th>
				<th>직책</th>
				<th>조직명(*)</th>
				<th>전화번호</th>
				<th>생성날짜</th>
			</tr>
		</thead>
		<tbody>
			<!-- 생성날짜를 받아오고 그룹 리스트는 forEach돌리기  -->
			<c:forEach var="sgroup" items="${gmReadAll}" varStatus="status">
				<tr>
					<td>${gmReadAll.size() - status.index}</td>
					<td><c:choose>
							<c:when test="${sgroup.groupdivision eq '1'}">회사</c:when>
							<c:when test="${sgroup.groupdivision eq '2'}">팀</c:when>
							<c:when test="${sgroup.groupdivision eq '3'}">개인</c:when>
							<c:otherwise></c:otherwise>
						</c:choose></td>
					<td>${sgroup.username}</td>
					<%-- <td>${sgroup.summer_user_userid}</td> --%>
					<td>${sgroup.positionlist}</td>
					<td><a
						href="${pageContext.request.contextPath}/group/gdRead?groupname=${sgroup.groupname}&groupno=${sgroup.groupno}&summer_user_userid=${sgroup.summer_user_userid}">${sgroup.groupname}</a></td>
					<td>${sgroup.userphone}</td>
					<td>${sgroup.groupcreatedate}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>

<script>
	var result = "${success}";
	if ( result == "fail") { alert("그룹생성에 실패했습니다."); histrory.go(-1); }
	else if (result.length != 0) { alert(result); }
</script>

<%@ include file="../../../inc/footer.jsp"%>