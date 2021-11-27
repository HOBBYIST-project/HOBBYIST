<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="tutor.model.vo.Tutor, member.model.vo.Member,hobbyistClass.model.vo.HClass"%>
<%
// 	Member m = (Member)request.getAttribute("loginUser");	
	Tutor tt = (Tutor)session.getAttribute("tutor");
	String myReport = tt.getTutorReport();
	String mySns = tt.getTutorSns();
	Member m = (Member)session.getAttribute("loginUser");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>튜터 정보 페이지</title>
<script src="js/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" type="text/css" href="css/menubar.css">
<link rel="stylesheet" type="text/css" href="css/myInfo.css">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css" rel="stylesheet">
<script src="js/menubar.js"></script>
<style>
/*footer*/
.off-canvas-content{
	position:relative;
	padding-bottom:100px;
}

.contents-wrap{
	width:100%;
   height:100px;
   position:absolute;
   bottom:-73%;
}


#updatePwdBtn {
		background: #778899;
		font-weight: bold;
		cursor: pointer;
		color: white;
		box-shadow: 2px 2px 2px lightgray;
		font-size: large;
	}
#classtitle{
	text-align:center;
	font-size:200%;
	font-weight:bold;
}

/*프로필 박스*/
.box1{
	text-align:center;
/* 	border:1px solid #D5D5D5; */
	width: 650px;
	height: 520px;
	margin: 0 auto;
	padding: 30px;
}


/*sns아이콘*/
.rounded-social-buttons {
  text-align: center;
/*   position:absolute;  */
   left:50%; 
  top:40%;
  margin-left:0px; 

}

.rounded-social-buttons .social-button {
  display: inline-block;
  position: relative;
  cursor: pointer;
  width: 3.125rem;
  height: 3.125rem;
  border: 0.125rem solid transparent;
  padding: 0;
  text-decoration: none;
  text-align: center;
  color: #fefefe;
  font-size: 1.5625rem;
  font-weight: normal;
  line-height: 2em;
  border-radius: 1.6875rem;
  transition: all 0.5s ease;
  margin-right: 0.25rem;
  margin-bottom: 0.25rem;
}

.rounded-social-buttons .social-button:hover, .rounded-social-buttons .social-button:focus {
  -webkit-transform: rotate(360deg);
      -ms-transform: rotate(360deg);
          transform: rotate(360deg);
}

.rounded-social-buttons .social-button.facebook {
  background: #3b5998;
}

.rounded-social-buttons .social-button.facebook:before {
  font-family: "FontAwesome";
  content: "";
}

.rounded-social-buttons .social-button.facebook:hover, .rounded-social-buttons .social-button.facebook:focus {
  color: #3b5998;
  background: #fefefe;
  border-color: #3b5998;
}

.rounded-social-buttons .social-button.twitter {
  background: #55acee;
}

.rounded-social-buttons .social-button.twitter:before {
  font-family: "FontAwesome";
  content: "";
}

.rounded-social-buttons .social-button.twitter:hover, .rounded-social-buttons .social-button.twitter:focus {
  color: #55acee;
  background: #fefefe;
  border-color: #55acee;
}

.rounded-social-buttons .social-button.linkedin {
  background: #007bb5;
}

.rounded-social-buttons .social-button.linkedin:before {
  font-family: "FontAwesome";
  content: "";
}

.rounded-social-buttons .social-button.linkedin:hover, .rounded-social-buttons .social-button.linkedin:focus {
  color: #007bb5;
  background: #fefefe;
  border-color: #007bb5;
}

.rounded-social-buttons .social-button.youtube {
  background: #bb0000;
}

.rounded-social-buttons .social-button.youtube:before {
  font-family: "FontAwesome";
  content: "";
}

.rounded-social-buttons .social-button.youtube:hover, .rounded-social-buttons .social-button.youtube:focus {
  color: #bb0000;
  background: #fefefe;
  border-color: #bb0000;
}

.rounded-social-buttons .social-button.instagram {
  background: #125688;
}

.rounded-social-buttons .social-button.instagram:before {
  font-family: "FontAwesome";
  content: "";
}

.rounded-social-buttons .social-button.instagram:hover, .rounded-social-buttons .social-button.instagram:focus {
  color: #125688;
  background: #fefefe;
  border-color: #125688;
}

.rounded-social-buttons .social-button.pinterest {
  background: #cb2027;
}

.rounded-social-buttons .social-button.pinterest:before {
  font-family: "FontAwesome";
  content: "";
}

.rounded-social-buttons .social-button.pinterest:hover, .rounded-social-buttons .social-button.pinterest:focus {
  color: #cb2027;
  background: #fefefe;
  border-color: #cb2027;
}

.rounded-social-buttons .social-button.google-plus {
  background: #dd4b39;
}

.rounded-social-buttons .social-button.google-plus:before {
  font-family: "FontAwesome";
  content: "";
}

