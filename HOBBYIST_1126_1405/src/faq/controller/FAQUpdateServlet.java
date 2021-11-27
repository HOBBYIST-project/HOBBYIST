package faq.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import faq.model.service.FAQService;
import faq.model.vo.FAQ;

/**
 * Servlet implementation class FAQUpdateServlet
 */
@WebServlet("/FAQUpdate.bo")
public class FAQUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FAQUpdateServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		int no = Integer.parseInt(request.getParameter("no"));
		String faqTitle = request.getParameter("title");
		String faqReply = request.getParameter("reply");
		String faqCategory = request.getParameter("category");
		
		FAQ faq = new FAQ(no, faqTitle, faqReply, faqCategory);
		
		int result = new FAQService().updateFAQ(faq);
		
		if(result > 0) {
			request.setAttribute("faq", faq);
			request.getRequestDispatcher("WEB-INF/views/faq/faqDetail.jsp").forward(request, response);
		} else {
			request.setAttribute("msg", "FAQ 수정 실패");
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