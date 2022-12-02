package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import util.DBUtil;
import vo.Category;

public class CategoryDao {
	// SELECT admin -> 카테고리 관리 -> 카테고리 목록
	public ArrayList<Category> selectCategoryByAdmin(){
		ArrayList<Category> categoryList = null;
		// db자원(jdbc, api자원) 반납
		DBUtil dbUtil = null;
		String sql = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null; // 뷰 테이블 : SELECT의 결과물
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			sql = "SELECT"
					+"	 category_no categoryNo"
					+"	, category_kind categoryKind"
					+"	, category_name categoryName"
					+"	, updatedate"
					+"	, createdate"
					+" FROM category";
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			
			categoryList = new ArrayList<Category>();
			while(rs.next()) {
				Category c = new Category();
				c.setCategoryNo(rs.getInt("categoryNo")); // rs.getInt(1); 1 - 셀렉트 정의 순서
				c.setCategoryKind(rs.getString("categoryKind"));
				c.setCategoryName(rs.getString("categoryName"));
				c.setUpdatedate(rs.getString("updatedate")); // DB날짜 타입이지만 자바단에서 문자열 타입으로 받는다.
				c.setCreatedate(rs.getString("createdate"));
				categoryList.add(c);
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
		return categoryList;
	}
	
	// INSERT admin -> insertCategoryAction.jsp
	public int insertCategory(Category category){
		int row = 0;
		DBUtil dbUtil = null;
		String sql = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			sql = "INSERT INTO category ("
					+ " category_kind"
					+ " , category_name"
					+ " , updatedate"
					+ " , createdate"
					+ ") VALUES(?, ?, CURDATE(), CURDATE())";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, category.getCategoryKind());
			stmt.setString(2, category.getCategoryName());
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
	
	// 수정 : 수정폼(select)과 수정액션(update)으로 구성
	// UPDATE admin -> updateCategoryAction.jsp
	public int updateCategory(Category category){
		int row = 0;
		DBUtil dbUtil = null;
		String sql = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			sql = "UPDATE category"
					+" SET category_name = ?, category_kind = ?, updatedate = CURDATE()"
					+" WHERE category_no = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, category.getCategoryName());
			stmt.setString(2, category.getCategoryKind());
			stmt.setInt(3, category.getCategoryNo());
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
	
	// UPDATE admin -> updateCategoryForm.jsp
	public Category selectCategoryOne(int categoryNo){
		Category category = null;
		DBUtil dbUtil = null;
		String sql = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			sql = "SELECT category_no categoryNo, category_kind categoryKind, category_name categoryName"
					+" FROM category"
					+" WHERE category_no = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, categoryNo);
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				category = new Category();
				category.setCategoryNo(rs.getInt("categoryNo"));
				category.setCategoryKind(rs.getString("categoryKind"));
				category.setCategoryName(rs.getString("categoryName"));
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
		return category;
	}
	
	// DELETE admin -> deleteCategory.jsp
	public int deleteCategory(int categoryNo){
		int row = 0;
		DBUtil dbUtil = null;
		String sql = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		try {
			dbUtil = new DBUtil();
			sql = "DELETE FROM category WHERE category_no = ?";
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, categoryNo);
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
	
	// 호출 : cashDateList.jsp -> 카테고리 목록 조회
	public ArrayList<Category> selectCategoryList(){
		ArrayList<Category> categoryList = null;
		DBUtil dbUtil = null;
		String sql = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			// ORDER BY categoryKind;
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			sql = "SELECT category_no categoryNo, category_kind categoryKind, category_name categoryName FROM category ORDER BY category_kind ASC";
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			
			categoryList = new ArrayList<Category>();
			while(rs.next()) {
				Category c = new Category();
				c.setCategoryNo(rs.getInt("categoryNo"));
				c.setCategoryKind(rs.getString("categoryKind"));
				c.setCategoryName(rs.getString("categoryName"));
				categoryList.add(c);
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
		return categoryList;
	}
}