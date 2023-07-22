package com.summer.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.TemporalAdjusters;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.summer.dto.GroupUserInfo;
import com.summer.dto.GroupWorkingHour;
import com.summer.dto.Workflow;
import com.summer.dto.WorkflowCategory;
import com.summer.dto.WorkingHour;
import com.summer.service.HeService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping(value = "/work/*")
@Log4j
public class WorkController {

	@Autowired
	HeService service;

	@Transactional
	@GetMapping(value = "/workinghour")
	public String workinghour(Map<String, String> para, Model model, HttpSession session) {
		// 날짜시작일, 종료일 코드 작성
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String currentDate = sdf.format(new Date());
		LocalDate firstDate = LocalDate.now().with(TemporalAdjusters.firstDayOfMonth());
		String firstDateString = firstDate.format(DateTimeFormatter.ISO_DATE);

		// session에서 받아오기
		para.put("userid", (String)session.getAttribute("userid"));
		para.put("whdate1", firstDateString);
		para.put("whdate2", currentDate);

		model.addAttribute("list", service.monthlyWorkingHour(para));

		/* select * from workinghour where whdate=#{whdate} and userid=#{userid} */
		int result = 0;
		int resulthour = 0;
		int resultmin = 0;
		int resultleader = 0;
		WorkingHour wh = new WorkingHour();
		wh.setWhdate(currentDate);
		// session에서 받아온 값
		wh.setUserid((String)session.getAttribute("userid"));

		String whgotime = service.selectWorkingHour(wh).getWhgotime(); // 17:41
		String whleavetime = service.selectWorkingHour(wh).getWhleavetime(); // 17:41
		
		String whgotimehour = whgotime.substring(0, 2);// 17
		String whgotimemin = whgotime.substring(3); // 41
		
		String whleavetimehour = whleavetime.substring(0, 2); // 17
		String whleavetimemin = whleavetime.substring(3); // 41

		int whgotimehourpar = Integer.valueOf(whgotimehour); // 17 숫자
		int whgotimeminpar = Integer.valueOf(whgotimemin); // 41 숫자

		int whleavetimehourpar = Integer.valueOf(whleavetimehour); // 17 숫자
		int whleavetimeminpar = Integer.valueOf(whleavetimemin); // 41 숫자

		if (whleavetimeminpar - whgotimeminpar < 0) {
			resulthour = (whleavetimehourpar - whgotimehourpar - 1);
			resultmin = (whleavetimeminpar - whgotimeminpar + 60);
		} else {
			resulthour = (whleavetimehourpar - whgotimehourpar);
			resultmin = (whleavetimeminpar - whgotimeminpar);
		} 

		model.addAttribute("resulthour", resulthour);
		model.addAttribute("resultmin", resultmin);
		model.addAttribute("selectworkinghour", service.selectWorkingHour(wh));
		//model.addAttribute("groupcheck", service.selectName((String)session.getAttribute("userid")));
		//그룹장인지 확인
		model.addAttribute("groupleader", service.groupLeaderId());
		//아이디는 세션에서 받아온 값
		if(service.groupLeaderId().contains((String)session.getAttribute("userid"))) {
			resultleader = 1;
		}
		
		// 출근버튼 누른 이력 있고, 출근시간=퇴근시간 > 퇴근버튼 안 누른것임. result 2로 넘기기
		if (service.selectWorkingHour(wh).getWhdate() != null) {
			if (service.selectWorkingHour(wh).getWhgotime().equals(service.selectWorkingHour(wh).getWhleavetime())) {
				result = 2;
			} else {
				// 출근버튼 누른 이력 있고, 출근시간!=퇴근시간 > 퇴근버튼 누른것. result 1로 넘기기
				result = 1;
			}
		}
		model.addAttribute("result", result);
		model.addAttribute("resultleader", resultleader);
		return "summer_he/workinghour";
	}
	
	
	@GetMapping(value = "/gotimeinsert")
	@ResponseBody
	public void gotimeinsert(WorkingHour wh, HttpSession session) {
		wh.setUserid((String)session.getAttribute("userid"));
		service.whgotimeInsert(wh);
	}

