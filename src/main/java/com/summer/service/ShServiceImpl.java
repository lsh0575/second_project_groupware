package com.summer.service;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.summer.dao.ShMapper;
import com.summer.dto.AccountVO;
import com.summer.dto.InviteMemberVO;

@Service("shService")
public class ShServiceImpl implements ShService {

	@Autowired
	ShMapper sm;

	@Override
	public List<AccountVO> readAll() {
		return sm.readAll();
	}

	// 회원가입
	@Override
	public int uInsert(AccountVO vo) {
		try {
			vo.setUserip(InetAddress.getLocalHost().getHostAddress());
		} catch (UnknownHostException e) {
			e.printStackTrace();
		}
		return sm.uInsert(vo);
	}

	// 회원가입 시 아이디 중복체크
	@Override
	public String uIdCheck(String user_id) {
		String result = "Username is available.";
		if (sm.uIdCheck(user_id) > 0) {
			result = "This ID is not available.";
		}
		return result;
	}

	// 회원가입 시 이메일 중복체크
	@Override
	public String uEmailCheck(String user_email) {
		String result = "Email is available.";
		if (sm.uEmailCheck(user_email) > 0) {
			result = "This Email is not available.";
		}
		return result;
	}

	// 아이디 찾기
	@Override
	public String idSearch(HttpServletResponse response, String searchKey) throws IOException {
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		String id = sm.idSearch(searchKey);

		if (id == null) {
			out.println("<script>");
			out.println("alert('가입된 아이디가 없습니다.');");
			out.println("history.go(-1);");
			out.println("</script>");
			out.close();
			return null;
		} else {
			out.println("<script>");
			out.println("alert('가입된 아이디는 [ " + id + " ] 입니다.');");
			out.println("history.go(-1);");
			out.println("</script>");
			out.close();
			return id;
		}
	}

	// 비밀번호 찾기
	@Override
	public void pwSearch(HttpServletResponse response, AccountVO vo, String searchKey, String passSearchId)
			throws Exception {
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		Map<String, Object> param = new HashMap<String, Object>();

		param.put("userid", passSearchId);
		param.put("useremail", searchKey);

		int pwCheck = sm.pwIdCheck(param);

		if (pwCheck > 0) {
			String pw = "";
			for (int i = 0; i < 12; i++) {
				pw += (char) ((Math.random() * 26) + 97);
			}

			// 임시 비밀번호 변경 생성
			vo.setUserpass(pw);

			// 아이디, 이메일 선언
			vo.setUserid(passSearchId);
			vo.setUseremail(searchKey);

			// 비밀번호 변경 메일 발송
			sendEmail(vo);

			// 비밀번호 DB 업데이트
			param.put("userpass", pw);
			sm.updatePw(param);

			String message = "이메일로 임시 비밀번호를 발송하였습니다. ";
			out.print("<script>alert('" + message + "'); location.href = history.go(-1);</script>");

		} else {
			String message = "가입된 아이디 또는 이메일을 확인 해주세요.";
			out.print("<script>alert('" + message + "'); location.href = history.go(-1);</script>");
		}
	}

