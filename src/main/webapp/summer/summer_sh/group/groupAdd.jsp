<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../../../inc/header.jsp" %>

<div class="container body-top">
    <form action="${pageContext.request.contextPath}/group/gaInsert?summer_user_userid=${sessionScope.userid}" method="post">
        <fieldset>
            <h4>그룹(조직) 추 가</h4><br/>
            <div>
                <label for="sgroup">그룹 선택(*)</label>&emsp;
                <label for="company">회사</label>
                <input type="radio" id="company" name="groupdivision" value="1">&emsp;
                <label for="team">팀</label>
                <input type="radio" id="team" name="groupdivision" value="2">&emsp;
                <label for="personal">개인</label>
                <input type="radio" id="personal" name="groupdivision" value="3" checked>
            </div><br/>
            <div class="form-group">
                <label for="sgroup">그룹명 입력(*)</label>
                <input type="text" class="form-control" id="sgroup" name="groupname" placeholder="그룹명을 입력해주세요" required />
            </div>
            <div class="form-group text-center">
                <div class="col-sm-6">
<!--                     <input type="submit" class="btn btn-success btn-block" value="확인"/> -->
                    <button type="submit" class="btn overlay_btn btn-block">확인</button>
                </div>
                <div class="col-sm-6">
                    <p><a href="${pageContext.request.contextPath}/group/gmReadAll" id="cancel" title="그룹추가 취소"><button class="btn overlay_btn2 form-control" type="button">취소</button></a></p>
                </div>
            </div>
        </fieldset>
    </form>

    <!-- 오류 메시지 표시 -->
    <c:if test="${not empty error}">
        <div class="alert alert-danger" role="alert">
            ${error}
        </div>
    </c:if>
</div>

<%@ include file="../../../inc/footer.jsp" %>