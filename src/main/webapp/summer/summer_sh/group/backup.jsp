<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="../../../inc/header.jsp" %>

<div class="modal fade" id="nonGroupMembersModal" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">회원 초대</h4>
            </div>
            <div class="modal-body">
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>아이디</th>
                            <th>이름</th>
                            <!-- 추가 필요한 회원 정보들 -->
                            <!-- 예: <th>직책</th> -->
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${nonGroupMembers}" var="member">
                            <tr>
                                <td>${member.userid}</td>
                                <td>${member.username}</td>
                                <!-- 추가 필요한 회원 정보들 -->
                                <!-- 예: <td>${member.positionlist}</td> -->
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
            <div class="modal-footer">
<!--                 <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button> -->
                <button type="button" class="btn overlay_btn2" data-dismiss="modal">닫기</button>
                <!-- 추가 필요한 버튼들 -->
                <!-- 예: <button type="button" class="btn btn-primary">초대</button> -->
            </div>
        </div>
    </div>
</div>

<%@ include file="../../../inc/footer.jsp" %>