package com.summer.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Dayoff {
	private int dsrn;
	private int duse;
	private int wfsrn;
	private int positionno;
}