	@GetMapping(value = "/monthlyWorkingHour")
	public String monthlyWorkingHour(@RequestParam String userid, @RequestParam String username, Model model, HttpSession session) {
		/*
		 * select * from workinghour where userid=#{userid} and whdate &gt;= #{whdate1}
		 * and whdate &lt;= #{whdate2} order by whdate;
		 */ SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String currentDate = sdf.format(new Date());
		LocalDate firstDate = LocalDate.now().with(TemporalAdjusters.firstDayOfMonth());
		String firstDateString = firstDate.format(DateTimeFormatter.ISO_DATE);

		Map<String, String> para = new HashMap<>();
		para.put("userid", userid);
		// 한달 시작일, 종료일 구하기
		para.put("whdate1", firstDateString);
		para.put("whdate2", currentDate);

		model.addAttribute("name", username);
		model.addAttribute("list", service.monthlyWorkingHour(para));

		return "summer_he/groupmonthlyworkinghour";
	}

	@PostMapping(value = "/leavetimeupdate")
	@ResponseBody
	public void leavetimeupdate(WorkingHour wh, HttpSession session) {
		wh.setUserid((String)session.getAttribute("userid"));
		service.whleavetimeUpdate(wh);
	}

	@Transactional
	@GetMapping(value = "/totaldayoff")
	public String totaldayoff(String para, HttpSession session, Model model) {
		para = (String)session.getAttribute("userid");
		// para = session.getAttribute("userid");
		log.info(service.totalDayOff(para));
		model.addAttribute("totaldayoff", service.totalDayOff(para));
		model.addAttribute("usedayoff", service.useDayOffSum(para));
		// model.addAttribute("datediff", service.dateDiff(para));
		model.addAttribute("list", service.selectWfapplyDate(para));
		// model.addAttribute("usedayoffdate", service.useDayOffDate(para));
		return "summer_he/dayoff";
	}

	@Transactional
	@GetMapping(value = "/workflow")
	public String workflow(String para, Model model, HttpSession session) {
		para = (String)session.getAttribute("userid");
		int result = 0;
		
		if(service.groupLeaderId().contains(para)) {
		result = 1;
		}
		model.addAttribute("list", service.listWorkflow(para));
		model.addAttribute("result", result);
		return "summer_he/workflow";
	}

	@GetMapping(value = "/workflowdraft")
	public String workflowdraft(String para, Model model, HttpSession session) {
		para = (String)session.getAttribute("userid");
		model.addAttribute("list", service.listWorkflow(para));
		return "summer_he/workflowdraft";
	}

