<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.ArrayList, faq.model.vo.FAQ, member.model.vo.Member" %>
<% 
	FAQ faq= (FAQ)request.getAttribute("faq");
	Member loginUser = (Member)session.getAttribute("loginUser");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="../common/css.jsp"%>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<style>
#tdReply {
	height: 250px;
}
</style>
<title>자주 묻는 질문(FAQ)</title>
</head>
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
	<% if(loginUser == null || !loginUser.getMemberGrade().equals("A")){ %>
	<!-- 로그인하지 않은 유저는 사이드 바 없음 -->
	<!-- 메인 영역 -->
<!-- 	<div class="main-panel"> -->
	<div class="row justify-content-md-center">
		<div class="col-md-10">
			<div class="content">
				<div class="container-fluid">
					<h4 class="page-title"></h4>
					<h4 class="page-title">자주 하는 질문(FAQ)</h4>
				<hr>
				<div class="row justify-content-center">

					<div class="col-md-12">
						<div class="card">
<!-- 							<div class="card-header"> -->
<!-- 								<div class="card-title">자주 하는 질문(FAQ)</div> -->
<!-- 							</div> -->
							<div class="card-body">

								<div class="container">
									<div class="row">
										<form action="FAQUpdateForm.bo" id="detailForm" name="detailForm" method="post">
											<table class="table table-striped"
												style="text-align: center; border: 1px solid #dddddd">
												<tbody>
													<tr style="border-right: 1px solid black">
														<th class="thReply" style="background color: #eeeeee; text-align: center;"> 번호</th>
														<td class="tdReply"> 
															<%= faq.getFaqNo() %> 
															<input type="hidden" id="no" name="no" value="<%= faq.getFaqNo() %>">
														</td>											
													</tr>
													<tr>
														<th class="thReply" style="background color: #eeeeee; text-align: center;"> 카테고리</th>
														<td class="tdReply"> 
															<%= faq.getFaqCategory() %> 
															<input type="hidden" id="category" name="category" value="<%= faq.getFaqCategory() %>">
														</td>
													</tr>
													<tr>
														<th class="thReply" style="background color: #eeeeee; text-align: center;"> 제목</th>
														<td class="tdReply"> 
															<%= faq.getFaqTitle() %> 
															<input type="hidden" id="title" name="title" value="<%= faq.getFaqTitle() %>">
														</td>
													</tr>
													<tr>
														<th class="thReply" style="background color: #eeeeee; text-align: center;"> 답변</th>
														<td class="tdReply" id="tdReply">
															<%= faq.getFaqReply() %>
															<input type="hidden" id="reply" name="reply" value="<%= faq.getFaqReply() %>">
														</td>
													</tr>												
												</tbody>
											</table>
											<div id="btnArea">
												<input type="button" class="btn btn-primary pull-right" id="FAQcancel" value="목록으로" onclick="location.href='javascript:history.go(-1);'">
											</div>
										</form>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>	
	</div>
	<% } else if(loginUser.getMemberGrade().equals("A")) {	%>
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
			</ul>
		</div>
	</div>
	
	<!-- 메인 영역 -->
	<div class="main-panel">
		<div class="content">
			<div class="container-fluid">
				<h4 class="page-title">FAQ MANAGEMENT</h4>
				<hr>
				<div class="row justify-content-center">

					<div class="col-md-12">
						<div class="card">
							<div class="card-header">
								<div class="card-title">자주 하는 질문(FAQ)</div>
							</div>
							<div class="card-body">

								<div class="container">
									<div class="row">
										<form action="FAQUpdateForm.bo" id="detailForm" name="detailForm" method="post">
											<table class="table table-striped"
												style="text-align: center; border: 1px solid #dddddd">
												<tbody>
													<tr>
														<th style="background color: #eeeeee; text-align: center;"> 번호</th>
														<td id="td_content"> 
															<%= faq.getFaqNo() %> 
															<input type="hidden" id="no" name="no" value="<%= faq.getFaqNo() %>">
														</td>											
													</tr>
													<tr>
														<th style="background color: #eeeeee; text-align: center;"> 카테고리</th>
														<td id="td_content"> 
															<%= faq.getFaqCategory() %> 
															<input type="hidden" id="category" name="category" value="<%= faq.getFaqCategory() %>">
														</td>
													</tr>
													<tr>
														<th style="background color: #eeeeee; text-align: center;"> 제목</th>
														<td id="td_content"> 
															<%= faq.getFaqTitle() %> 
															<input type="hidden" id="title" name="title" value="<%= faq.getFaqTitle() %>">
														</td>
													</tr>
													<tr>
														<th id="tdReply" style="background color: #eeeeee; text-align: center;"> 답변</th>
														<td id="td_content_reply">
															<%= faq.getFaqReply() %>
															<input type="hidden" id="reply" name="reply" value="<%= faq.getFaqReply() %>">
														</td>
													</tr>												
												</tbody>
											</table>
											<div id="btnArea">
												<input type="button" class="btn btn-default pull" id="FAQcancel" value="목록으로" onclick="location.href='<%= request.getContextPath() %>/FAQ.bo'">
												<input type="submit" class="btn btn-primary pull-right" id="editFaqBtn" value="수정하기">
											</div>
										</form>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<% } %>
	
	<%@ include file="../common/js.jsp"%>
</body>
</html>