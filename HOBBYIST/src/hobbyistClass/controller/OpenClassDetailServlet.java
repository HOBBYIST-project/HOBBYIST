package hobbyistClass.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import hobbyistClass.model.service.HClassService;
import hobbyistClass.model.vo.HClassFiles;
import hobbyistClass.model.vo.HClass;



/**
 * Servlet implementation class TumbnailDetailServlet
 */
@WebServlet("/classopendetail.me")
public class OpenClassDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public OpenClassDetailServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int bId = Integer.parseInt(request.getParameter("bId"));
		int classNo = Integer.parseInt(request.getParameter("classNo")); //클래스 승인 리스트에서 클래스번호 넘겨서 해당 클래스 신청건에 대한 상세내역 확인하고자함.
		
		HClassService service = new HClassService();
		
		HClass hClass = service.selectBoard(bId, null);
		
		ArrayList<HClassFiles> fileList = service.selectThumnail(bId); // 해당 게시글에 관한 사진들 가져옴
		String page = null;
		if(fileList != null) {
//			request.setAttribute("HClass", hClass);
			request.setAttribute("fileList", fileList);
			page = "WEB-INF/views/thumbnail/thumbnailDetail.jsp";
		} else {
			request.setAttribute("msg", "클래스 신청 수정실패");
			page = "WEB-INF/views/common/errorPage.jsp";
		}
		request.getRequestDispatcher(page).forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}