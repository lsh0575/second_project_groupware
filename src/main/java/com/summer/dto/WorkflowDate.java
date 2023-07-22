package com.summer.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class WorkflowDate {
	private int wfcsrn;
	private String wfapplystartdate;
	private String wfapplyenddate;
	private String wfapplystartmonth;
	private String wfapplyendmonth;
	private String wfapplystartday;
	private String wfapplyendday;
}
