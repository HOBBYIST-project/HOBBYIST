package hobbyistClass.model.dao;

import static common.JDBCTemplate.close;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Properties;

import hobbyistClass.model.vo.ApvPageInfo;
import hobbyistClass.model.vo.HClass;
import hobbyistClass.model.vo.HClassFile;

public class HClassDAO {

	private Properties prop = null;
	
	public HClassDAO() {
		
		prop = new Properties();
		String fileName = HClassDAO.class.getResource("/sql/class-query.properties").getPath();
			
		try {
			prop.load(new FileReader(fileName));
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public int getListCount(Connection conn) {
		Statement stmt = null;
		ResultSet rset = null;
		int listCount = 0;
		
		String query = prop.getProperty("countApvList");
		
		try {
			stmt = conn.createStatement();
			rset = stmt.executeQuery(query);
			
			if(rset.next()) {
				listCount = rset.getInt("COUNT(*)");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(stmt);
		}
		
		return listCount;
	}
	
	public ArrayList<HClass> selectApvList(Connection conn, ApvPageInfo pi) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		ArrayList<HClass> apvList = null;
		
		String query = prop.getProperty("selectApvList");
		
		int startRow = (pi.getCurrentPage() -1) * pi.getListLimit() + 1;
		int endRow = startRow + pi.getListLimit() - 1;
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			rset = pstmt.executeQuery();
			
			apvList = new ArrayList<HClass>();

			while(rset.next()) {
								
				apvList.add(new HClass(rset.getDate("CLASS_ENROLL_DATE"), rset.getInt("CLASS_NO"), rset.getInt("TUTOR_NO"),
									rset.getString("CATEGORY_NAME"), rset.getString("CLASS_NAME"), rset.getString("CLASS_APV_YN"), 
									rset.getDate("CLASS_APV_DATE")));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
//		System.out.println(apvList);
		return apvList;
	}
	
	
	public int insertClass(Connection conn, HClass hclass) {
		PreparedStatement pstmt = null;
		int result = 0;
		
		String query = prop.getProperty("insertClass");
		System.out.println("insertClassquery : "+query);
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, hclass.getClassName());
			pstmt.setDate(2, hclass.getClassEndDate());
			pstmt.setDouble(3, hclass.getClassTime());
			pstmt.setInt(4, hclass.getClassTuteeMin());
			pstmt.setInt(5, hclass.getClassTuteeMax());
			pstmt.setString(6, hclass.getClassContent());
			pstmt.setInt(7, hclass.getClassFee());
			pstmt.setDate(8, hclass.getClassStartDate());
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}

		return result;
	}
	
	public int insertFile(Connection conn, ArrayList<HClassFile> fileList) {
		PreparedStatement pstmt = null;
		int result = 0; 
		
		String query = prop.getProperty("insertFile");
		
		System.out.println("insertFile query : "+query);
		try {
			pstmt = conn.prepareStatement(query);

			for (int i = 0; i < fileList.size(); i++) {
				
				pstmt.setString(1, fileList.get(i).getOriginName());
				pstmt.setString(2, fileList.get(i).getChangeName());
				pstmt.setString(3, fileList.get(i).getFilePath());
				pstmt.setString(4, fileList.get(i).getFileThumbYn());
				
				result += pstmt.executeUpdate();				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return result;
	}
	
	public ArrayList selecBList(Connection conn) {
		Statement stmt = null;
		ResultSet rset = null;
		ArrayList<HClass> list = null;
		
		String query = prop.getProperty("selectCList");
		
		try {
			stmt = conn.createStatement();
			rset = stmt.executeQuery(query);
			
			list = new ArrayList<HClass>();
			while(rset.next()) {
				HClass h = new HClass(rset.getInt("CLASS_NO"),
									  rset.getString("CLASS_NAME"),
									  rset.getDate("CLASS_ENROLL_DATE"),
									  rset.getDate("CLASS_END_DATE"),
									  rset.getDate("CLASS_APV_DATE"),
									  rset.getString("CLASS_APV_YN"),
									  rset.getString("CLASS_STATUS"),
									  rset.getDouble("CLASS_TIME"),
									  rset.getInt("CLASS_TUTEE_MIN"),
									  rset.getInt("CLASS_TUTEE_MAX"),
									  rset.getString("CLASS_CONTENT"),
									  rset.getInt("CLASS_FEE"),
									  rset.getInt("TUTOR_NO"),
									  rset.getDate("CLASS_START_DATE"),
									  rset.getString("CATEGORY_NAME"));
				list.add(h);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(stmt);
		}
		
		return list;
	}
	
	public ArrayList selectFList(Connection conn) {
		Statement stmt = null;
		ResultSet rset = null;
		ArrayList<HClassFile> list = null;
		
		String query = prop.getProperty("selectCFList");
		// selectFList=SELECT * FROM ATTACHMENT WHERE STATUS = 'Y' AND FILE_LEVEL = 0 
		// FILE_LEVEL = 0 썸네일인 것만 가져옴(list이기 때문)
		
		try {
			stmt = conn.createStatement();
			rset = stmt.executeQuery(query);
			
			list = new ArrayList<HClassFile>();
			
			while (rset.next()) {
				HClassFile f = new HClassFile();
				f.setBoardNo(rset.getInt("BOARD_NO"));
				f.setChangeName(rset.getString("CHANGE_NAME"));
				
				list.add(f);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(stmt);
		}
		
		return list;
	}

	public ArrayList<HClassFile> selectTumbnail(int bId, Connection conn) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		ArrayList<HClassFile> list = null;
		
		String query = prop.getProperty("selectFile");
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, bId);
			rset = pstmt.executeQuery();
			
			list = new ArrayList<HClassFile>();
			while (rset.next()) {

				HClassFile f = new HClassFile(); 
				f.setFileNo(rset.getInt("FILE_NO"));
				f.setOriginName(rset.getString("ORIGIN_NAME"));
				f.setChangeName(rset.getString("CHANGE_NAME"));
				f.setFilePath(rset.getString("FILE_PATH"));
				f.setUploadDate(rset.getDate("FILE_UPDATE"));
				f.setFileThumbYn(rset.getString("FILE_THUMB_YN")); // 여기서 file_level 가져오지 않아도 첫번째 사진이 썸네일이기 때문에 굳이 하지 않아도 됨
				
				list.add(f);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return list;
	}

	public int updateHClassCount(Connection conn, int bId) {
		PreparedStatement pstmt = null;
		int result = 0;

		String query = prop.getProperty("updateCount");

		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, bId);

			result = pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}

		return result;
	}

	public HClass selectHClass(Connection conn, int bId) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		HClass h = null;

		String query = prop.getProperty("selectBoard");

		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, bId);
			rset = pstmt.executeQuery();

			if(rset.next()) { 
				h = new HClass(rset.getInt("CLASS_NO"),
						  rset.getString("CLASS_NAME"),
						  rset.getDate("CLASS_ENROLL_DATE"),
						  rset.getDate("CLASS_END_DATE"),
						  rset.getDate("CLASS_APV_DATE"),
						  rset.getString("CLASS_APV_YN"),
						  rset.getString("CLASS_STATUS"),
						  rset.getDouble("CLASS_TIME"),
						  rset.getInt("CLASS_TUTEE_MIN"),
						  rset.getInt("CLASS_TUTEE_MAX"),
						  rset.getString("CLASS_CONTENT"),
						  rset.getInt("CLASS_FEE"),
						  rset.getInt("TUTOR_NO"),
						  rset.getDate("CLASS_START_DATE"),
						  rset.getString("CATEGORY_NAME"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}

		return h;
	}

//	public int confirmClass(Connection conn, HClass h) {
//		PreparedStatement pstmt1 = null;
//		PreparedStatement pstmt2 = null;
//		ResultSet rset = null;
//		int result = 0;
//		
//		String query1 = prop.getProperty("selectClass");
//		String query2 = prop.getProperty("confirmClass");
//		
//		try {
//			pstmt1 = conn.prepareStatement(query1);
//			pstmt1.setInt(1, h.getClassNo());
//			rset = pstmt1.executeQuery();
//			
//			pstmt2 = conn.prepareStatement(query2);
//			pstmt2.setInt(1, h.getClassNo());
//			result = pstmt2.executeUpdate();
//			
//			if(rset.next()) {
//				h = new HClass(rset.getInt("CLASS_NO"), rset.getString("CLASS_NAME"), rset.getDate("CLASS_ENROLL_DATE"),
//								rset.getDate("CLASS_END_DATE"), rset.getDate("CLASS_APV_DATE"), rset.getString("CLASS_APV_YN"),
//								rset.getString("CLASS_STATUS"), rset.getDouble("CLASS_TIME"), rset.getInt("CLASS_TUTEE_MIN"),
//								rset.getInt("CLASS_TUTEE_MAX"), rset.getString("CLASS_CONTENT"), rset.getInt("CLASS_FEE"),
//								rset.getInt("TUTOR_NO"), rset.getInt("CLASS_CATEGORY_NO"), rset.getDate("CLASS_START_DATE"));
//			}
//			
//		} catch (SQLException e) {
//			e.printStackTrace();
//		} finally {
//			close(rset);
//			close(pstmt1);
//			close(pstmt2);
//		}
//		
//		return result;
//	}

	public HClass selectApvList(Connection conn, int classNo) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		HClass apvList = null;
		
		String query = prop.getProperty("selectClass");
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, classNo);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				apvList = new HClass(rset.getInt("CLASS_NO"), rset.getString("CLASS_NAME"), rset.getDate("CLASS_ENROLL_DATE"),
									rset.getDate("CLASS_END_DATE"), rset.getDate("CLASS_APV_DATE"), rset.getString("CLASS_APV_YN"),
									rset.getString("CLASS_STATUS"), rset.getDouble("CLASS_TIME"), rset.getInt("CLASS_TUTEE_MIN"),
									rset.getInt("CLASS_TUTEE_MAX"), rset.getString("CLASS_CONTENT"), rset.getInt("CLASS_FEE"),
									rset.getInt("TUTOR_NO"), rset.getDate("CLASS_START_DATE"), rset.getString("CATEGORY_NAME"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return apvList;
	}

	public int confirmClass(Connection conn, HClass apvList) {
		PreparedStatement pstmt = null;
		int result = 0;
		
		String query = prop.getProperty("confirmClass");
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, apvList.getClassNo());
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return result;
	}

//	public int confirmClass(Connection conn, int classNo) {
//		PreparedStatement pstmt = null;
//		int result = 0;
//		
//		String query = prop.getProperty("confirmClass");
//
//		try {
//			pstmt = conn.prepareStatement(query);
//			pstmt.setInt(1, classNo);
//			
//			result = pstmt.executeUpdate();
//		} catch (SQLException e) {
//			e.printStackTrace();
//		} finally {
//			close(pstmt);
//		}
//		
//		return result;
//	}


	public ArrayList<HClass> selectClassList(Connection conn) {
		Statement stmt = null;
		ResultSet rset = null;
		ArrayList<HClass> list = null;
		
		String query = prop.getProperty("selectClassList");
		
		try {
			stmt = conn.createStatement();
			rset  = stmt.executeQuery(query);
			
			list = new ArrayList<HClass>();
			while(rset.next()) {
				HClass c = new HClass(rset.getInt("CLASS_NO"), 
									  rset.getString("CLASS_NAME"),
									  rset.getDate("CLASS_ENROLL_DATE"),
									  rset.getDate("CLASS_END_DATE"),
									  rset.getDate("CLASS_APV_DATE"),
									  rset.getString("CLASS_APV_YN"),
									  rset.getString("CLASS_STATUS"),
									  rset.getDouble("CLASS_TIME"),
									  rset.getInt("CLASS_TUTEE_MIN"),
									  rset.getInt("CLASS_TUTEE_MAX"),
									  rset.getString("CLASS_CONTENT"),
									  rset.getInt("CLASS_FEE"),
									  rset.getInt("TUTOR_NO"),
									  rset.getDate("CLASS_START_DATE"),
									  rset.getString("CATEGORY_NAME"));
				list.add(c);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(stmt);
		}
		
		return list;
	}

	public int updateClassStatus(Connection conn) {
		CallableStatement cstmt = null; // CallableStatement : 프로시저 호출을 위해 필요
		int result = 0;
		
		String query = prop.getProperty("updateClassStatus");
		// updateClassStatus={CALL UPDATE_ALL_CLASS}
		
		try {
			cstmt = conn.prepareCall(query);
			result = cstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				cstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return result;
	}

	public ArrayList<HClassFile> selectFileList(Connection conn) {
		Statement stmt = null;
		ResultSet rset = null;
		ArrayList<HClassFile> list = null;
		
		String query = prop.getProperty("selectFileList");

		try {
			stmt = conn.createStatement();
			rset = stmt.executeQuery(query);
			
			list = new ArrayList<HClassFile>();
			while(rset.next()) {
				HClassFile f = new HClassFile();
				f.setFileNo(rset.getInt("FILE_NO"));
				f.setChangeName(rset.getString("CHANGE_NAME"));
				f.setBoardNo(rset.getInt("BOARD_NO"));
				list.add(f);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(stmt);
		}
		
		return list;
	}

	public HClass selectClass(Connection conn, int cNo) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		HClass c = null;
		
		String query = prop.getProperty("selectClassDetail");
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, cNo);
			rset = pstmt.executeQuery();
			
			if (rset.next()) {
				c = new HClass(rset.getInt("CLASS_NO"), 
						  rset.getString("CLASS_NAME"),
						  rset.getDate("CLASS_ENROLL_DATE"),
						  rset.getDate("CLASS_END_DATE"),
						  rset.getDate("CLASS_APV_DATE"),
						  rset.getString("CLASS_APV_YN"),
						  rset.getString("CLASS_STATUS"),
						  rset.getDouble("CLASS_TIME"),
						  rset.getInt("CLASS_TUTEE_MIN"),
						  rset.getInt("CLASS_TUTEE_MAX"),
						  rset.getString("CLASS_CONTENT"),
						  rset.getInt("CLASS_FEE"),
						  rset.getInt("TUTOR_NO"),
						  rset.getDate("CLASS_START_DATE"),
						  rset.getString("CATEGORY_NAME"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return c;
	}

	public ArrayList<HClassFile> selectDetailFileList(Connection conn, int cNo) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		ArrayList<HClassFile> list = null;
		
		String query = prop.getProperty("selectDetailFileList");

		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, cNo);
			rset = pstmt.executeQuery();
			
			list = new ArrayList<HClassFile>();
			while(rset.next()) {
				HClassFile f = new HClassFile();
				f.setFileNo(rset.getInt("FILE_NO"));
				f.setOriginName(rset.getString("ORIGIN_NAME"));
				f.setChangeName(rset.getString("CHANGE_NAME"));
				f.setFilePath(rset.getString("FILE_PATH"));
				f.setUploadDate(rset.getDate("FILE_UPLOAD"));
				f.setFileThumbYn(rset.getString("FILE_THUMB_YN"));
				list.add(f);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return list;
	}

}
