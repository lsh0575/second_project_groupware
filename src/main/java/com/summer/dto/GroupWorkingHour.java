package com.summer.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class GroupWorkingHour {
	private String userid;
	private String username;
	private String whdate;
	private String whgotime;
	private String whleavetime;
	
	public GroupWorkingHour(String userid) {
		super();
		this.userid = userid;
	}
	
}
