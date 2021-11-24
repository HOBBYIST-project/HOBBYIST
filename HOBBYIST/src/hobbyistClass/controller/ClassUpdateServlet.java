package hobbyistClass.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import hobbyistClass.model.service.HClassService;
import hobbyistClass.model.vo.HClass;

/**
 * Servlet implementation class BoardUpdateServlet
 */
@WebServlet("/update.tc")
public class ClassUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ClassUpdateServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		request.setCharacterEncoding("utf-8");
		int bId = Integer.parseInt(request.getParameter("bid"));
		int cateId = Integer.parseInt(request.getParameter("category")); // String으로 저장해서 Board객체에 정보들 저장해서 넘긴 후 DAO에서 parseInt해도 됨
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		
		int result = new HClassService().updateHClass(bId, cateId, title, content);
		if (result > 0) {
		
			response.sendRedirect("classOpenDetail.tt?bId=" + bId); 
		} else {
			request.setAttribute("msg", "게시글 수정 실패");
			request.getRequestDispatcher("WEB-INF/views/common/errorPage.jsp").forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}