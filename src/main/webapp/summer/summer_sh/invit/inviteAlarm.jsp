<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../../../inc/header.jsp" %>

<div class="mtotal">
    <div class="col-sm-6">
    <table class="table table-hover text-center">
    	<colgroup>
			<col style="width:5%">
			<col style="width:55%">
			<col style="width:20%">
			<col style="width:20%">
		</colgroup>
        <thead>
            <tr class="text-center">
                <th scope="col">NO</th>
                <th scope="col">초대 내용</th>
                <th scope="col">초대 날짜</th>
                <th scope="col">초대 수락 / 거절</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="invite" items="${group}" varStatus="status">
                <tr>
                    <td>${status.index + 1}</td>
                    <td id="invitecontent">
           		 	<%-- <c:choose>
           		 		<c:when test="${invite.pmgrid == null }">
           		 			<span id="nh_fontbold">${invite.summer_user_userid}</span>님의 그룹(  <span id="nh_fontbold">${invite.sgroupname}</span>  )에 초대되었습니다.
           		 		</c:when>
           		 		<c:when test="${invite.summer_user_userid == null }">
           		 			<span id="nh_fontbold">${invite.pmgrid}</span>님의 프로젝트(   <span id="nh_fontbold">${invite.ptitle}</span>  )에 초대되었습니다.
           		 		</c:when>
           		 	</c:choose> --%>	
           		 		<span id="nh_fontbold">${invite.summer_user_userid}</span>님의 그룹(  <span id="nh_fontbold">${invite.groupname}</span>  )에 초대되었습니다.
                    </td>
                    <td>${invite.idate}</td>
                    <td>
                        <a href="${pageContext.request.contextPath}/project/accept_alarm?pgsrn=${invite.pgsrn}&cno=${invite.cno}" ><button  class="btn overlay_btn btn-xs">수락</button></a>
                        <a href="${pageContext.request.contextPath}/project/refuse_alarm?pgsrn=${invite.pgsrn}&cno=${invite.cno}" ><button  class="btn overlay_btn btn-xs">거절</button></a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    </div>
    <div class="col-sm-6">
    <table class="table table-hover text-center">
    	<colgroup>
			<col style="width:5%">
			<col style="width:55%">
			<col style="width:20%">
			<col style="width:20%">
		</colgroup>
        <thead>
            <tr class="text-center">
                <th scope="col">NO</th>
                <th scope="col">초대 내용</th>
                <th scope="col">초대 날짜</th>
                <th scope="col">초대 수락 / 거절</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="invite" items="${project}" varStatus="status">
                <tr>
                    <td>${status.index + 1}</td>
                    <td id="invitecontent">
           		 	<%-- <c:choose>
           		 		<c:when test="${invite.pmgrid == null }">
           		 			<span id="nh_fontbold">${invite.summer_user_userid}</span>님의 그룹(  <span id="nh_fontbold">${invite.sgroupname}</span>  )에 초대되었습니다.
           		 		</c:when>
           		 		<c:when test="${invite.summer_user_userid == null }">
           		 			<span id="nh_fontbold">${invite.pmgrid}</span>님의 프로젝트(   <span id="nh_fontbold">${invite.ptitle}</span>  )에 초대되었습니다.
           		 		</c:when>
           		 	</c:choose> --%>
           		 		<span id="nh_fontbold">${invite.pmgrid}</span>님의 프로젝트(   <span id="nh_fontbold">${invite.ptitle}</span>  )에 초대되었습니다.
                    </td>
                    <td>${invite.idate}</td>
                    <td>
                        <a href="${pageContext.request.contextPath}/project/accept_alarm?pgsrn=${invite.pgsrn}&cno=${invite.cno}" ><button  class="btn overlay_btn btn-xs">수락</button></a>
                        <a href="${pageContext.request.contextPath}/project/refuse_alarm?pgsrn=${invite.pgsrn}&cno=${invite.cno}" ><button  class="btn overlay_btn btn-xs">거절</button></a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    </div>
</div>
<%@ include file="../../../inc/footer.jsp" %>