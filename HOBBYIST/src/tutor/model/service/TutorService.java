package tutor.model.service;

import static common.JDBCTemplate.close;
import static common.JDBCTemplate.commit;
import static common.JDBCTemplate.rollback;
import static common.JDBCTemplate.getConnection;

import java.sql.Connection;
import java.util.ArrayList;

import member.model.vo.Member;
import tutor.model.dao.TutorDAO;
import tutor.model.vo.Files;
import tutor.model.vo.Tutor;

public class TutorService {
	
	private TutorDAO tDAO = new TutorDAO();
	
	public int insertTutor(Tutor tutor, String memberEmail) {
		Connection conn = getConnection();
		
		int result = tDAO.insertTutor(conn, tutor, memberEmail);
		
		if(result>0) {
			commit(conn);
		} else {
			rollback(conn);
		}
		
		close(conn);
		
		return result;
	}

	public int insertProfile(ArrayList<Files> fileList) {
		Connection conn = getConnection();
		
		int result = tDAO.insertFiles(conn, fileList);
		
		if(result>0) {
			commit(conn);
		} else {
			rollback(conn);
		}
		close(conn);
		return result;
	}

	public Tutor selectTutor(String memberEmail) {
		
		
		return null;
	}

}