.rounded-social-buttons .social-button.google-plus:hover, .rounded-social-buttons .social-button.google-plus:focus {
  color: #dd4b39;
  background: #fefefe;
  border-color: #dd4b39;
}

.rounded-social-buttons .social-button.github {
  background: #000000;
}

.rounded-social-buttons .social-button.github:before {
  font-family: "FontAwesome";
  content: "";
}

.rounded-social-buttons .social-button.github:hover, .rounded-social-buttons .social-button.github:focus {
  color: #000000;
  background: #fefefe;
  border-color: #000000;
}

.rounded-social-buttons .social-button.tumblr {
  background: #32506d;
}

.rounded-social-buttons .social-button.tumblr:before {
  font-family: "FontAwesome";
  content: "";
}

.rounded-social-buttons .social-button.tumblr:hover, .rounded-social-buttons .social-button.tumblr:focus {
  color: #32506d;
  background: #fefefe;
  border-color: #32506d;
}

label[for="fabk"], [for="twit"], [for="insta"], [for="pinter"], [for="youtu"] {
  position: relative;
  top: -9px;
}


/*왼쪽 박스 */

.card-profile-stats {
  border: 1px solid #cacaca;
  margin: 0 0 1.25rem;
  padding: 1.25rem;
  background: #fefefe;
}

.card-profile-stats .card-profile-stats-intro {
  text-align: center;
}

.card-profile-stats .card-profile-stats-intro .card-profile-stats-intro-pic {
  border-radius: 50%;
  margin: 0 0 1.25rem;
}

.card-profile-stats .card-profile-stats-intro .card-profile-stats-intro-content p:last-child {
  margin: 0;
}

.card-profile-stats .card-profile-stats-container {
  text-align: center;
}

.card-profile-stats .card-profile-stats-container .card-profile-stats-statistic {
  margin: 0 0 1.25rem;
}

.card-profile-stats .card-profile-stats-container .card-profile-stats-statistic p:last-child {
  margin: 0;
}

.card-profile-stats .card-profile-stats-more .card-profile-stats-more-link {
  margin: 0;
  text-align: center;
  font-size: 1.5rem;
  color: #0a0a0a;
  padding: 0.5rem;
  cursor: pointer;
}

.card-profile-stats .card-profile-stats-more .card-profile-stats-more-content {
  display: none;
}


@media print, screen and (min-width: 64em) {
  .card-profile-stats .card-profile-stats-intro {
    -webkit-align-items: center;
        -ms-flex-align: center;
            align-items: center;
    display: -webkit-flex;
    display: -ms-flexbox;
    display: flex;
    -webkit-flex-direction: row;
        -ms-flex-direction: row;
            flex-direction: row;
    -webkit-flex-wrap: wrap;
        -ms-flex-wrap: wrap;
            flex-wrap: wrap;
    text-align: left;
  }
  .card-profile-stats .card-profile-stats-intro .card-profile-stats-intro-pic {
    margin: 0 1.25rem 0 0;
    max-width: 250px;
  }
  .card-profile-stats .card-profile-stats-container {
    display: -webkit-flex;
    display: -ms-flexbox;
    display: flex;
    -webkit-justify-content: space-around;
        -ms-flex-pack: distribute;
            justify-content: space-around;
  }
}

/*버튼*/
.button-rounded-hover {
  border: 0;
  border-radius: 5000px;
  padding: 1rem 2rem;
  text-transform: uppercase;
  position: relative;
  overflow: hidden;
  font-size: 1rem;
  letter-spacing: 2px;
  transition: all 0.35s ease;
  -webkit-transform: translateZ(0);
          transform: translateZ(0);
   color: #9ED4C2;
   cursor: pointer;

}

.button-rounded-hover:before {
  opacity: 0;
  content: "";
  position: absolute;
  top: 0px;
  bottom: 0px;
  left: 0px;
  right: 0px;
  border-radius: inherit;
  background-color: #fefefe;
  transition: all 0.3s;
  -webkit-transform: translateX(-100%);
      -ms-transform: translateX(-100%);
          transform: translateX(-100%);
}

.button-rounded-hover:after {
  position: absolute;
  top: 0px;
  bottom: 0px;
  left: 0px;
  right: 0px;
  border: 5px solid #9ED4C2;
  content: '';
  border-radius: inherit;

}

.button-rounded-hover:hover,
.button-rounded-hover:focus {
  background-color: #9ED4C2;
  color: white;
}

.button-rounded-hover:hover:before,
.button-rounded-hover:focus:before {
  -webkit-transform: translateX(0%);
      -ms-transform: translateX(0%);
          transform: translateX(0%);
  opacity: 0.25;
}

#target_img{cursor:pointer;}


</style>
</head>
<body>	
			<!-- 본문 영역 -->
		
			<div class="app-dashboard-body-content off-canvas-content" data-off-canvas-content>
			<p id="classtitle"> </p>
			<form action="<%= request.getContextPath() %>/updateTutor.me" method="post" encType="multipart/form-data">
