package member.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.websocket.SendResult;

import member.model.service.MemberService;
import member.model.vo.Member;

/**
 * Servlet implementation class MemberUpdateServlet
 */
@WebServlet("/update.me")
public class MemberUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberUpdateServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String email = request.getParameter("memberEmail");
		String name = request.getParameter("memberName");
		String phone = request.getParameter("memberPhone");
		String profile = request.getParameter("profile"); // 출력해보면 파일명임
		
		HttpSession session = request.getSession();
		String originNickName = ((Member)session.getAttribute("loginUser")).getMemberNickName();
		
		String nickName = request.getParameter("nickName").trim().equals("") ? originNickName : request.getParameter("nickName").trim();
		// 닉네임 입력칸을 다 비우고(다 지우고) form제출시 ""로 들어옴, 만약 ""로 들어온다면 원래 닉네임으로 변경  (닉네임은 null값 허용하지 않기 때문), equals 또는  == ""로 비교 (== ""로 해도 안에 내용이 없어서 비교 가능)  
		
		Member newInfo = new Member(email, name, nickName, phone);	
		
		int checkResult = 0; 
		// 세션에 저장된 닉네임과 변경하고자 하는 닉네임이 다르다면 중복검사 진행 , 
		if (!nickName.equals(originNickName)) {
			checkResult = new MemberService().checkNick(nickName);
		}
		
		// 기존의 닉네임이랑 중복된다면 request에 msg저장해서 정보 수정 페이지로 돌아감 (sendRedirect방식으로 url에 check=1같은 걸 붙여서 보내도 됨)
		if (checkResult > 0) {
			request.setAttribute("msg", "사용 중인 닉네임입니다. 닉네임 중복확인이 필요합니다."); 
			request.getRequestDispatcher("WEB-INF/views/member/memberUpdateForm.jsp").forward(request, response);
		} else {
			// 닉네임이 중복되지 않았거나 기존 닉네임이랑 같을때 update 실행
			int result = new MemberService().updateMember(newInfo);
			if (result > 0) {
				Member loginUser = new MemberService().selectMember(email); // Service, DAO에 메소드 하나 더 만들거나 밑의 방식으로
				
				session.setAttribute("loginUser", loginUser);
				response.sendRedirect("myInfo.me");
			} else {
				request.setAttribute("msg", "회원 정보 수정에 실패했습니다.");
				request.getRequestDispatcher("WEB-INF/views/common/errorPage.jsp").forward(request, response);
			}
		}

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
