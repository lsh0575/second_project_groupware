package com.summer.service;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.summer.dto.AccountVO;
import com.summer.dto.InviteMemberVO;

public interface ShService {

	public List<AccountVO> readAll();

	// 회원가입
	public int uInsert(AccountVO vo);

	// 회원가입 시 아이디 중복체크
	public String uIdCheck(String user_id);

	// 회원가입 시 이메일 중복체크
	public String uEmailCheck(String user_email);

	// 아이디 찾기
	public String idSearch(HttpServletResponse response, String id_search) throws IOException;

	// 비밀번호 찾기
	public void pwSearch(HttpServletResponse response, AccountVO vo, String searchKey, String passSearchId)
			throws Exception;

	// 이메일 발송
	public void sendEmail(AccountVO vo) throws Exception;

	// 로그인
	public int loginCheck(AccountVO vo, HttpServletRequest request);

	// 로그아웃
	public void logout(HttpSession session);

	// 그룹 메인
	public List<AccountVO> gmReadAll();
	
	// 그룹멤버 상세보기
	public AccountVO mmdRead(AccountVO vo);

	// 그룹 멤버 현황
	public List<AccountVO> gdRead(AccountVO vo);

	// 그룹 멤버 현황 - 하단 초대 리스트
	public List<AccountVO> gdRead2(AccountVO vo);

	// 그룹추가
	public int gaInsert(AccountVO vo);

	// 그룹 추가 아이디 확인
	public String login(AccountVO vo);

	// 그룹 삭제
	public int gDelete(AccountVO vo);

	// 그룹 업데이트
	public int gUpdate(AccountVO vo);

	// 그룹 업데이트 뷰
	public List<AccountVO> gUpdate_view(AccountVO vo);

	// 사용자 마이페이지 업데이트
	public int uUpdate(AccountVO vo);

	// 사용자 마이페이지 업데이트 뷰
	public AccountVO update_view(AccountVO vo);

	// 사용자 탈퇴
	public int uDelete(AccountVO vo);

	// 초대 전체 리스트
	public List<InviteMemberVO> inviteAll(InviteMemberVO vo);
	
	// 그룹 초대 추가
	public int inviteInsert(InviteMemberVO vo);

	// 알림페이지 초대 리스트(그룹, 프로젝트)
	public int inviteAccept(String uid, int pgsrn);

    // 그룹에 속하지 않은 회원 목록 조회
    public List<AccountVO> loadNonGroupMembers(String userId);

	// 멤버 초대 삭제
    public int inviteDelete(InviteMemberVO vo);




}
