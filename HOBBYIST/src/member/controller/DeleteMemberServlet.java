package member.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import member.model.service.MemberService;
import member.model.vo.Member;

/**
 * Servlet implementation class DeleteMemberServlet
 */
@WebServlet("/deleteMember.me")
public class DeleteMemberServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteMemberServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        HttpSession session = request.getSession(true); //로그인 된 상태에서 탈퇴하는 거니까 세션에서 정보 받아옴
//        String memberEmail = ((Member)session.getAttribute("loginUser")).getMemberEmail();
//
//        int result = new MemberService().deleteMember(memberEmail);
//
//        if(result > 0) {
//            session.invalidate(); //세션 무효화 한 번더 !
//            response.sendRedirect(request.getContextPath());
//        } else {
//            request.setAttribute("msg", "회원 탈퇴에 실패했습니다.");
//            request.getRequestDispatcher("WEB-INF/views/common/errorPage.jsp").forward(request, response);
//        }
		
		HttpSession session = request.getSession();
		String memberEmail = ((Member)session.getAttribute("loginUser")).getMemberEmail();
		
		int result = new MemberService().deleteMember(memberEmail);
		
		if(result > 0) {
			session.invalidate(); // 세션 무효화 - 로그아웃
			response.sendRedirect(request.getContextPath()); // 메인으로
		} else {
			request.setAttribute("msg", "회원탈퇴 실해");
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
