package com.summer.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class InviteMemberVO {
	private int isrn;
	private int pgsrn;
	private String uid;
	private String iaccept;
	private String idate;
	private int cno;
}
 