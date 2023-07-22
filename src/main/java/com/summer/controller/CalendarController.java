package com.summer.controller;


import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.summer.common.UserCalendar;
import com.summer.dto.InviteMemberVO;
import com.summer.dto.ProjectDateVO;
import com.summer.dto.ProjectVO;
import com.summer.dto.UserVO;
import com.summer.service.NhService;

@Controller
@RequestMapping(value="/calendar/*")
public class CalendarController {
	@Autowired
	UserCalendar mycalc;
	@Autowired
	NhService service;
	
	
	//url :  /myCalendar_go
	//jsp :  /WEB-INF/views/ + 파일명(mycalc) + .jsp
	@RequestMapping(value="/myCalendar_go" , method=RequestMethod.GET)
	public String myCaledar_go() {
		return "summer_nh/mycalc";
	}

	@RequestMapping(value="/myCalendar" , method=RequestMethod.GET)
	@ResponseBody
	public UserCalendar myCalendar(RedirectAttributes rttr) {
			System.out.println(".............myCalendar");
			mycalc = new UserCalendar();  //달력  getInstance 초기화해줘야 함 (빈 걸로 초기값)
			
			mycalc.calc_settings();
			
			
			SimpleDateFormat sdf= new SimpleDateFormat("YYYY-MM-dd");
			long today = System.currentTimeMillis();
			
		
			//System.out.println(sdf.format(today));
			rttr.addFlashAttribute("today", sdf.format(today));
			
			return mycalc;
	}
	
	@RequestMapping(value="/myCalendar_change" , method=RequestMethod.GET)
	@ResponseBody
	public UserCalendar myCalendar_change(int month) {
			System.out.println(".............myCalendar");
			mycalc = new UserCalendar();  //달력  getInstance 초기화해줘야 함 (빈 걸로 초기값)
			
			System.out.println(month);
			mycalc = new UserCalendar(month);
			mycalc.calc_settings();
			
			return mycalc;
	}
	
	@RequestMapping(value="/Calendar_pro", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> getProject() {
		 List<ProjectDateVO> projectlist = service.p_readAll_go();

//	        List<String> startMonList = new ArrayList<>(); // 시작 월 리스트
//	        List<String> startDayList = new ArrayList<>(); // 시작 일 리스트
//	        List<String> endMonList = new ArrayList<>(); // 종료 월 리스트
//	        List<String> endDayList = new ArrayList<>(); // 종료 일 리스트
//	        List<Integer> psrnList = new ArrayList<>(); // psrn 리스트
//	        List<String> ptitleList = new ArrayList<>(); // ptitle 리스트
//
//	        for (ProjectDateVO project : projectlist) {
//	            String[] startArr = project.getStartdate().split("-"); // 시작일을 "-"로 분리하여 배열에 저장
//	            String[] endArr = project.getEnddate().split("-"); // 종료일을 "-"로 분리하여 배열에 저장
//
//	            startMonList.add(startArr[0]); // 시작 월을 리스트에 추가
//	            startDayList.add(startArr[1]); // 시작 일을 리스트에 추가
//	            endMonList.add(endArr[0]); // 종료 월을 리스트에 추가
//	            endDayList.add(endArr[1]); // 종료 일을 리스트에 추가
//	            psrnList.add(project.getPsrn()); // psrn을 리스트에 추가
//	            ptitleList.add(project.getPtitle()); // ptitle을 리스트에 추가
//	        }
//
	        Map<String, Object> result = new HashMap<>();
//	        result.put("startMonList", startMonList); // 시작 월 리스트를 결과 맵에 추가
//	        result.put("startDayList", startDayList); // 시작 일 리스트를 결과 맵에 추가
//	        result.put("endMonList", endMonList); // 종료 월 리스트를 결과 맵에 추가
//	        result.put("endDayList", endDayList); // 종료 일 리스트를 결과 맵에 추가
//	        result.put("psrnList", psrnList); // psrn 리스트를 결과 맵에 추가
//	        result.put("ptitleList", ptitleList); // ptitle 리스트를 결과 맵에 추가
	        result.put("projectlist", projectlist);
//	        
	        //System.out.println(service.p_readAll_go());
	        //System.out.println(startMonList);
	        
	        
	        return result;
	}
	
	@RequestMapping(value = "/project_go", method = RequestMethod.GET)
	public String getProjectDetail(Model model, int psrn, HttpSession session) {
		//System.out.println("---------------------------go?");
		//1. 업무장인지 확인가능 - 체크유무
		String loginid = (String)session.getAttribute("userid");
		
		
		//2. 멤버리스트초대된사람인지 확인가능- 조건걸어서..... 
		List<String> memberid = new ArrayList<>();
		String result_member = "false";
		for(UserVO u : service.invitemember_list(psrn)) {
			memberid.add(u.getUserid());
		}
		//System.out.println(memberid);
		for(int i = 0; i< memberid.size();i++) {
			if(loginid.equals(memberid.get(i))) { result_member="true"; }
		}
		model.addAttribute("result_member", result_member);
		model.addAttribute("result_mgr", service.p_read(psrn).getPmgrid());
		model.addAttribute("data", service.p_read(psrn));
		//model.addAttribute("memberlist", memberid);
		model.addAttribute("memberlistlength", memberid.size());
		return "summer_nh/calendarToProject";
	}
	
	@RequestMapping(value = "/project_update", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> updateProject_view(ProjectVO vo) {
		//System.out.println("..................................1");
		Map<String, Object> result = new HashMap<>();
		result.put("data", service.p_update_view(vo));
		return result;
	}

	@RequestMapping(value = "/project_update", method = RequestMethod.POST)
	public String updateProject(ProjectVO boardVO, RedirectAttributes rttr) {
		//System.out.println(".................................2");
		String result = "fail";
		if (service.p_update(boardVO) > 0) {
			result = "프로젝트가 수정되었습니다.";
		}
		//System.out.println(".................................3");
		rttr.addFlashAttribute("success", result);

		//System.out.println(".................................4");
		return "redirect:/calendar/project_go?psrn=" + boardVO.getPsrn();
	}
	@RequestMapping(value = "/project_delete", method = RequestMethod.GET)
	public String deletemember(InviteMemberVO vo, RedirectAttributes rttr, HttpSession session) {
		String result = "fail";
		int pgsrn = vo.getPgsrn();
		System.out.println(vo.getUid());
		System.out.println(vo.getPgsrn());
		if (service.deletemember(vo) > 0) {
			result = "멤버를 삭제하였습니다.";
		}
		rttr.addFlashAttribute("success", result);
		return "redirect:/calendar/project_go?psrn=" +pgsrn;
	}

}