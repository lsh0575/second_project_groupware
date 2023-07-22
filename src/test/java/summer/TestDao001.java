package summer;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.TemporalAdjusters;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.summer.dao.HeDao;
import com.summer.dto.Dayoff;
import com.summer.dto.Workflow;
import com.summer.dto.WorkflowDate;
import com.summer.dto.WorkingHour;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/**/root-context.xml" })
@Log4j
public class TestDao001 {

	@Autowired
	HeDao dao;

	// 출근버튼 눌렀을 때 - 출근시간 insert
	@Test
	@Ignore
	public void test0() {
		// 날짜, 출근시간 현재 날짜로 / userid
		dao.whgotimeInsert(new WorkingHour("2023-06-26", "17:34", "17:34", "dagmm"));
	}

	// 퇴근버튼 눌렀을 때 - 퇴근시간 insert
	@Test
	@Ignore
	public void test1() {
		// whsrn 받아와야 함.
		dao.whleavetimeUpdate(new WorkingHour(9, "17:59", "dagmm"));
	}

	// 오늘날짜까지 출퇴근이력 불러오기(한달단위)
	@Test
	@Ignore
	public void test2() {
		HashMap<String, String> para = new HashMap<>();
		WorkingHour wh = new WorkingHour();

		// 날짜시작일, 종료일 코드 작성
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String currentDate = sdf.format(new Date());
		LocalDate firstDate = LocalDate.now().with(TemporalAdjusters.firstDayOfMonth());
		String firstDateString = firstDate.format(DateTimeFormatter.ISO_DATE);

		wh.setUserid("dagmm");
		para.put("userid", wh.getUserid());
		para.put("whdate1", firstDateString);
		para.put("whdate2", currentDate);
		log.info(dao.monthlyWorkingHour(para));
	}

	// 수정버튼 - 해당일의 출퇴근이력 띄어주기
	/*
	 * @Test
	 * 
	 * @Ignore public void test3() { // whsrn 받아와야함. whsrn, userid
	 * System.out.println(dao.selectDate(new WorkingHour(1, "dagmm"))); }
	 */

	// 전자결재기안 - 출퇴근수정
	/*
	 * @Test
	 * 
	 * @Ignore public void test4() { // whsrn 받아와야함. dao.editwhInsertWorkFlow(new
	 * WorkingHour(9, "dagmm")); }
	 */

	// 출퇴근업데이트 - 전자결재 승인났을 때
	@Test
	@Ignore
	public void test5() {
		// go leave userid whsrn
		dao.editWorkingHour(new WorkingHour(9, "10:00", "17:59", "dagmm"));
	}

	// originworkinghour에 insert - 전자결재 승인났을 때
	@Test
	@Ignore
	public void test6() {
		Workflow workflow = new Workflow();
		workflow.setWfsrn(11);
		Map<String, String> para = new HashMap<>();
		para.put("userid", "dagmm");
		para.put("wfsrn", String.valueOf(workflow.getWfsrn()));
		log.info(dao.insertOriginWH(para));
	}

	// 개인 - 전체부여연차시간 불러오기
	@Test
	//@Ignore
	public void test7() {
		// AccountVO account = new AccountVO();
		String para = "dagmm";
		// para.put("userid", account.getUserid());
		log.info(Integer.parseInt(String.valueOf(dao.totalDayOff(para))));
	}

	// 개인 - 사용연차시간 불러오기 , 전체부여연차-사용연차
	/*
	 * @Test
	 * 
	 * @Ignore public void test8() { Map<String, String> para = new HashMap<>();
	 * para.put("userid", "dagmm"); int useDayOff =
	 * Integer.parseInt(String.valueOf(dao.useDayOff(para))); log.info(useDayOff);
	 * log.info(Integer.parseInt(String.valueOf(dao.totalDayOff(para))) -
	 * useDayOff); }
	 */