	@GetMapping(value = "/deleteworkflow")
	public void deleteworkflow(Workflow wf, Model model, HttpServletResponse response, HttpServletRequest request)
			throws IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		if (service.deleteWorkflow(wf) > 0) {
			out.println("<script>alert('기안이 삭제되었습니다.'); location.href='" + request.getContextPath()
					+ "/work/workflowdraft';</script>");
		} else {
			out.println("<script>alert('승인 혹은 반려된 기안은 삭제가 불가합니다.'); javascript:history.go(-1);</script>");
		}
	}

	@GetMapping(value = "/groupWorkingHour")
	@ResponseBody
	public List<GroupUserInfo> groupWorkingHour(HttpSession session) {
	String userid = (String)session.getAttribute("userid");
		List<GroupUserInfo> result = new ArrayList<>();
		result = service.selectName(userid);
		return result;
	}

	@GetMapping(value = "/workflowcategoryview")
	@ResponseBody
	public WorkflowCategory workflowcategoryview(@RequestParam int wfcsrn) throws IOException {
		return service.workflowcategoryView(wfcsrn);
	}

	@GetMapping(value = "/selectWorkingHour")
	@ResponseBody
	public WorkingHour selectWorkingHour(@RequestParam String whdate, HttpSession session) {
		WorkingHour wh = new WorkingHour();
		wh.setWhdate(whdate);
		log.info((String)session.getAttribute("userid"));
		wh.setUserid((String)session.getAttribute("userid"));
		return service.selectWorkingHour(wh);
	}

	@Transactional
	@PostMapping(value = "/insertWorkFlow")
	public void insertWorkFlow(Workflow wf, @RequestParam String whdate, @RequestParam String whgotime, @RequestParam String whleavetime, HttpServletResponse response, HttpServletRequest request, Model model, HttpSession session)
			throws IOException {
		
		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		String userid = (String)session.getAttribute("userid");
		Map<String, String> para = new HashMap<>();
		
		wf.setUserid(userid);

		WorkingHour wh = new WorkingHour();
		wh.setWhgotime(wf.getWfapplystarttime());
		wh.setWhleavetime(wf.getWfapplyendtime());
		wh.setUserid(wf.getUserid());
		wh.setWhdate(wf.getWfapplystartdate());

		//그룹장일 경우, 자기전결로 승인
		if(service.groupLeaderId().contains(userid)) {
			//전자결재 승인 상태로 들어감.
			if(service.insertWorkFlowLeader(wf) > 0) {
				// 휴가일 경우, 휴가 테이블에 넣기
				if(wf.getWfcsrn() != 4){
					wf.setUserid(userid);
					//wf.setWfcsrn(service.selectwfsrn(userid));
					//log.info(service.selectdateDiff(wf));
					service.insertDayOff(wf);

				//출퇴근일 경우, 원래 이력 넣어주고, 출퇴근 테이블 업데이트
				} else if(wf.getWfcsrn() == 4) {
					para.put("userid", userid);
					para.put("whdate",  whdate);
					
					service.insertOriginWH(para);
					service.editWorkingHour(wh);
				}
				out.println("<script>alert('그룹장일 경우, 본인전결로 기안이 승인됩니다.'); location.href='" + request.getContextPath()
				+ "/work/workflowdraft'</script>");
			} else {
				out.println("<script>alert('관리자에게 문의바랍니다.'); javascript:history.go(-1);</script>");
			}
			// 그룹원일 경우,
		} else if(service.groupId().contains(userid)) {
				if (service.insertWorkFlow(wf) > 0) {
					out.println("<script>alert('기안이 완료되었습니다.'); location.href='" + request.getContextPath()
							+ "/work/workflowdraft'</script>");
				} else {
					out.println("<script>alert('관리자에게 문의바랍니다.'); javascript:history.go(-1);</script>");
				}
			//그룹장도 그룹원도 아닐 경우,
			} else {
				out.println("<script>alert('그룹에 속해있지 않아 기안이 불가합니다.'); javascript:history.go(-1);</script>");
			}
		
	}

	@GetMapping(value = "/groupWorkflow")
	public String groupWorkflow(Model model, HttpSession session) {
		// session에서 받아오기
		String userid = (String)session.getAttribute("userid");
		model.addAttribute("list", service.groupWorkflow(userid));

		return "summer_he/groupworkflow";
	}

	@GetMapping(value = "/detailWorkflow")
	@ResponseBody
	public Workflow detailWorkflow(@RequestParam int wfsrn) {
		Workflow wf = new Workflow();
		wf.setWfsrn(wfsrn);
		return service.detailWorkflow(wf);
	}

	@Transactional
	@PostMapping(value = "/checkworkflow")
	public void checkworkflow(String check, Workflow wf, HttpServletResponse response, HttpServletRequest request,
			Model model) throws IOException {

		// System.out.println(check);
		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		WorkingHour wh = new WorkingHour();
		wh.setWhgotime(wf.getWfapplystarttime());
		wh.setWhleavetime(wf.getWfapplyendtime());
		wh.setUserid(wf.getUserid());
		wh.setWhdate(wf.getWfapplystartdate());

		Map<String, String> para = new HashMap<>();
		para.put("userid", wf.getUserid());
		//수정하고, whdate보내줘야함 전 단계에서
		para.put("whdate", wf.getWfapplystartdate());
		
		// 승인 버튼 누르면
		if (check.equals("OK")) {
			// 전자결재 상태 업데이트 완료되면
			if (service.acceptworkflow(wf) > 0) {
				// 출퇴근수정 카테고리일경우, workinghour 업데이트 + 원래 이력 넣기
				if (wf.getWfcsrn() == 4) {
					service.insertOriginWH(para);
					service.editWorkingHour(wh);
					// 휴가신청일 경우, 종료일-시작일 0이 아닐 경우 신청일수만큼 dayoff에 insert
				} else if(wf.getWfcsrn() != 4){
					if (service.selectdateDiff(wf) != 0) {
						for (int i = 0; i < service.selectdateDiff(wf) + 1; i++) {
							service.insertDayOff(wf);
						}
					} else {
						service.insertDayOff(wf);
					}
				}
				out.println("<script>alert('기안 승인이 완료되었습니다.'); location.href='" + request.getContextPath()
						+ "/work/groupWorkflow';</script>");

			} else {
				// 전자결재 상태 업데이트 x
				out.println("<script>alert('기안 승인이 불가합니다.'); javascript:history.go(-1);</script>");
			}
		}
		// 반려버튼 누르면
		else {
			// 전자결재 상태 반려로 업데이트
			service.rejectworkflow(wf);
			out.println("<script>alert('기안 반려가 완료되었습니다.'); location.href='" + request.getContextPath()
					+ "/work/groupWorkflow';</script>");
		}
	}
}