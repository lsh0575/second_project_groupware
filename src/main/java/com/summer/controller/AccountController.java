package com.summer.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.summer.dto.AccountVO;
import com.summer.dto.InviteMemberVO;
import com.summer.service.ShService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/account/*")
@Log4j
public class AccountController {

	@Autowired
	ShService service;

	// 회원 전체리스트
	// 그룹에 속하지 않은 회원 목록을 불러온 후 모달 화면을 반환
	@RequestMapping(value = "/loadNonGroupMembers", method = RequestMethod.GET)
	@ResponseBody
	public ResponseEntity<List<AccountVO>> loadNonGroupMembers(HttpServletRequest request) {
		String userId = (String) request.getSession().getAttribute("userid");
		// String userName = (String) request.getSession().getAttribute("username");

		// 그룹에 속하지 않은 회원 목록을 조회하는 로직을 구현
		List<AccountVO> nonGroupMembers = service.loadNonGroupMembers(userId);
		return ResponseEntity.ok(nonGroupMembers);
	}

	// 로그인 전 메인페이지
	@RequestMapping(value = "/uBefore", method = RequestMethod.GET)
	public String beforeLogin() {
		return "summer_sh/account/beforeLoginMain";
	}

	// 이용약관 페이지
	@RequestMapping(value = "/termsOfUse", method = RequestMethod.GET)
	public String termsOfUse() {
		return "summer_sh/account/termsOfUse";
	}

	// 회원 가입
	@RequestMapping(value = "/uInsert", method = RequestMethod.GET)
	public String uInsert_view() {
		return "summer_sh/account/joinMembership";
	}

	// 회원 가입 처리
	@RequestMapping(value = "/uInsert", method = RequestMethod.POST)
	public void uInsert(AccountVO vo, HttpServletRequest request, HttpServletResponse response) throws IOException {
		request.setCharacterEncoding("UTF-8");
	    response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		try {
			if ( service.uInsert(vo) > 0) {
				out.println("<script>alert('회원가입에 성공하였습니다.'); location.href='" + request.getContextPath()
	              + "/account/uBefore';</script>");
			} else {
				out.println("<script>alert('관리자에게 문의 바랍니다.'); javascript:history.go(-1);</script>");
			}
			// service.uInsert(vo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		//return "redirect:/account/uBefore";
	}

	// 아이디 중복체크
	@RequestMapping(value = "/uIdCheck", method = RequestMethod.GET)
	@ResponseBody
	public ResponseEntity<String> uIdCheck(@RequestParam("id") String id) {
		String result = service.uIdCheck(id);
		if (result.equals("exist")) {
			return new ResponseEntity<>(result, HttpStatus.OK);
		} else {
			return new ResponseEntity<>(result, HttpStatus.OK);
		}
	}

	// 이메일 중복체크
	@RequestMapping(value = "/uEmailCheck", method = RequestMethod.GET)
	@ResponseBody
	public ResponseEntity<String> uEmailCheck(@RequestParam("email") String email) {
		String result = service.uEmailCheck(email);
		if (result.equals("exist")) {
			return new ResponseEntity<>(result, HttpStatus.OK);
		} else {
			return new ResponseEntity<>(result, HttpStatus.OK);
		}
	}

	// 로그인
	@RequestMapping(value = "/loginCheck", method = RequestMethod.GET)
	public String loginForm() {
//		// 로그인 페이지로 이동하는 코드
		return "summer_sh/account/beforeLoginMain";

	}

	// 로그인 처리
	@RequestMapping(value = "/loginCheck", method = RequestMethod.POST)
	public void loginCheck(AccountVO vo, HttpServletRequest request, HttpServletResponse response) {
		int result = service.loginCheck(vo, request);
		try {
			request.setCharacterEncoding("UTF-8");
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			if ( result == 1) {
				HttpSession session = request.getSession();
				session.setAttribute("userid", vo.getUserid());
				out.println("<script>alert('로그인에 성공하였습니다.'); location.href='" + request.getContextPath()
	              + "/account/afterLoginMain';</script>");
			} else if (result != 1) {
				out.println("<script>alert('관리자에게 문의 바랍니다.'); javascript:history.go(-1);</script>");
			} else {
				// 로그인 실패
				out.println("<script>alert('아이디 또는 패스워드를 확인해주세요.'); location.href='" + request.getContextPath()
	            + "/summer_sh/account/beforeLoginMain</script>");
			}
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}

	}

	// 로그인 후 메인 페이지
	@RequestMapping(value = "/afterLoginMain", method = RequestMethod.GET)
	public String afterLogin() {
		return "summer_sh/account/afterLoginMain";
	}

	// 아이디 패스워드 찾기 페이지
	@RequestMapping(value = "/idPasswordSearch", method = RequestMethod.GET)
	public String idPasswordSearch() {
		return "summer_sh/account/idPasswordSearch";
	}

	// 아이디 찾기 처리
	@RequestMapping(value = "/idSearch", method = { RequestMethod.GET, RequestMethod.POST })
	public String idSearch(HttpServletResponse response, @RequestParam("searchKey") String searchKey, Model model)
			throws IOException {
		String id = service.idSearch(response, searchKey);
		if (id == null) {
			model.addAttribute("message", "가입된 아이디가 없습니다.");
		} else {
			model.addAttribute("message", "찾으시는 아이디는 " + id + "입니다.");
		}
		return "summer_sh/account/idPasswordSearch";
	}

	// 패스워드 찾기 처리
	@RequestMapping(value = "/pwSearch", method = { RequestMethod.GET, RequestMethod.POST })
	public void pwSearch(@ModelAttribute AccountVO vo, HttpServletResponse response, String searchKey,
			String passSearchId) throws Exception {
		service.pwSearch(response, vo, searchKey, passSearchId);
	}

	// 메인페이지 로그아웃
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		service.logout(session);
		return "redirect:/account/uBefore";
	}

	// 사용자 마이페이지
	@RequestMapping(value = "/mmdRead", method = RequestMethod.GET)
	public String mmdRead(Model model, HttpServletRequest request) {
		// 사용자 정보 조회
		String userId = (String) request.getSession().getAttribute("userid"); // 실제 사용자 아이디로 대체해야 함
		AccountVO account = new AccountVO();
		account.setUserid(userId);
		AccountVO userDetails = service.mmdRead(account);

		// 사용자 정보를 모델에 추가
		model.addAttribute("userDetails", userDetails);

		// 사용자 마이페이지 JSP 페이지로 이동
		return "summer_sh/account/memberMypageDetail";
	}

	// 사용자 마이페이지 업데이트
	@RequestMapping(value = "/uUpdate", method = RequestMethod.GET)
	public String update_view(@ModelAttribute("vo") AccountVO vo, Model model, HttpServletRequest request) {
		// 사용자 정보 조회
		// 실제 사용자 아이디 받아오기
		String userId = (String) request.getSession().getAttribute("userid");
		AccountVO account = new AccountVO();
		account.setUserid(userId);
		AccountVO userUpdate = service.mmdRead(account);

		// 사용자 정보를 모델에 추가
		model.addAttribute("userUpdate", userUpdate);

		model.addAttribute("user", service.update_view(vo));

		return "summer_sh/account/memberMypageEdit";
	}

	// 사용자 마이페이지 업데이트 처리
	@RequestMapping(value = "/uUpdate", method = RequestMethod.POST)
	public String uUpdate(AccountVO vo, RedirectAttributes rttr) {
		String result = "fail";
		if (service.uUpdate(vo) > 0) {
			result = "회원정보 수정에 성공하였습니다.";
		}
		rttr.addAttribute("success", result);
		return "redirect:/account/mmdRead?userid=" + vo.getUserid();

	}

	// 사용자 탈퇴
	@RequestMapping(value = "/uDelete", method = RequestMethod.GET)
	public String uDelete_view() {
		return "summer_sh/account/memberCancel";
	}
	// 사용자 탈퇴 처리
	@RequestMapping(value = "/uDelete", method = RequestMethod.POST)
	public void uDelete(AccountVO vo, HttpServletRequest request, HttpServletResponse response) throws IOException {
		int count = service.uDelete(vo);
		request.setCharacterEncoding("UTF-8");
	    response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		if ( count > 0 ) {
			out.println("<script>alert('회원 탈퇴에 성공하였습니다. 자동 로그아웃 됩니다.'); location.href='" + request.getContextPath()
              + "/account/uBefore';</script>");
		} else {
			out.println("<script>alert('아이디 또는 비밀번호를 확인해주세요.'); javascript:history.go(-1);</script>");
		}
	}


}

