package com.summer.controller;



import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.summer.dto.AlarmVO;
import com.summer.dto.InviteMemberVO;
import com.summer.dto.ProjectVO;
import com.summer.dto.TaskVO;
import com.summer.service.NhService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping(value="/project/*")
public class NhController {
	@Autowired
	NhService service;

	@RequestMapping(value = "/p_list", method = RequestMethod.GET)
	public String getProjectList(Model model, Map<String, String> uid, HttpSession session) {
		// uid.put("uid1", "dagmm");
		// uid.put("uid2", "dagmm");
		uid.put("uid1", (String) session.getAttribute("userid"));
		uid.put("uid2", (String) session.getAttribute("userid"));

		model.addAttribute("list", service.p_readAll(uid));
		//System.out.println(service.p_readAll(uid));
		return "summer_nh/project_main_nh";
	}

//	@RequestMapping(value = "/p_list_go", method = RequestMethod.GET)
//	public String getProjectListGo(Model model, @RequestParam String uid) {
//		model.addAttribute("list", service.p_readAll_go());
//		return "Calendar";
//	}

	@RequestMapping(value = "/p_detail", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> getProjectDetail(int psrn) {
		Map<String, Object> result = new HashMap<>();
		result.put("result", Boolean.TRUE);
		result.put("data", service.p_read(psrn));
		result.put("memberlist", service.invitemember_list(psrn));
		
		//System.out.println(service.invitemember_list(psrn));
		//rttr.addFlashAttribute("memberlist", service.invitemember_list(psrn));
		//rttr.addFlashAttribute("project_mgrid",service.p_read(psrn).getPmgrid() );
		//result.put("memberlist", service.invitemember_list(psrn));
		
		return result;
	}

	@RequestMapping(value = "/p_insert", method = RequestMethod.POST)
	public String insertProject(ProjectVO boardVO, RedirectAttributes rttr) {
		String result = "fail";
		
		//log.info(boardVO.getPmgrid());
		//log.info(boardVO.getPsrn());
		//log.info(boardVO.getPmgrid());
		if (service.p_insert(boardVO) > 0) {
			result = "프로젝트 추가를 완료하였습니다.";
		}
		rttr.addFlashAttribute("success", result);
		//log.info(".............." + boardVO.getPmgrid());
		
		//log.info(".............." + boardVO.getPsrn());
		return "redirect:/project/p_list?uid=" + boardVO.getPmgrid();
//		return "redirect:/javascript:history.go(-1)";
	}

	@RequestMapping(value = "/p_update", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> updateProject_view(ProjectVO vo) {
		//System.out.println("..................................1");
		Map<String, Object> result = new HashMap<>();
		result.put("data", service.p_update_view(vo));
		return result;
	}

	@RequestMapping(value = "/p_update", method = RequestMethod.POST)
	public String updateProject(ProjectVO boardVO, RedirectAttributes rttr) {
		//System.out.println(".................................2");
		String result = "fail";
		if (service.p_update(boardVO) > 0) {
			result = "프로젝트가 수정되었습니다.";
		}
		//System.out.println(".................................3");
		rttr.addFlashAttribute("success", result);

		//System.out.println(".................................4");
		return "redirect:/project/p_list?uid=" + boardVO.getPmgrid();
	}
	@RequestMapping(value = "/invitememberlist", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> memberlist(int psrn ,RedirectAttributes rttr ) {
		Map<String, Object> result = new HashMap<>();
		result.put("member", service.invitemember_list(psrn));
		//System.out.println(service.invitemember_list(psrn));
		
		return result;
	}

	@RequestMapping(value = "/memberlist", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> memberlist(int psrn, HttpSession session) {
		Map<String, Object> result = new HashMap<>();
		Map<String, Object> para = new HashMap<>();

//		para.put("uid", session.getAttribute("uid"));
		para.put("uid", session.getAttribute("userid"));
		para.put("pgsrn", psrn);

		// log.info(session.getAttribute("uid"));

		result.put("memberlist", service.memberlist(para));
		return result;
	}

	@RequestMapping(value = "/invite", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, String> invite(InviteMemberVO vo, String uid, HttpSession session ) {
		String result = "fail_invite";
		Map<String, Object> para = new HashMap<>();
		para.put("uid", uid);
		para.put("pgsrn", vo.getPgsrn());
		//System.out.println("=============>" + vo.getPgsrn());
		if (service.invite(para) > 0) { result = "초대 요청을 보냈습니다."; }
		
		Map<String, String> data = new HashMap<>();
		data.put("success", result);
		
		//System.out.println("..................................초대 성공");
		return data;
		//return "redirect:/project/p_list?uid=" + session.getAttribute("uid");
	}
//	@RequestMapping(value = "/invite", method = RequestMethod.GET)
//	@ResponseBody
//	public Map<String, Object> invite(InviteMemberVO vo, String uid, RedirectAttributes rttr, HttpSession session ) {
//	Map<String, Object> msg = new HashMap<>();
//		String result = "fail_invite";
//		Map<String, Object> para = new HashMap<>();
//		para.put("uid", uid);
//		para.put("pgsrn", vo.getPgsrn());
//		//System.out.println("=============>" + vo.getPgsrn());
//		if (service.invite(para) > 0) { result = "초대 요청을 보냈습니다."; }
//		msg.put("success", result);
//		//rttr.addFlashAttribute("success", result);
//		//return result;
//		return msg;
//	}
 
//	@RequestMapping(value = "/delete", method = RequestMethod.GET)
//	public String deletemember(InviteMemberVO vo, RedirectAttributes rttr, HttpSession session) {
//		String result = "fail_deleteMember";
//		//System.out.println(vo.getUid());
//		//System.out.println(vo.getPgsrn());
//		if (service.deletemember(vo) > 0) {
//			result = "멤버를 삭제하였습니다.";
//		}
//		rttr.addFlashAttribute("success", result);
//		return "redirect:/project/p_list?uid=?" + session.getAttribute("userid");
//	}

	@RequestMapping(value = "/delete", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, String> deletemember(String uid,int pgsrn,  HttpSession session ) {
		String result = "fail_deleteMember";
		Map<String, Object> para = new HashMap<>();
		InviteMemberVO vo = new InviteMemberVO();
		vo.setUid(uid); vo.setPgsrn(pgsrn);
		
		para.put("uid", vo.getUid());
		para.put("pgsrn", vo.getPgsrn());
		System.out.println("=============>" + vo.getUid());
		System.out.println("=============>" + vo.getPgsrn());
		if (service.deletemember(vo) > 0) { result = "멤버를 삭제했습니다."; }
		Map<String, String> data = new HashMap<>();
		data.put("success", result);
		//System.out.println("..................................초대 성공");
		return data;
		//return "redirect:/project/p_list?uid=" + session.getAttribute("uid");
	}
	@RequestMapping(value = "/t_list", method = RequestMethod.GET)
	public String getTaskList(Model model, int psrn) {
		model.addAttribute("psrn", psrn);
		model.addAttribute("tasks", service.t_readAll(psrn));
		return "summer_nh/task_main_nh";
	}

	@RequestMapping(value = "/t_detail", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> getTaskDetail(int tsrn) {
		Map<String, Object> result = new HashMap<>();
		result.put("task", service.t_read(tsrn));
		
		return result;
	}

	@RequestMapping(value = "/t_insert", method = RequestMethod.POST)
	public String insertTask(TaskVO taskVO, RedirectAttributes rttr) {
		String result = "fail";
		/*
		 * log.info(taskVO.getTmgrid()); log.info(taskVO.getTsrn());
		 * log.info(taskVO.getTmgrid());
		 */
		if (service.t_insert(taskVO) > 0) {
			result = "업무 추가를 완료하였습니다.";
		}
		rttr.addFlashAttribute("success", result);
		//log.info(".............." + taskVO.getTmgrid());
		//log.info(".............." + taskVO.getTsrn());
		return "redirect:/project/t_list?psrn=" + taskVO.getPsrn();
	}

	@RequestMapping(value = "/t_update", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> updateTask_view(TaskVO vo) {
		Map<String, Object> result = new HashMap<>();
		//log.info(service.t_update_view(vo));
		result.put("task_view", service.t_update_view(vo));
		return result;
	}

	@RequestMapping(value = "/t_update", method = RequestMethod.POST)
	public String updateTask(TaskVO taskVO, RedirectAttributes rttr) {
		String result = "fail_update";
		if (service.t_update(taskVO) > 0) {
			result = "업무 수정을 완료하였습니다.";
		}
		rttr.addFlashAttribute("success", result);
		
		return "redirect:/project/t_list?psrn=" + taskVO.getPsrn();
	}

	@RequestMapping(value = "/t_delete", method = RequestMethod.GET)
	public String deleteTask(int no, RedirectAttributes rttr) {
		//System.out.println("............................." + no);
		String result = "fail_deletetask";
		int no2 = service.t_read(no).getPsrn();

		if (service.t_delete(no) > 0) {
			result = "업무를 삭제하였습니다.";
		}
		rttr.addFlashAttribute("success", result);
		return "redirect:/project/t_list?psrn=" + no2;
	}
	 @RequestMapping(value = "/t_complete" , method=RequestMethod.POST)
     public String completeTask(TaskVO vo,   @RequestParam(value = "checked", required = false) int []  checked   ) {
       System.out.println(Arrays.toString(checked));
       // System.out.println(vo.getPsrn());

        //List<Integer> list = new ArrayList<>();
        if(Arrays.toString(checked).equals("null") ) {
        	return "redirect:/project/t_list?psrn="+ vo.getPsrn() ;
        } else {
	        for(int i= 0; i< checked.length; i++) { service.t_update_complete(checked[i]); }
	       return "redirect:/project/t_list?psrn="+ vo.getPsrn() ;
        }
     }
	 ////////////////////////////
	 @RequestMapping(value="/invite_alarm")
	 public String invite_alarm(Model model, HttpSession session) {
		 String uid = (String)session.getAttribute("userid");
		 //System.out.println("........."+uid);
		 List<AlarmVO> alarmlist_project = new ArrayList<>();
		 List<AlarmVO> alarmlist_group = new ArrayList<>();
		 for (AlarmVO a : service.alarm_project(uid)) {
			 alarmlist_project.add(a);
		 }
		for(AlarmVO a : service.alarm_group(uid)) {
			alarmlist_group.add(a);
		}
		 model.addAttribute("project", alarmlist_project);
		 model.addAttribute("group", alarmlist_group);
		 return "summer_sh/invit/inviteAlarm";
	 }
	 
	 
	 @RequestMapping(value="/accept_alarm")
	 public String accept_alarm(String uid , AlarmVO vo, Model model, HttpSession session) {
		Map<String, Object> para = new HashMap<>();
		para.put("uid", session.getAttribute("userid"));
		para.put("pgsrn", vo.getPgsrn());
		para.put("cno", vo.getCno());
		 
		 service.accept_invite(para);
		 
		 return "redirect:/project/invite_alarm";
	 }
	 @RequestMapping(value="/refuse_alarm")
	 public String refuse_alarm(String uid, AlarmVO vo, Model model, HttpSession session) {	 
		 Map<String, Object> para = new HashMap<>();
			para.put("uid", session.getAttribute("userid"));
			para.put("pgsrn", vo.getPgsrn());
			para.put("cno", vo.getCno());
			 
			 service.refuse_invite(para);
			 
			 return "redirect:/project/invite_alarm";
	 }
	 
}