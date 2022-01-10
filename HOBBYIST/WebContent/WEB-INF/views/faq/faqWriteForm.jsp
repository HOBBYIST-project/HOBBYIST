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
<!-- <script src="js/jquery-3.6.0.min.js"></script> -->
<!-- <script src="js/menubar.js"></script> -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<style>
.tdReply{
	border-right: 1px solid black;
}
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
								<div class="card-title">자주 하는 질문(FAQ) 등록</div>
							</div>
							<div class="card-body">

								<div class="container">
									<div class="row">
										<form action="<%= request.getContextPath() %>/FAQinsert.bo" id="detailForm" name="detailForm" method="post">
											<table class="table table-striped"
												style="text-align: center; border: 1px solid #dddddd">
												<tbody>
															<%-- <tr>
																<th style="background color: #eeeeee; text-align: center;"> 번호</th>
																<td id="td_content"> 
																	<%= faq.getFaqNo() %> 
																	<input type="hidden" id="no" name="no" value="<%= faq.getFaqNo() %>">
																</td>											
															</tr> --%>
													<tr>
														<th style="background color: #eeeeee; text-align: center;"> 제목</th>
														<td> 
															<input type="text" id="title" name="title" style="width:700px; height:35px;" value="">
														</td>
													</tr>
													<tr>
														<th style="background color: #eeeeee; text-align: center;"> 카테고리</th>
														<td> 
															<select id="category" name="category" style="width: 700px; height: 35px;">
																<option value="계정">계정</option>
																<option value="수강">수강</option>
																<option value="서비스">서비스</option>
																<option value="기타">기타</option>
															</select>
														</td>
													</tr>
													
													<tr>
														<th style="background color: #eeeeee; text-align: center;"> 내용</th>
														<td >
															<textarea id="reply" name="reply" rows="20" cols="97" style= "resize: none"></textarea>
														</td>
													</tr>												
												</tbody>
											</table>
											<div id="btnArea">
												<input type="submit" class="btn btn-primary pull-right" id="FAQWriteBtn" style="margin-left: 5px;" value="FAQ 등록">
												<input type="button" class="btn btn-default pull-right" id="FAQcancel" value="작성 취소" style="margin-left: 5px;" onclick="location.href='javascript:history.go(-1);'">
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
	
	<%@ include file="../common/js.jsp"%>
</body>
</html>