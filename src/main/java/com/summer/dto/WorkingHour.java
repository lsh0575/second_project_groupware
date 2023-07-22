package com.summer.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.RequiredArgsConstructor;

@Data
@AllArgsConstructor
@RequiredArgsConstructor
public class WorkingHour {
	private int whsrn;
	private String whdate;
	private String whgotime;
	private String whleavetime;
	private String userid;
	
	
	public WorkingHour(String whdate, String whgotime, String whleavetime, String userid) {
		super();
		this.whdate = whdate;
		this.whgotime = whgotime;
		this.whleavetime = whleavetime;
		this.userid = userid;
	}
	public WorkingHour(int whsrn, String whleavetime, String userid) {
		super();
		this.whsrn = whsrn;
		this.whleavetime = whleavetime;
		this.userid = userid;
	}
	public WorkingHour(String userid) {
		super();
		this.userid = userid;
	}
	public WorkingHour(int whsrn, String userid) {
		super();
		this.whsrn = whsrn;
		this.userid = userid;
	}
	public WorkingHour(int whsrn, String whgotime, String whleavetime, String userid) {
		super();
		this.whsrn = whsrn;
		this.whgotime = whgotime;
		this.whleavetime = whleavetime;
		this.userid = userid;
	}
	public WorkingHour(String whdate, String userid) {
		super();
		this.whdate = whdate;
		this.userid = userid;
	}
	
}
