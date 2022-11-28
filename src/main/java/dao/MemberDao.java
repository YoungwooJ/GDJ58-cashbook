package dao;

import java.sql.*;
import java.util.ArrayList;

import util.DBUtil;
import vo.Member;
import vo.Notice;

public class MemberDao {
	// 관리자 : 멤베레벨수정
	public int updateMemberLevel(Member member, int memberLevel) throws Exception{
		int row = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = null;
		PreparedStatement stmt = null;
		sql = "UPDATE member SET member_level = ?, updatedate = CURDATE() WHERE member_no = ?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, memberLevel);
		stmt.setInt(2, member.getMemberNo());
		row = stmt.executeUpdate();
		
		dbUtil.close(null, stmt, conn);
		return row;
	}
	
	// 관리자 : 멤버수
	public int selectMemberCount() throws Exception{
		int count = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = null;
		PreparedStatement stmt = null;
		sql = "SELECT COUNT(*) count FROM member";
		stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			count = rs.getInt("count");
		}
		
		dbUtil.close(rs, stmt, conn);
		return count;
	}
	
	// 관리자 멤버 리스트
	public ArrayList<Member> selectMemberListByPage(int beginRow, int rowPerPage) throws Exception{
		ArrayList<Member> list = new ArrayList<Member>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT member_no memberNo, member_id memberId, member_level memberLevel, member_name memberName, updatedate, createdate"
					+ " FROM member ORDER BY createdate DESC"
					+ " LIMIT ?,?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			Member m = new Member();
			m.setMemberNo(rs.getInt("memberNo"));
			m.setMemberId(rs.getString("memberId"));
			m.setMemberLevel(rs.getInt("memberLevel"));
			m.setMemberName(rs.getString("memberName"));
			m.setUpdatedate(rs.getString("Updatedate"));
			m.setCreatedate(rs.getString("Createdate"));
			list.add(m);
		}
		
		dbUtil.close(rs, stmt, conn);
		return list;
	}
	
	// 관리자 멤버 강퇴
	public int deleteMemberByAdmin(Member member) throws Exception {
		int row = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = null;
		PreparedStatement stmt = null;
		sql = "DELETE FROM member WHERE member_no = ?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, member.getMemberNo());
		row = stmt.executeUpdate();
		dbUtil.close(null, stmt, conn);
		return row;
	}
	
	// INSERT 회원가입 1) id 중복확인
	// 반환값 t : 이미 존재 , first 사용가능
	public boolean selectMemberIdck(String memberId) throws Exception {
		boolean result = false;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT member_id FROM member WHERE member_id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()){
			result = true;
		}
		
		dbUtil.close(rs, stmt, conn);
		return result;
	}

	// INSERT 회원가입 2) 회원가입 
	public int insertMember(Member member) throws Exception{
		int row = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "INSERT INTO member (member_id, member_pw, member_name, updatedate, createdate) VALUES (?, PASSWORD(?), ?, CURDATE(), CURDATE())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, member.getMemberId());
		stmt.setString(2, member.getMemberPw());
		stmt.setString(3, member.getMemberName());
		row = stmt.executeUpdate();
		dbUtil.close(null, stmt, conn);
		return row;
	}
	
	// SELECT 로그인
	public Member login(Member paramMember) throws Exception {
		Member resultMember = null;
		/*
		// db 알고리즘
		String driver	= "org.mariadb.jdbc.Driver";
		String dbUrl	= "jdbc:mariadb://localhost:3306/cashbook";
		String dbUser	= "root";
		String dbPw		= "java1234";
		Class.forName(driver); // 외부 드라이브 로딩
		Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPw); // db 연결
		--> DB를 연결하는 코드(명령들)가 Dao 메서드를 거의 공통으로 중복된다.
		--> 중복되는 코드를 하나의 이름(메서드)으로 만들자
		--> 입력값과 반환값 결정해야 한다
		--> 입력값X, 반환값은 Connection타입의 결과값이 남아야 한다.
		*/
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT member_id memberId, member_level memberLevel, member_name memberName FROM member where member_id=? AND member_pw=PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramMember.getMemberId());
		stmt.setString(2, paramMember.getMemberPw());
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			// 로그인 성공
			System.out.println("success");
			resultMember = new Member(); 
			resultMember.setMemberId(rs.getString("memberId"));
			resultMember.setMemberLevel(rs.getInt("memberLevel"));
			resultMember.setMemberName(rs.getString("memberName"));
		}	
		
		dbUtil.close(rs, stmt, conn);
		return resultMember;
	}
	
	// UPDATE 1) 회원 닉네임 수정
	public int updateMemberName(Member member, String newMemberName) throws Exception{
		int row = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = null;
		PreparedStatement stmt = null;
		sql = "UPDATE member SET member_name = ? WHERE member_id = ? AND member_pw = PASSWORD(?)";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, newMemberName);
		stmt.setString(2, member.getMemberId());
		stmt.setString(3, member.getMemberPw());
		row = stmt.executeUpdate();
		dbUtil.close(null, stmt, conn);
		return row;
	}
	
	// UPDATE 2) 회원 비밀번호 수정
	public int updateMemberPw(Member member, String newMemberPw) throws Exception{
		int row = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = null;
		PreparedStatement stmt = null;
		sql = "UPDATE member SET member_pw = PASSWORD(?) WHERE member_id = ? AND member_pw = PASSWORD(?)";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, newMemberPw);
		stmt.setString(2, member.getMemberId());
		stmt.setString(3, member.getMemberPw());
		row = stmt.executeUpdate();
		dbUtil.close(null, stmt, conn);
		return row;
	}
	
	// DELETE 회원 탈퇴
	public int deleteMember(Member member) throws Exception{
		int row = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = null;
		PreparedStatement stmt = null;
		sql = "DELETE FROM member WHERE member_id=? AND member_pw=PASSWORD(?)";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, member.getMemberId());
		stmt.setString(2, member.getMemberPw());
		row = stmt.executeUpdate();
		dbUtil.close(null, stmt, conn);
		return row;
	}
	
	// 회원 정보 조회
	public Member selectMember(Member paramMember) throws Exception {
		Member resultMember = null;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = null;
		PreparedStatement stmt = null;
		sql = "SELECT member_no memberNo, member_id memberId, member_name memberName, updatedate, createdate, member_level memberLevel FROM member WHERE member_no = ?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, paramMember.getMemberNo());
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			System.out.println("success");
			resultMember = new Member(); 
			resultMember.setMemberNo(rs.getInt("memberNo"));
			resultMember.setMemberId(rs.getString("memberId"));
			resultMember.setMemberName(rs.getString("memberName"));
			resultMember.setUpdatedate(rs.getString("updatedate"));
			resultMember.setCreatedate(rs.getString("createdate"));
			resultMember.setMemberLevel(rs.getInt("memberLevel"));
		}	
		
		dbUtil.close(rs, stmt, conn);
		return resultMember;
	}
	
	// 회원 정보 조회
	public Member selectMemberInfo(Member paramMember) throws Exception {
		Member resultMember = null;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = null;
		PreparedStatement stmt = null;
		sql = "SELECT member_id memberId, member_pw memberPw, member_level memberLevel, member_name memberName FROM member WHERE member_id = ?";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramMember.getMemberId());
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			System.out.println("success");
			resultMember = new Member(); 
			resultMember.setMemberId(rs.getString("memberId"));
			resultMember.setMemberPw(rs.getString("memberPw"));
			resultMember.setMemberLevel(rs.getInt("memberLevel"));
			resultMember.setMemberName(rs.getString("memberName"));
		}	
		
		dbUtil.close(rs, stmt, conn);
		return resultMember;
	}
	
	// 비밀번호 확인
	public boolean memberPwck(Member member) throws Exception {
		boolean result = false;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT member_name memberName FROM member WHERE member_id=? AND member_pw=PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, member.getMemberId());
		stmt.setString(2, member.getMemberPw());
		ResultSet rs = stmt.executeQuery();
		if(rs.next()){
			result = true;
		}
		
		dbUtil.close(rs, stmt, conn);
		return result;
	}

}