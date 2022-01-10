<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="member.model.vo.Member" %>
<%
	Member loginUser = (Member)request.getSession().getAttribute("loginUser");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="../common/css.jsp"%>
<script src="js/jquery-3.6.0.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<title>Insert title here</title>
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
	
	<% if(loginUser.getMemberGrade().equals("A")) {	%>
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
	<% } else { %>
	<div class="sidebar">
		<div class="scrollbar-inner sidebar-wrapper">
			<div class="user">
				<div class="photo">
					<img src="../assets/images/iu2.jpg">
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
							<li><a href="<%=request.getContextPath()%>/myInfo.me">
									<span class="link-collapse">내 정보 보기</span>
							</a></li>
							<li><a href="<%=request.getContextPath()%>/updateForm.me">
									<span class="link-collapse">내 정보 수정</span>
							</a></li>
							<li><a
								href="<%=request.getContextPath()%>/deleteConfirm.me"> <span
									class="link-collapse">튜티 탈퇴</span>
							</a></li>
						</ul>
					</div>
				</div>
			</div>
			<ul class="nav">
				<li class="nav-item"><a
					href="<%=request.getContextPath()%>/myClass.te"> <i
						class="la la-toggle-on"></i>
						<p>MY CLASS</p> <span class="badge badge-primary">5</span>
				</a></li>
				<li class="nav-item"><a
					href="<%=request.getContextPath()%>/likedClass.cl"> <i
						class="la la-gittip"></i>
						<p>LIKED CLASS</p>
				</a></li>
				<li class="nav-item"><a
					href="<%=request.getContextPath()%>/review.re"> <i
						class="la la-camera-retro"></i>
						<p>MY REVIEW</p>
				</a></li>
				<hr>
				<li class="nav-item"><a
					href="<%=request.getContextPath()%>/notification.no"> <i
						class="la la-bell"></i>
						<p>NOTIFICATIONS</p>
				</a></li>
				<% if (loginUser != null && loginUser.getMemberGrade().equals("B")) { %>
				<hr>
				<li class="nav-item"><a
					href="<%=request.getContextPath()%>/tutorSignUp.no"> <i
						class="la la-pencil"></i>
						<p>APPLICATION</p>
				</a></li>
				<li class="nav-item"><a
					href="<%=request.getContextPath()%>/tutorClass.no"> <i
						class="la la-calendar-o"></i>
						<p>TUTOR ON CLASS</p>
				</a></li>
				<!-- DAO가 없기 때문에 빨간줄이 떠서 주석처리 / model단 받아오시면 주석풀면 됩니다. -->
				<% } else { %>
				<li class="nav-item update-pro">
					<button onclick="reservation()">
						<i class="la la-hand-pointer-o"></i>
						<p>튜터 신청하기</p>
					</button>
				</li>
				<% } %>
			</ul>
		</div>
	</div>
			
	<% } %>
			
	<div class="main-panel">
		<div class="content">
			<div class="container-fluid">
				<h4 class="page-title">MY INFORMATION</h4>
				<div class="row justify-content-center">
					<div class="col-md-4">
						<div class="card">
							<div class="card-header">
								<div class="card-body">
									<form action=""	method="post" encType="multipart/form-data">
										<div class="box">
											<div class="tutorPro">
												<div class="row justify-content-center">

													<!-- <div id="fileArea" class="col-md-7">
														<input type="file" class="form-control" id="profiledImg"
															multiple="multiple" name="profileImg"
															onchange="LoadImg(this, 1)">
													</div> -->
													<div class="col-md-7 justify-content-center">
														<img class="userImg" id="target_img" name="target_img"
															src="images/gosim2.jpg" alt="profile-image" />


														<div class="page-content" style="margin: 20px;">
															<%= loginUser.getMemberNickName() %>
														</div>
														</div>
										<div class="col-md-6">
										<div class="justify-content-center">
															
											<i class="la la-facebook"></i> <a href="#" class="card-link">Facebook</a>&nbsp;<br>
											<i class="la la-twitter"></i> <a href="#" class="card-link">Twitter</a>&nbsp;<br>
											<i class="la la-instagram"></i> <a href="#" class="card-link">Instagram</a>&nbsp;<br>
											<i class="la la-youtube"></i> <a href="#" class="card-link">Youtube</a>&nbsp;<br>
									
										</div>
										</div>

													
													
												</div>
											</div>
										</div>
									</form>
								</div>
							</div>
						</div>
					</div>
					<div class="col-md-8">
						<div class="card">
							<div class="card-header">
								<div class="card-body">
								<form action="<%= request.getContextPath() %>/update.me" method="POST" onsubmit="return updateValidate();"> <!-- 제출 전 검사 진행! -->
									<div class="form-group">
										<label for="exampleFormControlSelect1"><b>이메일</b></label>
											<div class="form-floating mb-3">
												<%= loginUser.getMemberEmail() %>
												<input type="hidden" name="email" class="form-control" id="floatingInput" value="<%= loginUser.getMemberEmail() %>"> 
												<label for="floatingInput"></label>
												<label for="floatingInput"><small id="selectHelp" class="form-text text-muted"></small></label>
											</div> 		
										<label for="floatingInput"><small id="selectHelp" class="form-text text-muted">가입하신 이메일은 변경하실 수 없습니다</small></label>
									</div>
									
									<div class="form-group">
										<label for="exampleFormControlSelect1"><b>이름</b></label>
										<div class="input-group mb-3">
											<span class="input-group-text" id="basic-addon1">@</span> 
											<input type="text" name="name" class="form-control" placeholder="<%= loginUser.getMemberName() %>" 
													value="<%= loginUser.getMemberName() %>" aria-label="Username" aria-describedby="basic-addon1" disabled>
										</div>
										<label for="floatingInput"><small id="selectHelp" class="form-text text-muted">이름 변경은 별도의 절차를 거친 후 가능합니다.</small></label>
									</div>
									
									<div class="form-group">
										<label for="exampleFormControlSelect1"><b>닉네임</b></label> <span
											class="badge badge-danger">필수 </span>
										<div class="input-group mb-3">
											<span class="input-group-text" id="basic-addon2">@</span> 
											<input type="text" id="nickName" name="nickName" class="form-control" placeholder="닉네임은 한글, 영문, 숫자 2-10자리만 가능합니다" 
													value="<%= loginUser.getMemberNickName() %>" aria-label="Username" aria-describedby="basic-addon1">
										</div>
										<label for="floatingInput"><span id="nickResult"></span></label>
									</div>
										
									<div class="form-group">
										<label for="exampleFormControlSelect1"><b>연락처</b></label> <span class="badge badge-danger">필수</span> 
											<div class="input-group mb-3">
												<span class="input-group-text" id="basic-addon1">#</span> 
												<input type="text" id="phone" name="phone" class="form-control" placeholder="숫자, -을 포함해 휴대전화 형식에 맞게 입력해주세요."
														value="<%= loginUser.getMemberPhone() %>" aria-label="phoneNumber" aria-describedby="basic-addon1">
											</div>
										<input type="hidden" class="form-control" id="floatingInput" value="<%= loginUser.getMemberPhone()%>"> 
										<label for="floatingInput"><span id="phoneResult"></span></label>
									</div>
									<br>
									<div class="row justify-content-center">
										<div class="col-2">
											<button type="button" class="btn btn-default" onclick="location.href='javascript:history.go(-1)'">취소하기</button>
										</div>
										<div class="col-2">
											<button type="submit" class="btn btn-primary">수정하기</button>
										</div>
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
		
		<script>	
		var isUsable = false;		// form제출 가능 여부
		var isNickChecked = false;	// 닉네임 체크 여부
		var isPhoneChecked = false; // 폰 체크 여부
		var nickName = document.getElementById('nickName');
		var originNickName =  '<%= loginUser.getMemberNickName() %>';
		var originPhone = '<%= loginUser.getMemberPhone() %>'
		var phone = document.getElementById('phone');
		

 		$('#nickName').on('change paste keyup', function(){ // 아이디 입력사항이 변경, 붙여넣기, 키업 이벤트가  발생했을 경우 
			isNickChecked = false; // false로 초기화
		});
 		
 		$('#phone').on('change paste keyup', function(){ // 아이디 입력사항이 변경, 붙여넣기, 키업 이벤트가  발생했을 경우 
			isPhoneChecked = false; // false로 초기화
		});
		 
		$('#nickName').on('change', function(){
			var regExpNick =  /^[가-힣ㄱ-ㅎa-zA-Z0-9]{2,10}\$/;
			
			if (nickName.value.trim().length < 2 || nickName.value.trim().length > 10) {
				alert('2~10자리까지 입력해주세요.');
				$('#nickResult').text('사용 불가능합니다.');
				$('#nickResult').css('color', 'red');
				nickName.focus();
			} else if (nickName.value.trim() == originNickName.trim()) {
				$('#nickResult').text(''); // 기존 닉네임이랑 같으면 닉네임 중복체크 칸 비움
				isUsable = true;
				isNickChecked = true;
			} else {
				if (!regExpNick.test(nickName.value.trim())) {
					$('#nickResult').text('형식에 맞지 않는 닉네임입니다.');
					$('#nickResult').css('color', 'red');
					isUsable = false;
					isNickChecked = false;
					nickName.focus();
				} else {
					$.ajax({ // 닉네임 중복여부 검사
						url: 'checkNick.me', 
						data: {inputNickName:nickName.value.trim()},
						success: function(data){
							console.log(data);
							if (data.trim() == '0') { // int로 보냈지만 string으로 넘어옴, 띄어쓰기가 들어가있을 수도 있기 때문에 trim() 처리
								$('#nickResult').text('사용 가능합니다.');
								$('#nickResult').css('color', 'green');
								isUsable = true;
								isNickChecked = true;
							} else {
								$('#nickResult').text('사용 불가능합니다.');
								$('#nickResult').css('color', 'red');
								isUsable = false;
								isNickChecked = false;
								nickName.focus();
							}
						},
						error: function(data){
							console.log(data);
						}
					});
				}
			}
		});
				
		$('#phone').on('change', function(){
			var regExpPhone = /^01([0|1|6|7|8|9])-([0-9]{3,4})-([0-9]{4})$/;
			
			if (phone.value.trim() == '' || phone.value.trim().length == 0) {
				$('#phoneResult').text('');
				isUsable = true;
				isPhoneChecked = true;
			} else if (phone.value.trim() == originPhone.trim()) {
				$('#phoneResult').text('');
				isUsable = true;
				isPhoneChecked = true;
			} else if (!regExpPhone.test($(this).val().trim())) {
				$('#phoneResult').text('형식에 맞지 않는 전화번호입니다.');
				$('#phoneResult').css('color', 'red');
				isUsable = false;
				isPhoneChecked = false;
			} else {
				$('#phoneResult').text('사용 가능합니다.');
				$('#phoneResult').css('color', 'green');
				isUsable = true;
				isPhoneChecked = true;
			}
		});
		
		
		function updateValidate(){
			if(isUsable && isNickChecked && isPhoneChecked) {
				return true;
			} else if (!isNickChecked && nickName.value.trim() != originNickName.trim()) {
				alert('닉네임을 확인해주세요.');
				nickName.focus();
				return false;
			} else if (!isPhoneChecked && phone.value.trim() != originPhone.trim()) {
				if (!(phone.value.trim() == '' || phone.value.trim().length == 0)) {
					alert('휴대폰 번호 형식을 확인해주세요.');
					phone.focus();
					return false;
				}
			} 
			return true;
		}
				
	</script>
		
	<%@ include file="../common/js.jsp"%>

	<!-- <script>
		 	
	/* 파일선택이 안가려져요 ㅠㅠ 그래서 일단 이미지로 넣어두었어요.... */
		
	
		$(document).ready(function() {
			$('#fileArea').hide();
			$('#target_img').click(function() {
				$('#profileImg').click();
			});
		

		function LoadImg(value, num) {
			if (value.files && value.files[0]) {
				var reader = new FileReader();
				reader.onload = function(e) {
					if (num == 1) {
						$("#target_img").attr("src", e.target.result);
					} else if (num == 2) {
						$("#target_img2").attr("src", e.target.result);
					}
				}

				reader.readAsDataURL(value.files[0]);
			}
		}
		});

	</script> -->



</body>
</html>