	// 그룹원 - 이름 가져오기
	/*
	 * @Test
	 * 
	 * @Ignore public void test9() { List<String> list = new ArrayList<>(); //
	 * Invitemember invitemember = new Invitemember(); // invitemember.getCno();
	 * list = dao.selectName("gaceo"); log.info(list); }
	 */

	// 그룹원 - 출퇴근시간 가져오기 - resultMap
	/*
	 * @Test
	 * 
	 * @Ignore public void test10() { List<WorkingHour> list = new ArrayList<>();
	 * list = dao.groupWorkingHour("dagmm"); log.info(list); }
	 */

	// 그룹원 - 출퇴근시간 가져오기 - resultMap

	@Test
	@Ignore
	public void test11() {
		Map<String, String> para = new HashMap<>();
		List<Dayoff> list = new ArrayList<>();
		// Invitemember
		// invitemember = new Invitemember(); // invitemember.getCno();

		// 날짜시작일, 종료일 코드 작성
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String currentDate = sdf.format(new Date());
		LocalDate firstDate = LocalDate.now().with(TemporalAdjusters.firstDayOfMonth());
		String firstDateString = firstDate.format(DateTimeFormatter.ISO_DATE);

		para.put("summer_user_userid", "gaceo");
		para.put("wfapplystartdate", firstDateString);
		para.put("wfapplyenddate", currentDate);

		list = dao.groupUseDayOff(para);
		log.info(list);
	}

	// dayoff table insert - 그룹장이 승인했을 때
	/*
	 * @Test @Ignore public void test12() { // workflowdate불러오기 - nagm id는 전자결재에서
	 * 넘겨받기 WorkflowDate workflowdate = new WorkflowDate();
	 * workflowdate.setWfapplystartdate(dao.selectWfapplyDate("nagm").
	 * getWfapplystartdate());
	 * workflowdate.setWfapplystartdate(dao.selectWfapplyDate("nagm").
	 * getWfapplyenddate()); log.info(dao.selectWfapplyDate("nagm"));
	 * 
	 * String startdate = workflowdate.getWfapplystartdate(); String enddate =
	 * workflowdate.getWfapplyenddate();
	 * 
	 * // end-start - id는 전자결재에서 넘겨받기 int datediff = dao.dateDiff("nagm");
	 * 
	 * // dayoff table insert - gaceo id는 그룹장 아이디 필요 session(그룹장 로그인했을 때)
	 * Map<String, String> para = new HashMap<>(); para.put("userid", "nagm");
	 * para.put("groupuserid", "gaceo");
	 * 
	 * if(datediff != 0) { for(int i = 0; i < datediff+1; i++) {
	 * dao.insertDayOff(para); } } else { dao.insertDayOff(para); } }
	 */
	
	// 기안문서 리스트, 전자결재명 불러오기
	/*
	 * @Test @Ignore public void test13() { List<String> list = new ArrayList<>();
	 * list = dao.workflowName(); //session log.info( dao.listWorkflow("dagmm"));
	 * log.info(list); }
	 */
	
	// 전자결재 카테고리뷰 불러오기
	/*
	 * @Test @Ignore public void test14() { log.info(dao.workflowCategoryView(1)); }
	 */
	
	// 그룹장이름 가져오기
	/*
	 * @Test @Ignore public void test15() { log.info(dao.groupLeaderName("dagmm"));
	 * }
	 */
	
	// 기안삭제
	/*
	 * @Test @Ignore public void test16() { Map<String, Object> para = new
	 * HashMap<>(); para.put("userid", "masm"); para.put("wfsrn", 9);
	 * 
	 * log.info(dao.deleteWorkflow(para)); }
	 */
	
	// 그룹원 전자결재관련정보 가져오기 -wfcsrn 따라서 전자결재명 불러주기
	@Test //@Ignore
	public void test17() {
		List<Workflow> list = new ArrayList<>();
		list = dao.groupWorkflow("gaceo");
		log.info(list);
	}
}
