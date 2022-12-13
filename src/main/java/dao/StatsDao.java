package dao;

import java.sql.*;
import java.util.*;

import util.*;

public class StatsDao {
	public HashMap<String, Object> selectMaxMinYear(String memberId) {
		HashMap<String, Object> map = null;
		DBUtil dbUtil = null;
		String sql = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			sql = "SELECT"
					+ "	 MIN(YEAR(cash_date)) minYear\r\n"
					+ ", MAX(YEAR(cash_date)) maxYear\r\n"
					+ "FROM cash\r\n"
					+ "WHERE member_id = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			rs = stmt.executeQuery();
			if(rs.next()) {
				map = new HashMap<String, Object>();
				map.put("minYear", rs.getInt("minYear"));
				map.put("maxYear", rs.getInt("maxYear"));
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
		return map;
	}
	
	public ArrayList<HashMap<String, Object>> selectCashStatsByDay(String memberId, int year, int month) {
		ArrayList<HashMap<String, Object>> list = null;
		DBUtil dbUtil = null;
		String sql = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			sql = "SELECT \r\n"
					+ "		DAY(t2.cashDate) day\r\n"
					+ "		, COUNT(t2.importCash) incomeCnt\r\n"
					+ "		, IFNULL(SUM(t2.importCash), 0) incomeSum\r\n"
					+ "		, IFNULL(ROUND(AVG(t2.importCash)), 0) incomeAvg\r\n"
					+ "		, COUNT(t2.exportCash) expenseCnt\r\n"
					+ "		, IFNULL(SUM(t2.exportCash), 0) expenseSum\r\n"
					+ "		, IFNULL(ROUND(AVG(t2.exportCash)), 0) expenseAvg\r\n"
					+ "FROM\r\n"
					+ "	(SELECT \r\n"
					+ "			memberId\r\n"
					+ "			, cashNo\r\n"
					+ "			, cashDate\r\n"
					+ "			, IF(categoryKind = '수입', cashPrice, null) importCash\r\n"
					+ "			, IF(categoryKind = '지출', cashPrice, null) exportCash\r\n"
					+ "	FROM (SELECT cs.cash_no cashNo\r\n"
					+ "					, cs.cash_date cashDate\r\n"
					+ "					, cs.cash_price cashPrice\r\n"
					+ "					, cg.category_kind categoryKind\r\n"
					+ "					, cs.member_id memberId\r\n"
					+ "			FROM cash cs \r\n"
					+ "			INNER JOIN category cg ON cs.category_no = cg.category_no) t) t2\r\n"
					+ "WHERE t2.memberId = ? AND YEAR(t2.cashDate) = ? AND MONTH(t2.cashDate) = ?\r\n"
					+ "GROUP BY DAY(t2.cashDate)\r\n"
					+ "ORDER BY DAY(t2.cashDate) ASC;";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			stmt.setInt(2, year);
			stmt.setInt(3, month);
			rs = stmt.executeQuery();
			
			list = new ArrayList<HashMap<String, Object>>();
			while(rs.next()) {
				HashMap<String, Object> m = new HashMap<String, Object>();
				m.put("day", rs.getInt("day"));
				m.put("incomeCnt", rs.getInt("incomeCnt"));
				m.put("incomeSum", rs.getInt("incomeSum"));
				m.put("incomeAvg", rs.getInt("incomeAvg"));
				m.put("expenseCnt", rs.getInt("expenseCnt"));
				m.put("expenseSum", rs.getInt("expenseSum"));
				m.put("expenseAvg", rs.getInt("expenseAvg"));
				list.add(m);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(rs, stmt, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return list;
	}

	public ArrayList<HashMap<String, Object>> selectCashStatsByMonth(String memberId, int year) {
		ArrayList<HashMap<String, Object>> list = null;
		DBUtil dbUtil = null;
		String sql = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			sql = "SELECT \r\n"
					+ "		MONTH(t2.cashDate) month\r\n"
					+ "		, COUNT(t2.importCash) incomeCnt\r\n"
					+ "		, IFNULL(SUM(t2.importCash), 0) incomeSum\r\n"
					+ "		, IFNULL(ROUND(AVG(t2.importCash)), 0) incomeAvg\r\n"
					+ "		, COUNT(t2.exportCash) expenseCnt\r\n"
					+ "		, IFNULL(SUM(t2.exportCash), 0) expenseSum\r\n"
					+ "		, IFNULL(ROUND(AVG(t2.exportCash)), 0) expenseAvg\r\n"
					+ "FROM\r\n"
					+ "	(SELECT \r\n"
					+ "			memberId\r\n"
					+ "			, cashNo\r\n"
					+ "			, cashDate\r\n"
					+ "			, IF(categoryKind = '수입', cashPrice, null) importCash\r\n"
					+ "			, IF(categoryKind = '지출', cashPrice, null) exportCash\r\n"
					+ "	FROM (SELECT cs.cash_no cashNo\r\n"
					+ "					, cs.cash_date cashDate\r\n"
					+ "					, cs.cash_price cashPrice\r\n"
					+ "					, cg.category_kind categoryKind\r\n"
					+ "					, cs.member_id memberId\r\n"
					+ "			FROM cash cs \r\n"
					+ "			INNER JOIN category cg ON cs.category_no = cg.category_no) t) t2\r\n"
					+ "WHERE t2.memberId = ? AND YEAR(t2.cashDate) = ?\r\n"
					+ "GROUP BY MONTH(t2.cashDate)\r\n"
					+ "ORDER BY MONTH(t2.cashDate) ASC";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			stmt.setInt(2, year);
			rs = stmt.executeQuery();
			
			list = new ArrayList<HashMap<String, Object>>();
			while(rs.next()) {
				HashMap<String, Object> m = new HashMap<String, Object>();
				m.put("month", rs.getInt("month"));
				m.put("incomeCnt", rs.getInt("incomeCnt"));
				m.put("incomeSum", rs.getInt("incomeSum"));
				m.put("incomeAvg", rs.getInt("incomeAvg"));
				m.put("expenseCnt", rs.getInt("expenseCnt"));
				m.put("expenseSum", rs.getInt("expenseSum"));
				m.put("expenseAvg", rs.getInt("expenseAvg"));
				list.add(m);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(rs, stmt, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return list;
	}
	
	public ArrayList<HashMap<String, Object>> selectCashStatsByYear(String memberId) {
		ArrayList<HashMap<String, Object>> list = null;
		DBUtil dbUtil = null;
		String sql = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			sql = "SELECT \r\n"
					+ "		YEAR(t2.cashDate) year\r\n"
					+ "		, COUNT(t2.importCash) incomeCnt\r\n"
					+ "		, IFNULL(SUM(t2.importCash), 0) incomeSum\r\n"
					+ "		, IFNULL(ROUND(AVG(t2.importCash)), 0) incomeAvg\r\n"
					+ "		, COUNT(t2.exportCash) expenseCnt\r\n"
					+ "		, IFNULL(SUM(t2.exportCash), 0) expenseSum\r\n"
					+ "		, IFNULL(ROUND(AVG(t2.exportCash)), 0) expenseAvg\r\n"
					+ "FROM\r\n"
					+ "	(SELECT \r\n"
					+ "			memberId\r\n"
					+ "			, cashNo\r\n"
					+ "			, cashDate\r\n"
					+ "			, IF(categoryKind = '수입', cashPrice, null) importCash\r\n"
					+ "			, IF(categoryKind = '지출', cashPrice, null) exportCash\r\n"
					+ "	FROM (SELECT cs.cash_no cashNo\r\n"
					+ "					, cs.cash_date cashDate\r\n"
					+ "					, cs.cash_price cashPrice\r\n"
					+ "					, cg.category_kind categoryKind\r\n"
					+ "					, cs.member_id memberId\r\n"
					+ "			FROM cash cs \r\n"
					+ "			INNER JOIN category cg ON cs.category_no = cg.category_no) t) t2\r\n"
					+ "WHERE t2.memberId = ?\r\n"
					+ "GROUP BY YEAR(t2.cashDate)\r\n"
					+ "ORDER BY YEAR(t2.cashDate) ASC";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			rs = stmt.executeQuery();
			
			list = new ArrayList<HashMap<String, Object>>();
			while(rs.next()) {
				HashMap<String, Object> m = new HashMap<String, Object>();
				m.put("year", rs.getInt("year"));
				m.put("incomeCnt", rs.getInt("incomeCnt"));
				m.put("incomeSum", rs.getInt("incomeSum"));
				m.put("incomeAvg", rs.getInt("incomeAvg"));
				m.put("expenseCnt", rs.getInt("expenseCnt"));
				m.put("expenseSum", rs.getInt("expenseSum"));
				m.put("expenseAvg", rs.getInt("expenseAvg"));
				list.add(m);
			}
		} catch(Exception e) {		
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(rs, stmt, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return list;
	}
}
