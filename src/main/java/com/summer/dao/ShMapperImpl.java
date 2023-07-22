package com.summer.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;

import com.summer.dto.AccountVO;
import com.summer.dto.InviteMemberVO;

//@Repository
public class ShMapperImpl implements ShMapper {

	@Autowired
	private ShMapper sm;

	// @Inject SqlSession sqlSession; // SqlSession 의존관계 주입ㅇ

	@Override
	public List<AccountVO> readAll() {
		return sm.readAll();
	}

	// 회원가입
	@Override
	public int uInsert(AccountVO vo) {
		return sm.uInsert(vo);
	}

	// 회원가입 시 아이디 중복체크
	@Override
	public int uIdCheck(String user_id) {
		return sm.uIdCheck(user_id);
	}

	// 회원가입 시 이메일 중복체크
	@Override
	public int uEmailCheck(String user_email) {
		return sm.uEmailCheck(user_email);
	}

	// 아이디 찾기
	@Override
	public String idSearch(String id_search) {
		return sm.idSearch(id_search);
	}

	// 패스워드 체크
	@Override
	public int pwIdCheck(Map<String, Object> param) {
		return sm.pwIdCheck(param);
	}

	// 임시비밀번호 생성 후 DB 업데이트
	@Override
	public void updatePw(Map<String, Object> param) {
		sm.updatePw(param);
	}

	// 로그인
	@Override
	public int loginCheck(AccountVO vo) {
		return sm.loginCheck(vo);
	}

	// 그룹 메인
	@Override
	public List<AccountVO> gmReadAll() {
		return sm.gmReadAll();
	}

	// 그룹멤버 상세보기
	@Override
	public AccountVO mmdRead(AccountVO vo) {
		return sm.mmdRead(vo);
	}

	// 그룹 멤버 현황
	@Override
	public List<AccountVO> gdRead(AccountVO vo) {
		return sm.gdRead(vo);
	}

	// 그룹 멤버 현황 - 하단 초대 리스트
	@Override
	public List<AccountVO> gdRead2(AccountVO vo) {
		return sm.gdRead2(vo);
	}

	// 그룹추가
	@Override
	public int gaInsert(AccountVO vo) {
		return sm.gaInsert(vo);
	}

	// 그룹 삭제
	@Override
	public int gDelete(AccountVO vo) {
		return sm.gDelete(vo);
	}
	
	// 그룹명 업데이트
	@Override
	public int gUpdate(AccountVO vo) {
		return sm.gUpdate(vo);
	}

	// 사용자 마이페이지 업데이트
	@Override
	public int uUpdate(AccountVO vo) {
		return sm.uUpdate(vo);
	}

	// 사용자 탈퇴
	@Override
	public int uDelete(AccountVO vo) {
		return sm.uDelete(vo);
	}
	
	// 그룹 초대 추가
	@Override
	public int inviteInsert(Map<String, Object> para) {
		
		return sm.inviteInsert(para);
	}

	// 알림페이지 초대 리스트(그룹, 프로젝트)
	@Override
	public List<InviteMemberVO> inviteAll(InviteMemberVO vo) {
		return sm.inviteAll(vo);
	}
	
	@Override
	public int inviteAccept(Map<String, Object> para) {
		Map<String, Object> para1 =  new HashMap<>();
		para1.put(null, para1);
		para1.put(null, para1);
		
		return sm.inviteAccept(para1);
	}

    @Override
    public List<AccountVO> getNonGroupMembers(String userId) {
        return sm.getNonGroupMembers(userId);
    }

	// 멤버 초대 삭제
    @Override
    public int inviteDelete(InviteMemberVO vo) {
        return sm.inviteDelete(vo);
    }

}