<%-- 			<form action="<%= request.getContextPath() %>" encType="multipart/form-data"> --%>
 			<div class="box1"> 
			<div class="card-profile-stats">
		  <div class="card-profile-stats-intro"><!-- 프로필 사진 들어갈 div -->
<!-- 		    <img id="target_img" class="card-profile-stats-intro-pic" src="./images/gosim.png" alt="profile-image"/> -->
		    <img class="card-profile-stats-intro-pic" src="<%= request.getContextPath() %>/uploadFiles/<%= tt.getTutorImgChangeName() %>" alt="profile-image"/>
		     </div> <!-- /.card-profile-stats-intro -->


		    <div class="card-profile-stats-intro-content">
		      <h1><%= m.getMemberNickName() %></h1>
		      <p>START</p> <p>2021.11.16</p>
		    </div> <!-- /.card-profile-stats-intro-content -->
		 
		
		  <hr />
		
<!-- 		  <div class="card-profile-stats-container"> -->
<!-- 		    <div class="card-profile-stats-statistic"> -->
<!-- 		      <span class="stat">아이패드 그림 기초</span> -->
<!-- 		      <p style="font-weight:bold">수강명</p> -->
<!-- 		    </div> /.card-profile-stats-statistic -->
<!-- 		    <div class="card-profile-stats-statistic"> -->
<!-- 		      <span class="stat">25</span> -->
<!-- 		      <p style="font-weight:bold">수강 인원</p> -->
<!-- 		    </div> /.card-profile-stats-statistic -->
<!-- 		    <div class="card-profile-stats-statistic"> -->
<!-- 		      <span class="stat">15</span> -->
<!-- 		      <p style="font-weight:bold">후기 수</p> -->
<!-- 		    </div> /.card-profile-stats-statistic -->
<!-- 		  </div> /.card-profile-stats-container -->
		
		  <div class="card-profile-stats-more">
		    <p class="card-profile-stats-more-link"><a href="#"><i class="fa fa-angle-down" aria-hidden="true"></i></a></p>
		    <div class="card-profile-stats-more-content">	<!-- 클릭하면 접히는 화살표 -->
		    	<div>
		    	  <label>Phone : <%= m.getMemberPhone() %></label><br><br>
		    	  <label>Email : <%= m.getMemberEmail() %></label><br><br>
		    	  <label>Report : <%= tt.getTutorReport() %></label>
				  <input type="hidden" id="myReport" name="myReport" value="<%= tt.getTutorReport() %>">
			      <br><br>
<!-- 			      <div class="rounded-social-buttons"> -->
<!-- 				  <a class="social-button facebook" href="#"></a> -->
<!-- 				  <a class="social-button twitter" href="#"></a> -->
<!-- 				  <a class="social-button youtube" href="#"></a> -->
<!-- 				  <a class="social-button instagram" href="#"></a> -->
<!-- 				 </div> -->
				 <label>SNS : <%= tt.getTutorSns() == null ? "" : tt.getTutorSns()%> </label>
				  <input type="hidden" id="mySns" name="mySns" value="<%= tt.getTutorSns() %>">
					
		      	</div>
		      	<br>
		      	<!-- use a tag for links to other locations -->
		      	<input type="submit" class="button button-rounded-hover" value="자기소개 수정"><br>
		    </div> <!-- /.card-profile-stats-more-content -->
		  </div> <!-- /.card-profile-stats-more -->
		</div> <!-- /.card-profile-stats -->
		<br>
			<a href="<%=request.getContextPath() %>/myInfo.me" class="button button-rounded-hover">My Page로 이동</a>
		
		</div>
			</form>
		
	</div>

<!-- 왼쪽 박스 클릭 js -->
<script>
	// 화살표 클릭
	$('.card-profile-stats-more-link').click(function(e){
	  e.preventDefault();
	  if ( $(".card-profile-stats-more-content").is(':hidden') ) {
	    $('.card-profile-stats-more-link').find('i').removeClass('fa-angle-down').addClass('fa-angle-up');
	  } else {
	    $('.card-profile-stats-more-link').find('i').removeClass('fa-angle-up').addClass('fa-angle-down');
	  }
	  $(this).next('.card-profile-stats-more-content').slideToggle();
	});
	
	// 프로필 사진 첨부
	$(function(){
		$('#fileArea').hide();
		
		$('#target_img').click(function(){
			$('#profileImg').click();
		});
	});
	
	function LoadImg(value, num){
		if(value.files && value.files[0]){
				var reader = new FileReader();
						
					reader.onload = function(e){								
						if(num){
							$("#target_img").attr("src", e.target.result);
						} else{
						
						}
						}
					
						reader.readAsDataURL(value.files[0]);
					}
				}
	
	// 자기소개 수정

     
	
	
</script>


</body>
</html>