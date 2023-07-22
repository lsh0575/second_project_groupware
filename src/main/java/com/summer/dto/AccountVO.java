package com.summer.dto;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@RequiredArgsConstructor
public class AccountVO {
	
	// user tableㅇ
	private String userid;
	private String userpass;
	@NonNull private String username;
	private String userbirth;
	private String usersex;
    private String useremail;
    @NonNull private String userphone;
	private String userpostnum;
	private String basic_useraddr;
	private String useraddr;
	private String userprofile;
	private String joindate;
	private String userip;
	private int category_positionno;
	
	// sgroup table
	private int groupno;
	@NonNull private String groupname;
	private String groupdivision;
	private String groupcreatedate;
	private String summer_user_userid;
	
	// position table
	private int positionno;
	@NonNull private String positionlist;
	private String poisitiondayoff;
	
	// invitemember
	private List<InviteMemberVO> imList;
	//	private int isrn;
	//	private int pgsrn;
	//	private String uid;
	//	private String iaccept;
	//	private String idate;
	//	private int cno;
	
}
