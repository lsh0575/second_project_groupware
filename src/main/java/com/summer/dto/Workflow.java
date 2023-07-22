package com.summer.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Workflow {

	private int wfsrn;
	private String wfstatus;
	private String wfapplystartdate;
	private String wfapplyenddate;
	private String wfapplystarttime;
	private String wfapplyendtime;
	private String wfdate;
	private String userid;
	private int wfcsrn;
	
}
