package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import util.DBUtil;
import vo.Category;

public class CategoryDao {
	// SELECT admin -> 카테고리 관리 -> 카테고리 목록
	public ArrayList<Category> selectCategoryByAdmin() throws Exception{
		ArrayList<Category> categoryList = null;
		categoryList = new ArrayList<Category>();
		
		String sql = "SELECT"
				+"	 category_no categoryNo"
				+"	, category_kind categoryKind"
				+"	, category_name categoryName"
				+"	, updatedate"
				+"	, createdate"
				+" FROM category";
		
		DBUtil dbUtil = null;
		dbUtil = new DBUtil();
		
		// db자원(jdbc, api자원) 반납
		Connection conn = null;
		PreparedStatement stmt = null; 
		ResultSet rs = null; // 뷰 테이블 : SELECT의 결과물
		
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		rs = stmt.executeQuery();
		while(rs.next()) {
			Category c = new Category();
			c.setCategoryNo(rs.getInt("categoryNo")); // rs.getInt(1); 1 - 셀렉트 정의 순서
			c.setCategoryKind(rs.getString("categoryKind"));
			c.setCategoryName(rs.getString("categoryName"));
			c.setUpdatedate(rs.getString("updatedate")); // DB날짜 타입이지만 자바단에서 문자열 타입으로 받는다.
			c.setCreatedate(rs.getString("createdate"));
			categoryList.add(c);
		}
		
		dbUtil.close(rs, stmt, conn);
		return categoryList;
	}
	
	// INSERT admin -> insertCategoryAction.jsp
	public int insertCategory(Category category) throws Exception {
		int row = 0;
		
		String sql = "INSERT INTO category ("
					+ " category_kind"
					+ " , category_name"
					+ " , updatedate"
					+ " , createdate"
					+ ") VALUES(?, ?, CURDATE(), CURDATE())";
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, category.getCategoryKind());
		stmt.setString(2, category.getCategoryName());
		row = stmt.executeUpdate();
		dbUtil.close(null, stmt, conn);
		return row;
	}
	
	// 수정 : 수정폼(select)과 수정액션(update)으로 구성
	// UPDATE admin -> updateCategoryAction.jsp
	public int updateCategory(Category category) throws Exception {
		int row = 0;
		
		String sql = "UPDATE category"
					+" SET category_name = ?, category_kind = ?, updatedate = CURDATE()"
					+" WHERE category_no = ?";
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, category.getCategoryName());
		stmt.setString(2, category.getCategoryKind());
		stmt.setInt(3, category.getCategoryNo());
		row = stmt.executeUpdate();
		dbUtil.close(null, stmt, conn);
		return row;
	}
	
	// UPDATE admin -> updateCategoryForm.jsp
	public Category selectCategoryOne(int categoryNo) throws Exception {
		Category category = null;
		String sql = "SELECT category_no categoryNo, category_name categoryName"
					+" FROM category"
					+" WHERE category_no = ?";
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, categoryNo);
		rs = stmt.executeQuery();
		if(rs.next()) {
			category = new Category();
			category.setCategoryNo(rs.getInt("categoryNo"));
			category.setCategoryName(rs.getString("categoryName"));
		}
		
		dbUtil.close(rs, stmt, conn);
		return category;
	}
	
	// DELETE admin -> deleteCategory.jsp
	public int deleteCategory(int categoryNo) throws Exception {
		int row = 0;
		
		String sql = "DELETE FROM category WHERE category_no = ?";
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, categoryNo);
		row = stmt.executeUpdate();
		dbUtil.close(null, stmt, conn);
		return row;
	}
	
	// 호출 : cashDateList.jsp -> 카테고리 목록 조회
	public ArrayList<Category> selectCategoryList() throws Exception{
		ArrayList<Category> categoryList = new ArrayList<Category>();
		// ORDER BY categoryKind;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT category_no categoryNo, category_kind categoryKind, category_name categoryName FROM category ORDER BY category_kind ASC";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			Category c = new Category();
			c.setCategoryNo(rs.getInt("categoryNo"));
			c.setCategoryKind(rs.getString("categoryKind"));
			c.setCategoryName(rs.getString("categoryName"));
			categoryList.add(c);
		}
		
		dbUtil.close(rs, stmt, conn);
		return categoryList;
	}
}
