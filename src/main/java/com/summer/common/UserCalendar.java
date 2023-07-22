package com.summer.common;

import java.util.Arrays;
import java.util.Calendar;

import org.springframework.stereotype.Component;

import lombok.Data;

@Component
//@Data
public class UserCalendar {
	Calendar today;
	String[] weektitle;
	String[] calc_days;
	
	int year;
	int month;
	int day;
	int startyoil;
	int endyoil;
	int lastday;  //달에 몇일까지 있는지
	
	public UserCalendar() {
		today = Calendar.getInstance();
		this.year = today.get(Calendar.YEAR);
		this.month = today.get(Calendar.MONTH);
		this.day = today.get(Calendar.DATE);
	}

	public UserCalendar(int month) {
//		super();
		today = Calendar.getInstance();
		this.year = today.get(Calendar.YEAR);
		this.month = month;
		this.day = today.get(Calendar.DATE);
	}
	//Calendar 는 윤년 계산이 들어가 있음
	public void calc_settings() {
		this.weektitle = new String[] {"SUN","MON","TUE","WED","THU","FRI", "SAT"};
		
		if(this.month == 12 ) {
			this.year+= 1;  this.month = 0;
		} else if(this.month == -1	) {
			this.year-=1;  this.month =11;
		}
		//month : 0~11   0이 1월, 1이 2월
		
		today.set(this.year, this.month , 1);  //이번달 설정
		this.startyoil = today.get(Calendar.DAY_OF_WEEK);
		this.lastday   = today.getActualMaximum(Calendar.DATE);  //데이의 최대값
		today.set(this.year, this.month ,this.lastday); 
		this.endyoil   = today.get(Calendar.DAY_OF_WEEK);

		
		this.calc_days = new String[42];
		Arrays.fill(this.calc_days, "");   //데이터에 "" 한번에 넣어주기
		
		this.month = this.month +1;
		int cnt = 1;
		for(int i=this.startyoil-1; i < (this.startyoil + this.lastday-1); i++) {   //(빈칸) -1 + 달의 날 수 
			this.calc_days[i] = String.valueOf(cnt++);
		}
		
		
	}

	public Calendar getToday() {
		return today;
	}

	public void setToday(Calendar today) {
		this.today = today;
	}

	public String[] getWeektitle() {
		return weektitle;
	}

	public void setWeektitle(String[] weektitle) {
		this.weektitle = weektitle;
	}

	public String[] getCalc_days() {
		return calc_days;
	}

	public void setCalc_days(String[] calc_days) {
		this.calc_days = calc_days;
	}

	public int getYear() {
		return year;
	}

	public void setYear(int year) {
		this.year = year;
	}

	public int getMonth() {
		return month;
	}

	public void setMonth(int month) {
		this.month = month;
	}

	public int getDay() {
		return day;
	}

	public void setDay(int day) {
		this.day = day;
	}

	public int getStartyoil() {
		return startyoil;
	}

	public void setStartyoil(int startyoil) {
		this.startyoil = startyoil;
	}

	public int getEndyoil() {
		return endyoil;
	}

	public void setEndyoil(int endyoil) {
		this.endyoil = endyoil;
	}

	public int getLastday() {
		return lastday;
	}

	public void setLastday(int lastday) {
		this.lastday = lastday;
	}
	
	
}