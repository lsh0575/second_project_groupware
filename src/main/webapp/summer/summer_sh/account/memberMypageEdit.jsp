<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../../inc/header.jsp" %>

	<!-- 사용자 마이페이지 수정 폼 START -->
	<div class="container body-top">
		
		<form action="${pageContext.request.contextPath}/account/uUpdate" method="post" id="form">
			<fieldset>
				<legend class="text-center">${sessionScope.userid} 정보 수정</legend>
				<p>(*)은 필수 요소입니다.</p>
				<div class="form-group">
					<label for="userId">아이디 입력(*) </label>
					<!-- 아이디 중복체크 start -->
					<span id="idDuplCheck"></span>
					<!-- 아이디 중복체크 end -->
					<input type="text" class="form-control" id="userId" name="userid" value="${sessionScope.userid}" readonly />
				</div>
				
				<div class="form-group">
					<label for="userPass">비밀번호 입력(*)</label>
					<input type="password" class="passForm form-control" id="userPass" name="userpass" placeholder="비밀번호를 입력해주세요" />
				</div>
				
				<div class="form-group">
					<label for="passCheck">비밀번호 확인(*) </label><span id="passConfirm"></span>
					<input type="password" class="passForm form-control" id="passCheck" name="passCheck" placeholder="비밀번호를 확인해주세요." />
				</div>
				
				<div class="form-group">
					<label for="userName">이름 입력(*)</label>
					<input type="text" class="form-control" id="userName" name="username" value="${userUpdate.username}" readonly />
				</div>
				<div class="form-group">
					<label for="userBirth">생년월일 입력(*)</label>
					<!-- max=""을 통해 생일을 금일 날짜 이후는 선택 할 수 없도록 설정 -->
					<input type="date" class="form-control" id="userBirth" name="userbirth" value="${userUpdate.userbirth}" readonly />
				</div>
				
				<div class="form-group">
					<input type="hidden" class="form-control" name="category_positionno" value="${userUpdate.category_positionno}" />
					<label for="position">직책 입력(*)</label>
					<input type="text" class="form-control" id="ceo" value="${userUpdate.positionlist}" readonly />
				</div>
				
				<div class="form-group">
				  <label for="userSex">성별 입력(*)</label>
				  <label for="${userUpdate.usersex == 1 ? 'male' : 'female'}"></label>
				  <input type="text" class="form-control" id="${userUpdate.usersex == 1 ? 'male' : 'female'}" 
				  		 name="usersex" value="${userUpdate.usersex == 1 ? '남자' : '여자'}" readonly />
				</div>
				<div class="form-group">
					<label for="userEmail">이메일 입력(*)</label>
					<input type="email" class="form-control" id="userEmail" name="useremail" value="${userUpdate.useremail}" placeholder="이메일을 입력해주세요"/>
				</div>
				
				<div class="form-group">
					<label for="userPhone">휴대전화번호 입력(*)</label>
					<input type="text" class="form-control" id="userPhone" name="userphone" value="${userUpdate.userphone}" placeholder="휴대전화번호를 입력해주세요"/>
				</div>
				<div class="form-group">
					<div style="width:200px;">
						<label for="userPostnum">우편번호 입력(5자리)(*)</label>
						<input type="text" class="form-control" id="userPostnum" name="userpostnum" value="${userUpdate.userpostnum}" placeholder="우편번호를 입력해주세요" maxlength="5"/>
					</div>
				</div>
				<div class="form-group">
					<label for="userPostnum">도로명 주소 입력(*)</label>
					<input type="text" class="form-control" id="basic_userAddr" name="basic_useraddr" value="${userUpdate.basic_useraddr}" placeholder="주소를 입력해주세요." readonly/>
				</div>
				<div class="form-group">
					<label for="userAddr">상세주소 입력(*)</label>
					<input type="text" class="form-control" id="userAddr" name="useraddr" value="${userUpdate.useraddr}" placeholder="상세주소를 입력해주세요"/>
				</div>
				<%--  --%>
				<div class="form-group">
<!-- 					<input type="submit" class="btn btn-success form-control" value="확인"/> -->
					<button type="submit" class="btn overlay_btn form-control">확인</button>
				</div>
				<div class="text-center">
					<p><a href="javascript:history.go(-1)" id="cancle" title="처음으로 돌아갑니다.."><button class="btn overlay_btn2 form-control" type="button">취소</button></a></p>
				</div>
			</fieldset>
		</form>
		<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
		<script>
		$(document).ready(function(){
			//우편번호 입력
			$("#userPostnum").on("click",function(){
				new daum.Postcode({
			        oncomplete: function(data) {
			        	$("#userPostnum").val(data.zonecode);
			            $("#basic_userAddr").val(data.roadAddress);
			            $("#userAddr").focus();
			        }
			    }).open();
			});
			$("#basic_userAddr").on("click",function(){
				$("#userPostnum").click();
			});
			
			// 비밀번호 입력 확인
			$(".passForm").on("keyup",function(){
				if ($("#userPass").val()!="" && $("#passCheck").val()!="" ){
					//비밀번호와 비밀번호 재입력이 같지 않다면
					if($("#userPass").val()!=$("#passCheck").val()){
					   $("#passConfirm").css("color","red");
					   $("#passConfirm").html(" 비밀번호를 다시 확인해주세요");
					   $("#passConfirm").attr("data-check","false");
					} else { //비밀번호 재입력과 비밀번호가 같다면
					   $("#passConfirm").css("color","green");
					   $("#passConfirm").html(" 비밀번호가 일치합니다.");
					   $("#passConfirm").attr("data-check","true");
					}
				}
			});
			
			// 빈칸 검사 START
			$("#form").on("submit",function(){
				
				// 비밀번호 빈칸 검사 START
				if ($("#userPass").val().trim()==""){ 
						 $("#userPass").focus();
						 alert('비밀번호를 입력해주세요.');
						 return false;
				}
				// 비밀번호 빈칸 검사 END
				
				// 비밀번호 확인 START
				else if ($("#passConfirm").attr("data-check") != 'true'){
						 $("#userPass").focus();
						 alert ('비밀번호가 일치하지 않습니다.');
						 return false;
				}
				// 비밀번호 확인 END
				
				// 이메일 빈칸 검사 START
				else if ($("#userEmail").val()==""){ 
					 	 $("#userEmail").focus();
						 alert('이메일을 입력해주세요.');
						 return false;
				}
				//이메일 빈칸 검사 END
				
				// 휴대전화 빈칸 검사 START
				else if ($("#userPhone").val()==""){
						 $("#userPhone").focus();
						 alert('휴대전화번호를 입력해주세요.');
						 return false;
				}
				// 휴대전화 빈칸 검사 END
				
				// 우편번호 빈칸 검사 START
				else if ($("#userPostnum").val()==""){ 
					 	 $("#userPostnum").focus();
						 alert('우편번호를 입력해주세요.');
						 return false;
				}
				// 우편번호 빈칸 검사 END
				
				//상세주소 빈칸 검사 START
				else if ($("#userAddr").val()==""){ 
						 $("#userAddr").focus();
						 alert('상세주소를 입력해주세요.');
						 return false;
				}
				//상세주소 빈칸 검사 END
			});						
		});
		// 빈칸 검사 END
		</script>
	</div>
	<!-- 사용자 마이페이지 수정 폼 END -->
<%@ include file="../../../inc/footer.jsp" %>