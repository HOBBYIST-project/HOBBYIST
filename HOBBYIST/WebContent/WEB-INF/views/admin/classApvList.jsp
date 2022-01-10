<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.ArrayList, hobbyistClass.model.vo.*, member.model.vo.Member"%>
<% 
	ArrayList<HClass> apvList = (ArrayList)request.getAttribute("apvList");
	ApvPageInfo pi = (ApvPageInfo)request.getAttribute("pi");
	Member loginUser = (Member)session.getAttribute("loginUser");
	ArrayList<HClass> beforeApvClass = (ArrayList)request.getAttribute("beforeApvClass");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="../common/css.jsp"%>
<title>Insert title here</title>
</head>
<style>
	#toFirstBtn, #beforeBtn, #afterBtn, #toLastBtn {
		border-radius: 50%;
	}
</style>
<body>
	<div class="banner_bg_main">
		<div class="container">
			<div class="header_section_top">
				<div class="row">
					<div class="col-sm-12">
						<div class="custom_menu">
							<ul>
								<li><a href="<%= request.getContextPath() %>">MAIN</a></li>
									<% if(loginUser == null) { %>
										<li></li>
										<li><a href="#" onclick="alert('로그인을 먼저 해주세요.');">LIKED-CLASS</a></li> <!-- 로그인 전이면 LIKED-CLASS 접근 불가 -->
									<% } else if(loginUser.getMemberGrade().equals("A")){ %>
										<!-- 관리자면 LIKED-CLASS버튼 비활성화 -->
									<% } else { %>
										<li></li>
										<li><a href="<%= request.getContextPath() %>/myClass.te">LIKED-CLASS</a></li>
									<% } %>
										<li></li>
									<% if(loginUser == null) { %>
										<li><a href="<%= request.getContextPath() %>/loginForm.me">LOG-IN</a></li> <!-- login전이면 로그인버튼 -->
									<% } else { %>
										<li><a href="<%= request.getContextPath() %>/logout.me">LOG-OUT</a></li> <!-- login된 상태면 로그아웃버튼 -->
									<% } %>
										<li></li>
									<% if(loginUser == null) { %>
										<li><a href="#" onclick="alert('로그인을 먼저 해주세요.');">MY INFO</a></li>
									<% } else { %>
										<li><a href="<%= request.getContextPath() %>/myInfo.me">MY INFO</a></li> <!-- 로그인 전이면 MY INFO 접근 불가 -->
									<% } %>
										<li></li>
										<li><a href="<%= request.getContextPath() %>/FAQ.bo">FAQ</a></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 메인 화면 -->
	<div class="sidebar">
		<div class="scrollbar-inner sidebar-wrapper">
			<div class="user">
				<div class="photo">
					<img src="../assets/images/iu3.jpg">
				</div>
				<div class="info">
					<a class="" data-toggle="collapse" href="#collapseExample"
						aria-expanded="true"> <span> <b><%= loginUser.getMemberNickName()  %></b> <!-- loginUser의 NickName 불러오기 -->
							<span class="user-level"><!-- loginUser의 grade 불러오기 -->
								<% if(loginUser.getMemberGrade().equals("A")) { %>
									<span class="user-level">관리자(admin)</span>
								<% } else if(loginUser.getMemberGrade().equals("B")) { %>
									<span class="user-level">튜터(Tutor)</span>
								<% } else { %>
									<span class="user-level">튜티(Tutee)</span>
								<% }  %>
							</span> 
							<span class="caret"></span>
					</span>
					</a>
					<div class="clearfix"></div>

					<div class="collapse in" id="collapseExample" aria-expanded="true"
						style="">
						<ul class="nav">
							<li><a href="<%=request.getContextPath()%>/myInfo.me"> <span
									class="link-collapse"> ADMIN 정보 보기</span>
							</a></li>
							<li><a href="<%=request.getContextPath()%>/updateForm.me">
									<span class="link-collapse"> ADMIN 정보 수정</span>
							</a></li>
							
						</ul>
					</div>
				</div>
			</div>
			<ul class="nav">
				<li class="nav-item"><a
					href="<%=request.getContextPath()%>/memberCheck.admin"> <i
					class="la la-user"></i>
					<p>MEMBER LIST</p>
				</a></li>
				<li class="nav-item"><a
					href="<%=request.getContextPath()%>/apvList.cl"> <i
						class="la la-check-circle"></i>
						<p>CLASS APV LIST</p>
						<span class="badge badge-primary">
						<% if(beforeApvClass.isEmpty()) { %>
							0
						<% } else { %>
							<%= beforeApvClass.size() %>
						<% } %>
