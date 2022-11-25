package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import util.DBUtil;
import vo.Notice;

public class NoticeDao {
	// SELECT : updateNoticeForm.jsp 공지 정보 조회
	public Notice selectNotice(Notice notice)throws Exception{
		Notice n = null;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT notice_no noticeNo, notice_memo noticeMemo, updatedate, createdate"
					+ " FROM notice"
					+ " WHERE notice_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, notice.getNoticeNo());
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			n = new Notice();
			n.setNoticeNo(rs.getInt("noticeNo"));
			n.setNoticeMemo(rs.getString("noticeMemo"));
			n.setUpdatedate(rs.getString("updatedate"));
			n.setCreatedate(rs.getString("createdate"));
		}
		
		dbUtil.close(rs, stmt, conn);
		return n;
	}
	
	// DELETE : noticeList.jsp
	public int deleteNotice(Notice notice) throws Exception{
		int row = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = null;
		PreparedStatement stmt = null;
		sql = "DELETE FROM notice WHERE notice_no = ?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, notice.getNoticeNo());
		row = stmt.executeUpdate();
		dbUtil.close(null, stmt, conn);
		return row;
	}
	
	// UPDATE : noticeList.jsp
	public int updateNotice(Notice notice) throws Exception{
		int row = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = null;
		PreparedStatement stmt = null;
		sql = "UPDATE notice SET notice_memo = ? WHERE notice_no= ? ";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, notice.getNoticeMemo());
		stmt.setInt(2, notice.getNoticeNo());
		row = stmt.executeUpdate();
		dbUtil.close(null, stmt, conn);
		return row;
	}
	
	// INSERT : noticeList.jsp
	public int insertNotice(Notice notice) throws Exception{
		int row = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = null;
		PreparedStatement stmt = null;
		sql = "INSERT notice(notice_memo, updatedate, createdate) VALUES(?, NOW(), NOW())";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, notice.getNoticeMemo());
		row = stmt.executeUpdate();
		dbUtil.close(null, stmt, conn);
		return row;
	}
	
	// 마지막 페이지를 구할려면 전체
	public int selectNoticeCount() throws Exception {
		int count = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = null;
		PreparedStatement stmt = null;
		sql = "SELECT COUNT(*) count FROM notice";
		stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			count = rs.getInt("count");
		}
		
		dbUtil.close(rs, stmt, conn);
		return count;
	}
	
	// loginForm.jsp 공지목록
	public ArrayList<Notice> selectNoticeListByPage(int beginRow, int rowPerPage)throws Exception{
		ArrayList<Notice> list = new ArrayList<Notice>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT notice_no noticeNo, notice_memo noticeMemo, createdate"
					+ " FROM notice ORDER BY createdate DESC"
					+ " LIMIT ?,?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			Notice n = new Notice();
			n.setNoticeNo(rs.getInt("noticeNo"));
			n.setNoticeMemo(rs.getString("noticeMemo"));
			n.setCreatedate(rs.getString("createdate"));
			list.add(n);
		}
		
		dbUtil.close(rs, stmt, conn);
		return list;
	}
}
