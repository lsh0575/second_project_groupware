<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../inc/header.jsp" %>
	<div class="calendarmtotal total_background" >
		<p class="nhcalendaricon text-center">
			<input type="hidden" id="today_month" value=""/>
			<a href="#" title="이전달" id="prev_month"><img src="${pageContext.request.contextPath}/resources/img/left_arrow.png" /></a>
			<span class="text-center"><span class="myc year"></span>년<span class="myc month"></span>월</span>
			<a href="#" title="다음달" id="next_month"><img src="${pageContext.request.contextPath}/resources/img/right_arrow.png"/></a>
		</p>
		<table class="table" id="mytable">
		<colgroup>
			<col style="width:14%" style="background: red" >
			<col style="width:14%">
			<col style="width:14%">
			<col style="width:14%">
			<col style="width:14%">
			<col style="width:14%">
			<col style="width:14%">
		</colgroup>
         <thead>
            <tr><th scope="col" style="color:red;">SUN</th><th scope="col">MON</th><th scope="col">TUE</th>
               <th scope="col">WED</th><th scope="col">THU</th><th scope="col">FRI</th><th scope="col">SAT</th></tr>
         </thead>
         <tbody id="tableTD">
         
         </tbody>
      </table>
	</div>
	<script>
		$(function() {
			calendarNow();
			calendarPrev();
			calendarNext();
			colorchange();
		});
		function colorchange () {
			$("#mytable").on("mouseenter", ".c_td", function() {
				  $(this).css("background-color", "#dddddd55");
			});
			$("#mytable").on("mouseleave", ".c_td", function() {
				  $(this).css("background-color", "white");
			});
		}
		function calendarPrev() {
			$("#prev_month").on("click", function() {
				var month = $(".month").text();
				console.log(month-1);
				$.ajax({
					url : "${pageContext.request.contextPath}/calendar/myCalendar_change",
					type: "get",
					data : {"month" : month-2},
					contentType : "application/json; charset=UTF-8",
					success : function(json) {
						$("#mytable tbody").empty();
						console.log(json);
						$(".year").html(json.year);
						$(".month").html(json.month);
						$(".month").attr("value", json.month);
						
						for(var i =0; i<json.calc_days.length; i++) {
							if(i % 7 == 0 ) { tr = $("<tr>");   }
							tr.append(  $("<td class='c_td'>").append(json.calc_days[i])  );
							$("#mytable tbody").append(tr);
						}
						var today_day = json.day;
						var today_month = $("#today_month").attr("value");
						console.log(today_month);
						$("#mytable tbody tr td").each(function() {
							if($(this).text() == today_day && json.month == today_month ) {	
								$(this).css("border", "4px solid rgb(0 0 0)");
								$(this).append("<p><small id='today'>TODAY</small></p>");
								/* $(this).on("mouseenter",function () {
									$(this).css("background-color", "#fd353555");
								});
								$(this).on("mouseleave", function () {
									$(this).css("background-color", "#fd353522");
								});
							 */
							}
						});
						getProject();
						colorchange();
					}
				});
			});
		}
		function calendarNext() {
			$("#next_month").on("click", function() {
				var month = $(".month").text();
				console.log(month);
				$.ajax({
					url : "${pageContext.request.contextPath}/calendar/myCalendar_change",
					type: "get",
					data : {"month" : month},
					contentType : "application/json; charset=UTF-8",
					success : function(json) {
						$("#mytable tbody").empty();
						console.log(json);
						$(".year").html(json.year);
						$(".month").html(json.month);
						$(".month").attr("value", json.month);
						
						for(var i =0; i<json.calc_days.length; i++) {
							if(i % 7 == 0 ) { tr = $("<tr>");   }
							tr.append(  $("<td class='c_td'>").append(json.calc_days[i])  );
							$("#mytable tbody").append(tr);
						}
						var today_day = json.day;
						var today_month = $("#today_month").attr("value");
						console.log(today_month);
						$("#mytable tbody tr td").each(function() {
							if($(this).text() == today_day && json.month == today_month ) {	
								$(this).css("border", "4px solid rgb(0 0 0)");
								$(this).append("<p><small id='today'>TODAY</small></p>");
								/* $(this).on("mouseenter",function () {
									$(this).css("background-color", "#fd353555");
								});
								$(this).on("mouseleave", function () {
									$(this).css("background-color", "#fd353522");
								});
							 */
							}
						});
						getProject();
						colorchange();
					}
				});
			});
		}
		function calendarNow () {
			$.ajax({
				url : "${pageContext.request.contextPath}/calendar/myCalendar",
				type : "get",
				dataType: "json",
				contentType : "application/json; charset=UTF-8",
				error : function (xhr, status, msg) {
					alert(status + "/" + msg);
				},
				success : function(json) {
					$("#mytable tbody").empty();
					$(".year").html(json.year);
					$(".month").html(json.month);
					$(".month").attr("value", json.month);
					$("#today_month").attr("value" , json.month);
					
					//console.log(json.day);
					for(var i =0; i<json.calc_days.length; i++) {
						if(i % 7 == 0 ) { tr = $("<tr>");   }
						tr.append(  $("<td class='c_td'>").append(json.calc_days[i])  );
						$("#mytable tbody").append(tr);
					}
					var today_day = json.day;
					$("#mytable tbody tr td").each(function() {
						if($(this).text() == today_day) {	
							$(this).css("border", "4px solid rgb(0 0 0)");
							$(this).append("<p><small id='today'>TODAY</small></p>");
							/* $(this).on("mouseenter",function () {
								$(this).css("background-color", "#fd353555");
							});
							$(this).on("mouseleave", function () {
								$(this).css("background-color", "#fd353522");
							});
						 */
						}
					});
					getProject();
					colorchange();
				}
			});
		}
		function getProject() {
		    $.ajax({
		        url: "${pageContext.request.contextPath}/calendar/Calendar_pro",
		        type: "get",
		        dataType: "json",
		        contentType: "application/json; charset=UTF-8",
		        error: function(xhr, status) {
		            alert(status + "/");
		        },
		        success: function(json) {
		            var list = json.projectlist;
					console.log(list.length);
		            for (var i = 0; i < list.length; i++) {
		                var startDate = list[i].startdate;
		                var endDate = list[i].enddate;
		                var psrn = list[i].psrn;
		                var ptitle = list[i].ptitle;
						
		                var startArr = startDate.split("-");
		                var endArr = endDate.split("-");
		                var startMon = startArr[0];
		                var startDay = startArr[1];
		                var endMon = endArr[0];
		                var endDay = endArr[1];
						console.log(startMon + "/"+startDay);
		                $("#mytable tbody tr td").each(function() {
		                    var day = $(this).text();
		                    day = day.substr(0,2);
		                    console.log("............."+day);
		              		//console.log(parseInt(startDay));
		                    //console.log(parseInt(day) == parseInt(startDay));
		                    //console.log(($(".month").attr("value") == startMon ));
		                   //console.log(startDay+"2");
		                   //console.log(startMon);
		                    if (($(".month").attr("value") ==  parseInt(startMon) ) &&  (day ==  parseInt(startDay)) ) {
		                        // 맞는 날짜에 데이터 삽입
		                        //console.log(startMon);
		                        //console.log("ok");
		                        $(this).append("<p id='nhschedule_margin'><a href='${pageContext.request.contextPath}/calendar/project_go?psrn="+psrn+"' id='schedule'> " + ptitle + "</a></p>");
		                    }
		                });
		            }
		        }
		    });
		}
	</script>
<%@ include file="../../inc/footer.jsp" %>
