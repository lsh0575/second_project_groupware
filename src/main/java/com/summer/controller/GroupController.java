package com.summer.controller;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.summer.dto.AccountVO;
import com.summer.service.ShService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/group/*")
@Log4j
public class GroupController {

	@Autowired
	ShService service;
	

	// 그룹 전체 리스트
	@RequestMapping(value = "/gmReadAll", method = RequestMethod.GET)
	public String gmReadAll(Model model) {
		model.addAttribute("gmReadAll", service.gmReadAll());
		return "summer_sh/group/groupMain";
	}

	// 그룹 상세 보기
	@RequestMapping(value = "/gdRead", method = RequestMethod.GET)
	public String gdRead(@RequestParam String summer_user_userid, AccountVO vo, Model model, HttpServletRequest request) {
	    vo.setSummer_user_userid(summer_user_userid);
		model.addAttribute("gdRead", service.gdRead(vo));
		model.addAttribute("gdRead2", service.gdRead2(vo));
		return "summer_sh/group/groupDetail";
	}

	// 그룹 추가 화면
	@RequestMapping(value = "/gaInsert", method = RequestMethod.GET)
	public String gaInsertView() {
		return "summer_sh/group/groupAdd";
	}

	// 로그인한 사용자의 아이디를 받아오는 메서드 예시
	private String getLoggedInUserId(HttpServletRequest request) {
		HttpSession session = request.getSession();
		String userId = (String) session.getAttribute("userId");
		return userId;
	}

	// 로그인 처리
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(AccountVO vo, HttpServletRequest request, RedirectAttributes rttr) {
		// 로그인 로직 실행
		String userId = service.login(vo); // 사용자 아이디 조회하는 로직을 구현한 메서드 호출
		if (userId != null) {
			// 로그인 성공 시 사용자 아이디를 세션에 저장
			request.getSession().setAttribute("userId", userId);
			rttr.addAttribute("success", "로그인에 성공하였습니다.");
			return "redirect:/group/gmReadAll";
		} else {
			// 로그인 실패
			rttr.addAttribute("error", "유효하지 않은 사용자 이름 또는 비밀번호입니다.");
			return "redirect:/account/loginCheck";
		}
	}

	// 그룹 추가 처리
	@RequestMapping(value = "/gaInsert", method = RequestMethod.POST)
	public String gaInsert(@ModelAttribute("vo") AccountVO vo, RedirectAttributes rttr, Model model) {
		String result = "fail";
		if(service.gaInsert(vo) > 0) { 
			result = "그룹생성이 완료되었습니다."; 
		}
		rttr.addAttribute("success",result);
		return "redirect:/group/gmReadAll"; 
	}

	// 그룹 수정 화면
	@RequestMapping(value = "/gUpdate", method = RequestMethod.GET)
	public String updateView(AccountVO vo, Model model) {
		model.addAttribute("gupdate", service.gUpdate_view(vo));
		return "summer_sh/group/groupModify";
	}

	// 그룹 수정 처리
	@RequestMapping(value = "/gUpdate", method = RequestMethod.POST)
	public String update(AccountVO vo, RedirectAttributes rttr) {
		String result = "fail";
		if (service.gUpdate(vo) > 0) {
			result = "그룹명 수정에 성공하였습니다.";
		}
		rttr.addAttribute("success", result);
		return "redirect:/group/gmReadAll";
	}

	// 그룹 삭제 GET 요청 처리
	@RequestMapping(value = "/gDelete", method = RequestMethod.GET)
	public String delete_view() {
		return "summer_sh/group/groupDelete";
	}

	// 그룹 삭제
	@RequestMapping(value = "/gDelete", method = RequestMethod.POST)
	public String delete(AccountVO vo, RedirectAttributes rttr) {
		String result = "fail";
		if (service.gDelete(vo) > 0) {
			result = "그룹이 삭제 되었습니다.";
		}
		rttr.addAttribute("success", result);
		return "redirect:/group/gmReadAll";
	}

}
