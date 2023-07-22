package com.summer.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.summer.dao.NhDao;
import com.summer.dto.AlarmVO;
import com.summer.dto.InviteMemberVO;
import com.summer.dto.ProjectDateVO;
import com.summer.dto.ProjectVO;
import com.summer.dto.TaskVO;
import com.summer.dto.UserVO;

@Service
public class NhServiceImpl implements NhService {
	@Autowired
	NhDao dao;
	
	@Override public List<ProjectVO> p_readAll(Map<String, String> uid) {return dao.p_readAll(uid); }
	@Override public List<ProjectDateVO> p_readAll_go() { return dao.p_readAll_go(); }
	@Override public ProjectVO p_read(int no) { return dao.p_read(no); }
	@Override public int p_insert(ProjectVO vo) {  return dao.p_insert(vo); }
	@Override public int p_update(ProjectVO vo) { return dao.p_update(vo); }
	@Override public ProjectVO p_update_view(ProjectVO vo) { return dao.p_read(vo.getPsrn()); }

	@Override public List<TaskVO> t_readAll(int psrn) { return dao.t_readAll(psrn); }
	@Override public TaskVO t_read(int no) { return dao.t_read(no); }
	@Override public int t_insert(TaskVO vo) { return dao.t_insert(vo); }
	@Override public int t_update(TaskVO vo) { return dao.t_update(vo); }
	@Override public TaskVO t_update_view(TaskVO vo) { return dao.t_read(vo.getTsrn()); }
	@Override public int t_update_complete(int tsrn) { return dao.t_update_complete(tsrn); }
	@Override public int t_delete(int no) { return dao.t_delete(no); }

	@Override public List<UserVO> invitemember_list(int psrn) { return dao.invitemember_list(psrn); }
	@Override public List<UserVO> memberlist(Map<String, Object> para) { return dao.memberlist(para); }
	@Override public int invite(Map<String, Object> para) { return dao.invite(para); }
	@Override public int deletemember(InviteMemberVO vo) { return dao.deletemember(vo); }
	@Override public List<UserVO> invitemember_btn(int psrn) { return dao.invitemember_list(psrn); }
	
	
	
	@Override public List<AlarmVO> alarm_group(String uid) {  return dao.alarm_group(uid); }
	@Override public List<AlarmVO> alarm_project(String uid) {  return dao.alarm_project(uid); }
	@Override public int accept_invite(Map<String, Object> para) { return dao.accept_invite(para); }
	@Override public int refuse_invite(Map<String, Object> para) { return dao.refuse_invite(para); }

	
	
} 