<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../../../inc/header.jsp"%>

<div class="container text-center">
  <!-- <h3 class="mfont">What We Do</h3> -->
  <br>
  <div class="afterMain From">
  <!--  -->
	<!-- 뉴스 타이틀을 하나씩 시간 순서에 따라 넘어가는 영역 -->
	
	<div class="newsfont">Today News</div>
    <section class="news-section">
      <div class="news-title-container newsbord">
        <a class="sh news-title"></a>
      </div>
    </section>
  <!--  -->
	<div class="form-group row cmain">
<%-- 		<div class="col-sm-4">
			<a href="${pageContext.request.contextPath}/project/p_list?uid=${userid}"> 
				<span class="sh glyphicon glyphicon-list-alt" aria-hidden=”true”></span>
			</a>
			<p class="maintext">프로젝트</p>
		</div> --%>
		
				<div class="col-sm-4">
			<a href="${pageContext.request.contextPath}/project/p_list?uid=${userid}"> 
				<img src="${pageContext.request.contextPath}/resources/img/project.png" alt="Project 바로가기" class="imgs"/>
			</a>
		</div>
		
		<div class="col-sm-4">
			 <a href="${pageContext.request.contextPath}/work/workinghour">
         		<img src="${pageContext.request.contextPath}/resources/img/workinghour.png" alt="Workinghour 바로가기" class="imgs"/>
       		 </a>
		</div>
		<div class="col-sm-4">
			 <a href="${pageContext.request.contextPath}/work/totaldayoff">
         			<img src="${pageContext.request.contextPath}/resources/img/dayoff.png" alt="Dayoff 바로가기" class="imgs"/>
       		 </a>
		</div>
	</div>
	<div class="form-group row cmain">
			<div class="col-sm-4">
			 <a href="${pageContext.request.contextPath}/work/workflow">
	        		 <img src="${pageContext.request.contextPath}/resources/img/workflow.png" alt="Workflow 바로가기" class="imgs img2"/>
	       	</a>
			</div>
			<div class="col-sm-4">
				 <a href="${pageContext.request.contextPath}/group/gmReadAll">
	          		 <img src="${pageContext.request.contextPath}/resources/img/group.png" alt="Group 바로가기" class="imgs img2"/>
	       		 </a>
			</div>
			<div class="col-sm-4">
				 <a href="${pageContext.request.contextPath}/calendar/myCalendar_go">
	         		 <img src="${pageContext.request.contextPath}/resources/img/calendar.png" alt="Calendar 바로가기" class="imgs img2"/>
	        	</a>
			</div>
		</div>
	</div>
	
</div>

	<script>
		var result = "${success}";
		if ( result == "fail") { alert("로그인에 실패했습니다."); histrory.go(-1); }
		else if (result.length != 0) { alert(result); }
	</script>


  <!-- NEWS 받아오기 코드 추가 -->
<script>
  // 뉴스 타이틀을 하나씩 시간 순서에 따라 넘어가는 함수 호출
  rotateNewsTitle();

  // 뉴스 타이틀을 하나씩 시간 순서에 따라 넘어가는 함수
  function rotateNewsTitle() {
    //const apiKey = "YOUR_API_KEY";
    let url = `https://newsapi.org/v2/top-headlines?country=kr&category=business&apiKey=92ce307ba1b141ae89a85de048b5f538`;

    // news-title 엘리먼트 선택
    const newsTitle = document.querySelector('.news-title');

    // newsApi에서 가져온 정보로 뉴스 타이틀 변경
    fetch(url)
      .then((res) => res.json())
      .then((data) => {
        console.log(data);
        const articles = data.articles;
        let index = 0;

        // 초기 뉴스 타이틀 설정
        newsTitle.textContent = articles[index].title;

        // 뉴스 타이틀을 일정 시간마다 변경
        setInterval(() => {
          index = (index + 1) % articles.length;
          newsTitle.textContent = articles[index].title;
        }, 5000); // 5초마다 변경 (5000ms = 5s)

        // 뉴스 타이틀 클릭 시 새 창에서 세부 내용 보기
        newsTitle.addEventListener('click', () => {
          window.open(articles[index].url, '_blank');
        });
      })
      .catch((error) => {
        console.log('error');
      });
  }
</script>

<%@include file="../../../inc/footer.jsp"%>