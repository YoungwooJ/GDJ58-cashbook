package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import util.DBUtil;
import vo.Help;

public class HelpDao {
	// SELECT : updateHelpForm.jsp
	public Help selectHelp(Help help){
		Help h = null;
		DBUtil dbUtil = null;
		String sql = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			sql = "SELECT help_no helpNo, help_memo helpMemo, member_id memberId, updatedate, createdate"
				+ " FROM help"
				+ " WHERE help_no=?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, help.getHelpNo());
			rs = stmt.executeQuery();
			
			while(rs.next()) {
				h = new Help();
				h.setHelpNo(rs.getInt("helpNo"));
				h.setHelpMemo(rs.getString("helpMemo"));
				h.setMemberId(rs.getString("memberId"));
				h.setUpdatedate(rs.getString("updatedate"));
				h.setCreatedate(rs.getString("createdate"));
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(rs, stmt, conn);
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return h;
	}
	
	// SELECT : 관리자 
	// selectHelpList 오버로딩
	public ArrayList<HashMap<String, Object>> selectHelpList(int beginRow, int rowPerPage){
		ArrayList<HashMap<String, Object>> list = null;
		DBUtil dbUtil = null;
		String sql = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			// SQL 쿼리 적을 때 : FROM -> WHERE -> SELECT -> ORDER BY
			sql = "SELECT h.help_no helpNo"
					+ "			, h.help_memo helpMemo"
					+ "			, h.member_id helpMemberId"
					+ "			, h.updatedate helpUpdatedate"
					+ "			, h.createdate helpCreatedate"
					+ "			, c.comment_no commentNo"
					+ "			, c.comment_memo commentMemo"
					+ "			, c.member_id commentMemberId"
					+ "			, c.updatedate commentUpdatedate"
					+ "			, c.createdate commentCreatedate"
					+ " FROM help h LEFT JOIN comment c"
					+ " ON h.help_no = c.help_no"
					+ " LIMIT ?, ?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			rs = stmt.executeQuery();
			
			list = new ArrayList<HashMap<String, Object>>();
			while(rs.next()) {
				HashMap<String, Object> m = new HashMap<String, Object>();
				m.put("helpNo", rs.getInt("helpNo"));
				m.put("helpMemo", rs.getString("helpMemo"));
				m.put("helpMemberId", rs.getString("helpMemberId"));
				m.put("helpUpdatedate", rs.getString("helpUpdatedate"));
				m.put("helpCreatedate", rs.getString("helpCreatedate"));
				m.put("commentNo", rs.getInt("commentNo"));
				m.put("commentMemo", rs.getString("commentMemo"));
				m.put("commentMemberId", rs.getString("commentMemberId"));
				m.put("commentUpdatedate", rs.getString("commentUpdatedate"));
				m.put("commentCreatedate", rs.getString("commentCreatedate"));
				list.add(m);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(rs, stmt, conn);
			} catch(Exception e){
				e.printStackTrace();
			}
		}
		return list;
	}
	
	// SELECT : helpList.jsp
	public ArrayList<HashMap<String, Object>> selectHelpList(String memberId){
		ArrayList<HashMap<String, Object>> list = null;
		DBUtil dbUtil = null;
		String sql = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			// SQL 쿼리 적을 때 : FROM -> WHERE -> SELECT -> ORDER BY
			sql = "SELECT h.help_no helpNo"
				+ "			, h.help_memo helpMemo"
				+ "			, h.member_id helpMemberId"
				+ "			, h.updatedate helpUpdatedate"
				+ "			, h.createdate helpCreatedate"
				+ "			, c.comment_no commentNo"
				+ "			, c.comment_memo commentMemo"
				+ "			, c.member_id commentMemberId"
				+ "			, c.updatedate commentUpdatedate"
				+ "			, c.createdate commentCreatedate"
				+ " FROM help h LEFT JOIN comment c"
				+ " ON h.help_no = c.help_no"
				+ " WHERE h.member_id = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			rs = stmt.executeQuery();
			
			list = new ArrayList<HashMap<String, Object>>();
			while(rs.next()) {
				HashMap<String, Object> m = new HashMap<String, Object>();
				m.put("helpNo", rs.getInt("helpNo"));
				m.put("helpMemo", rs.getString("helpMemo"));
				m.put("helpMemberId", rs.getString("helpMemberId"));
				m.put("helpUpdatedate", rs.getString("helpUpdatedate"));
				m.put("helpCreatedate", rs.getString("helpCreatedate"));
				m.put("commentNo", rs.getInt("commentNo"));
				m.put("commentMemo", rs.getString("commentMemo"));
				m.put("commentMemberId", rs.getString("commentMemberId"));
				m.put("commentUpdatedate", rs.getString("commentUpdatedate"));
				m.put("commentCreatedate", rs.getString("commentCreatedate"));
				list.add(m);
			}
		} catch(Exception e){
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(rs, stmt, conn);
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return list;
	}
	
	// INSERT : insertHelpAction.jsp
	public int insertHelp(Help help){
		int row = 0;
		DBUtil dbUtil = null;
		String sql = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			sql = "INSERT into help(help_memo, member_id, updatedate, createdate)"
					+ " VALUES(?, ?, NOW(), NOW())";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, help.getHelpMemo());
			stmt.setString(2, help.getMemberId());
			row = stmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(null, stmt, conn);
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return row;
	}
	
	// UPDATE : updateHelpAction.jsp
	public int updateHelp(Help help){
		int row = 0;
		DBUtil dbUtil = null;
		String sql = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			sql = "UPDATE help SET help_memo = ? WHERE help_no= ? ";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, help.getHelpMemo());
			stmt.setInt(2, help.getHelpNo());
			row = stmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(null, stmt, conn);
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return row;
	}
	
	// DELETE : deleteHelpAction.jsp
	public int deleteHelp(Help help){
		int row = 0;
		DBUtil dbUtil = null;
		String sql = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			sql = "DELETE FROM help WHERE help_no = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, help.getHelpNo());
			row = stmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(null, stmt, conn);
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return row;
	}
}
