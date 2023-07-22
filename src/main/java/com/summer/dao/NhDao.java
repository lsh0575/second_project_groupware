package com.summer.dao;

import java.util.List;
import java.util.Map;

import com.summer.dto.AlarmVO;
import com.summer.dto.InviteMemberVO;
import com.summer.dto.ProjectDateVO;
import com.summer.dto.ProjectVO;
import com.summer.dto.TaskVO;
import com.summer.dto.UserVO;

@SummerMapper
public interface NhDao { 
	public List<ProjectVO> p_readAll(Map<String, String> uid);
	public List<ProjectDateVO> p_readAll_go();
	public ProjectVO p_read(int no);
	public int p_insert(ProjectVO vo);
	public int p_update(ProjectVO vo);
	
	
	public List<TaskVO> t_readAll(int psrn);
	public TaskVO t_read(int no);
	public int t_insert(TaskVO vo);
	public int t_update(TaskVO vo);
	
	public int t_update_complete(int tsrn);
	public int t_delete(int no);
	
	public List<UserVO> invitemember_list(int psrn);
	public List<UserVO> memberlist(Map<String, Object> para);
	public int invite(Map<String, Object> para);
	public int deletemember(InviteMemberVO vo);
	
	public List<AlarmVO> alarm_project(String uid);
	public List<AlarmVO> alarm_group(String uid);
	public int accept_invite(Map<String, Object> para);
	public int refuse_invite(Map<String, Object> para);
}