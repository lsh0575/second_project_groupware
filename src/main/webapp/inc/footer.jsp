<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div id="footer" class="row">
<div class="col-md-8">
	<div class="fcontext">
		상호: Team - Summer(Summer! Project) <br />
		대표: 김나형,김혜은,이성현 <br />
		전화번호: 1234-1234 <br />
		사업자등록번호: 000-00-00000 <br />
		통신판매업신고번호: 2023-강남그린아이티아카데미학원 <br />
		© Summer! Corp. All rights reserved.
	</div>

</div>

			<!-- OpenWeatherMap API 사용 -->
			<div class="col-md-4">
				<!--	날씨 출력	    -->
				<div class="weatherTitle">
					<div class="weather_icon"></div>
					<br>
					
					<div class="form-group">
						<div class="weatherContent">
							<div class="temp_min"></div>
							<div class="temp_max"></div>
							<div class="humidity"></div>
							<div class="wind"></div>
							<div class="cloud"></div>
						</div>
						<div class="weatherInfo">
							<div class="current_temp"></div>
							<div class="weather_description"></div>
							<div class="city"></div>
						</div>
					</div>
					
				</div>
			</div>
		</div>



<!-- 날씨 출력 script -->
<!-- OpenWeatherMap API -->
<script>
	// 오늘 날짜 출력
	$(document).ready(function() {
		function convertTime() {
			var now = new Date();
			var month = now.getMonth() + 1;
			var date = now.getDate();
			return month + '월' + date + '일';
		}

		var currentTime = convertTime();
		$('.nowtime').append(currentTime);
	});

	// 날씨 api - fontawesome 아이콘
	var weatherIcon = {
		'01': 'fas fa-sun',
		'02': 'fas fa-cloud-sun',
		'03': 'fas fa-cloud',
		'04': 'fas fa-cloud-meatball',
		'09': 'fas fa-cloud-sun-rain',
		'10': 'fas fa-cloud-showers-heavy',
		'11': 'fas fa-poo-storm',
		'13': 'far fa-snowflake',
		'50': 'fas fa-smog'
	};

	// 날씨 api - 서울
	var apiURI = "https://api.openweathermap.org/data/2.5/weather?q=" + 'seoul'
			+ "&appid=" + "b957a41621c2701ec8178c588df27dea";
	$.ajax({
				url: apiURI,
				dataType: "json",
				type: "GET",
				async: "false",
				success: function(resp) {
					var $Icon = (resp.weather[0].icon).substr(0, 2);
					var $weather_description = resp.weather[0].main;
					var $Temp = Math.floor(resp.main.temp - 273.15) + 'º';
					var $humidity = '습도&nbsp;&nbsp;&nbsp;&nbsp;' + resp.main.humidity + ' %';
					var $wind = '바람&nbsp;&nbsp;&nbsp;&nbsp;' + resp.wind.speed + ' m/s';
					var $city = '서울';
					var $cloud = '구름&nbsp;&nbsp;&nbsp;&nbsp;' + resp.clouds.all + "%";
					var $temp_min = '최저 온도&nbsp;&nbsp;&nbsp;&nbsp;' + Math.floor(resp.main.temp_min - 273.15) + 'º';
					var $temp_max = '최고 온도&nbsp;&nbsp;&nbsp;&nbsp;' + Math.floor(resp.main.temp_max - 273.15) + 'º';

					$('.weather_icon').append('<i class="' + weatherIcon[$Icon] + ' fa-5x"></i>');
					$('.current_temp').prepend($Temp);
					$('.weather_description').prepend($weather_description);
					$('.city').append($city);
					$('.temp_min').append($temp_min);
					$('.temp_max').append($temp_max);
					$('.humidity').append($humidity);
					$('.wind').append($wind);
					$('.cloud').append($cloud);
				}
			});
</script>
</body>
</html>