	// 임시비밀번호 이메일 보내기 기능
	@Override
	public void sendEmail(AccountVO vo) throws Exception {

		String smtp_host = "smtp.gmail.com";

		// 관리자 구글 이메일 ( 이메일 보내는 사람 )
		String user_email = "ilovebcc20@gmail.com";

		// 관리자 구글 2차 인증 패스워드
		String user_pw = "abousfmvynbnzvfw";

		int smtp_port = 465; // TLS : 587, SSL : 465

		Properties props = System.getProperties();
		props.put("mail.smtp.host", smtp_host);
		props.put("mail.smtp.port", smtp_port);
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.ssl.enable", "true");
		props.put("mail.smtp.ssl.trust", smtp_host);

		Session session = Session.getInstance(props, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(user_email, user_pw);
			}
		});
		try {
			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress(user_email));

			// 사용자 이메일 ( 이메일 받는 사람 )
			message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(vo.getUseremail()));

			// 메시지 제목
			String subject = "SUMMER GROUPWARE 임시 비밀번호 입니다.";

			// 메시지 내용
			String htmlMsg = "<div align='center' style='border:1px solid black; font-family:verdana'>";
			htmlMsg += "<h3 style='color: blue;'>";
			htmlMsg += vo.getUserid() + "님의 임시 비밀번호 입니다. 반드시 비밀번호를 변경하여 사용하세요.</h3>";
			htmlMsg += "<p>임시 비밀번호 : ";
			htmlMsg += vo.getUserpass() + "</p></div>";

			MimeBodyPart messageBodyPart = new MimeBodyPart();
			messageBodyPart.setContent(htmlMsg, "text/html; charset=utf-8");

			Multipart multipart = new MimeMultipart();
			multipart.addBodyPart(messageBodyPart);

			message.setContent(multipart);

			message.setSubject(subject);

			Transport.send(message);

		} catch (MessagingException e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}
	}

	// 로그인
	@Override
	public int loginCheck(AccountVO vo, HttpServletRequest request) {
		int result = -1;
		int loginResult = sm.loginCheck(vo);

		if (loginResult == 1) {
			// 로그인 성공
			request.getSession().setAttribute("userid", vo.getUserid());
			result = 1;
		} else if (loginResult == 0) {
			// 비밀번호 일치하지 않음
			result = -2;
		} else if (loginResult == -1) {
			// 아이디 존재하지 않음
			result = -3;
		}
		return result;
	}

	// 로그아웃
	@Override
	public void logout(HttpSession session) {
		session.invalidate(); // 세션 초기화
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
		String groupId = vo.getGroupname();

		// 아이디 중복 체크
		if (sm.uIdCheck(groupId) > 0) {
			throw new IllegalArgumentException("이미 사용 중인 그룹 아이디입니다.");
		}
		return sm.gaInsert(vo);
	}

	// 그룹 추가 아이디 확인
	@Override
	public String login(AccountVO vo) {
		String groupId = vo.getGroupname();

		// 그룹 아이디 중복 체크
		if (sm.uIdCheck(groupId) > 0) {
			return "This group ID is not available.";
		}

		return "Group ID is available.";
	}

	// 그룹 삭제
	@Override
	public int gDelete(AccountVO vo) {
		return sm.gDelete(vo);
	}

	// 그룹 업데이트
	@Override
	public int gUpdate(AccountVO vo) {
		return sm.gUpdate(vo);
	}

	// 그룹 업데이트 뷰
	@Override
	public List<AccountVO> gUpdate_view(AccountVO vo) {
		return sm.gdRead(vo);
	}

	// 사용자 마이페이지 업데이트
	@Override
	public int uUpdate(AccountVO vo) {
		return sm.uUpdate(vo);
	}

	// 사용자 마이페이지 업데이트 뷰
	@Override
	public AccountVO update_view(AccountVO vo) {
		return sm.mmdRead(vo);
	}

	// 사용자 탈퇴
	@Override
	public int uDelete(AccountVO vo) {
		return sm.uDelete(vo);
	}

	// 그룹 초대 추가
	@Override
	public int inviteInsert(InviteMemberVO vo) {
		Map<String, Object> para = new HashMap<>();
		para.put("uid", vo.getUid());
		para.put("pgsrn", vo.getPgsrn());

		return sm.inviteInsert(para);
	}

	//
	@Override
	public List<AccountVO> loadNonGroupMembers(String userId) {
		return sm.getNonGroupMembers(userId);
	}

	// 알림페이지 초대 리스트(그룹, 프로젝트)
	@Override
	public int inviteAccept(String uid, int pgsrn) {
		Map<String, Object> para = new HashMap<>();
		para.put(null, para);
		para.put(null, para);

		return sm.inviteAccept(para);
	}

	// 멤버 초대 삭제
	@Override
	public int inviteDelete(InviteMemberVO vo) {
		return sm.inviteDelete(vo);
	}

	@Override
	public List<InviteMemberVO> inviteAll(InviteMemberVO vo) {
		return sm.inviteAll(vo);
	}

}