<!-- 							10 -->
						</span> <!-- 승인/반려 전인 클래스 개수 count로 가져오기 -->
				</a></li>
				<li class="nav-item"><a
					href="<%=request.getContextPath()%>/FAQ.bo"> <i
						class="la la-question-circle"></i>
						<p>FAQ</p>
				</a></li>
				<li class="nav-item"><a
					href="<%=request.getContextPath()%>/list.cs"> <i
						class="la la-question-circle"></i>
						<p>1:1 REQUEST</p>
				</a></li>
<!-- 				<li class="nav-item"><a --> <!-- 공지사항 활용X 필요시 주석해제 -->
<%-- 					href="<%=request.getContextPath()%>/notification.no"> <i --%>
<!-- 						class="la la-bell"></i> -->
<!-- 						<p>NOTIFICATIONS</p> -->
<!-- 				</a></li> -->
				<!-- <hr> -->
					


				<!-- <li class="nav-item update-pro">
					<button onclick="reservation()">
						<i class="la la-hand-pointer-o"></i>
						<p>튜터 신청하기</p>
					</button>
				</li> 
				이 영역은 운영자이기 때문에 주석처리
				-->

			</ul>
		</div>
	</div>
	<!-- 사이드바 영역 -->

	<!-- 메인 영역 -->
	<div class="main-panel">
		<div class="content">
			<div class="container-fluid">
				<h4 class="page-title"> CLASS APPROVAL LIST </h4>
				<hr>
				<div class="row justify-content-center">

					<div class="col-md-12">
						<div class="card">
							<div class="card-header">
								<div class="card-title">클래스 승인 관리</div>
							</div>
							<div class="card-body">
							<form method="post" action="confirmClass.cl">
								<table class="table" id="listArea">
									<thead>
										<tr>
											<th scope="col">신청일자</th>
											<th scope="col">클래스#</th>
											<th scope="col">튜터#</th>
											<th scope="col">카테고리</th>
											<th scope="col">클래스이름</th>
											<th scope="col">클래스신청내용</th>
											<th scope="col">승인/반려</th>
											<th scope="col">승인여부</th>
										</tr>
									</thead>
									<tbody>
		 
									 <% if(apvList.isEmpty()) { %>
										<tr>
											<td colspan = "8"> 조회된 리스트가 없습니다. </td>
										</tr>
										<% } else { %> 
											<%	for(int i = 0; i < apvList.size(); i++){ %>  
											<tr>
												<td>
													<%= apvList.get(i).getClassEnrollDate() %>
													<input type="hidden" id="classEnrollDate" name="classEnrollDate" value="<%= apvList.get(i).getClassEnrollDate() %>">
												</td>
												<td>
													<%= apvList.get(i).getClassNo() %>
													<input type="hidden" id="classNo" name="classNo" value="<%= apvList.get(i).getClassNo() %>">
												</td>
												<td>
													<%= apvList.get(i).getTutorNo() %>
													<input type="hidden" id="tutorNo" name="tutorNo" value="<%= apvList.get(i).getTutorNo() %>">	
												</td>
												<td>
													<%= apvList.get(i).getcategoryName() %>
													<input type="hidden" id="categoryName" name="categoryName" value="<%= apvList.get(i).getcategoryName() %>">
												</td>
												<td>
													<%= apvList.get(i).getClassName() %>
													<input type="hidden" id="className" name="className" value="<%= apvList.get(i).getClassName() %>">
												</td>
												<td>
													<input type="button" class="btn btn-outline-primary" id="detailClass" value="클래스 신청서 확인" onclick="location.href='<%= request.getContextPath() %>/detail.hcl?cNo=<%= apvList.get(i).getClassNo() %>'">
<%-- 												<button type="button" class="btn btn-outline-primary" id="detailClass" onclick="<%= request.getContextPath() %>/classopendetail.me">클래스 신청서 확인</button> --%>
												</td>
												<td>
													<div class="btn-group" role="group" aria-label="Basic mixed styles outlined example">
														<% if(apvList.get(i).getClassApvYn().equals("Y")){ %>
															<input type="button" class= "btn btn-outline-success APV active" value="승인">
															<input type="button" class= "btn btn-outline-danger REJECT" value="반려">
														<% } else if(apvList.get(i).getClassApvYn().equals("C")) { %>
															<input type="button" class= "btn btn-outline-success APV" value="승인">
															<input type="button" class= "btn btn-outline-danger REJECT active" value="반려">	
															<% } else { %>
															<input type="button" class= "btn btn-outline-success APV" value="승인">
															<input type="button" class= "btn btn-outline-danger REJECT" value="반려">
															<% } %>
<!-- 														<input type="button" class= "btn btn-outline-danger" value="반려"> -->
<!-- 														<input type="button" id="APV" class="btn btn-outline-success" value="Y" onclick="confirmClass();"> -->
<!-- 														<input type="button" id="REJECT" class="btn btn-outline-danger" value="N"> -->
													</div>
												</td>
												 <td>
													<span><%= apvList.get(i).getClassApvYn() %></span>
													<input type="hidden" id="classApvYn" name="classApvYn" value="<%= apvList.get(i).getClassApvYn() %>">
												</td> 
											</tr>
										 <% } %>
									<% } %>
									</tbody>
								</table>
								</form>
							</div>
						</div>
					</div>
					
					
					<!-- 페이지네이션: 페이징처리시 영역나타남 -->
					<nav aria-label="Page navigation example">
						<ul class="pagination justify-content-center">
							<li class="page-item">
								<button class="page-link" id="toFirstBtn" href="location.href='<%= request.getContextPath() %>/apvList.cl?currentPage=1'">&laquo;</button>
							</li>
						<!-- prev -->
							<li class="page-item">
								<button class="page-link" id="beforeBtn" href="<%= request.getContextPath() %>/apvList.cl?currentPage=<%= pi.getCurrentPage() -1 %>'" aria-label="Previous">&laquo;</button>
							</li>
							
							<script>
								if(<%= pi.getCurrentPage() %> <= 1){
									$('#beforeBtn').prop('disabled', true);
								}
							</script>
							
						<!-- 페이지넘버 -->
							<% for (int p = pi.getStartPage(); p <= pi.getEndPage(); p++) { %>
								<% 		if(p == pi.getCurrentPage()) { %>
									<li class="page-item" id="choosen"><a class="page-link" href=""><%= p %></a></li> <!-- 현재 페이지는 선택 못하게 -->
								<%      } else { %> 
											<li class="page-item" id="numBtn"><a class="page-link" href="<%= request.getContextPath() %>/apvList.cl?currentPage=<%= p %>"><%= p %></a></li>
									<% } %>
							<% 	} %>
							
							<!-- next -->
							<li class="page-item">
								<button id="afterBtn" class="page-link" href="location.href='<%= request.getContextPath() %>/apvList.cl?currentPage=<%= pi.getCurrentPage() + 1 %>'"
									aria-label="Next"> &raquo;</button>
							</li>
							<li class="page-item">
								<button id="toLastBtn" class="page-link" href="location.href='<%= request.getContextPath() %>/apvList.cl?currentPage=<%= pi.getMaxPage() %>'" 
									aria-label="Next"> &raquo; </button>
							</li>
						</ul>
					
						<script>
							if(<%= pi.getCurrentPage() %> >= <%= pi.getMaxPage() %>){
									$('#afterBtn').prop('disabled', true);
							} 
						</script>
					</nav>
				</div>
			</div>

		</div>
	</div>


	<%@ include file="../common/js.jsp"%>
</body>
</html>