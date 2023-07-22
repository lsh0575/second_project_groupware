package com.summer.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.summer.dto.InviteMemberVO;
import com.summer.service.ShService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/invit/*")
@Log4j
public class InvitController {

	@Autowired
	ShService service;
	
	// 멤버초대 버튼 클릭 시
	@RequestMapping(value = "/inviteInsert", method = RequestMethod.GET)
	@ResponseBody
	public void inviteInsert(InviteMemberVO vo, RedirectAttributes rttr, HttpSession session) {
		String result = "fail";

		if (service.inviteInsert(vo) > 0) {
			result = "초대 요청을 보냈습니다.";
		} else {
			result = "관리자에 문의 바랍니다.";
		}
		rttr.addFlashAttribute("success", result);
	}

	// 멤버 초대 삭제
	@RequestMapping(value = "/inviteDelete", method = RequestMethod.DELETE)
	public void inviteDelete(@RequestParam String uid, @RequestParam int pgsrn, HttpServletResponse response, HttpServletRequest request ) throws IOException {
		request.setCharacterEncoding("UTF-8");
	    response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		InviteMemberVO vo = new InviteMemberVO();
		vo.setUid(uid);
		vo.setPgsrn(pgsrn);
		if (service.inviteDelete(vo) > 0) {
		      out.println("<script>alert('멤버가 삭제되었습니다.'); location.href='" + request.getContextPath()
              + "/group/gdRead';</script>");
		} else {
			 out.println("<script>alert('관리자에게 문의 바랍니다.'); javascript:history.go(-1);</script>");
		}
	}
}
