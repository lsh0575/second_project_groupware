package com.summer.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class WorkflowCategory {
private int wfcsrn;
private String wfcname;
private String wfcstarttime;
private String wfcendtime;
private int wfctime;

}
