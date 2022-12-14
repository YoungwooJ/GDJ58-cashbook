<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 1. C
	// session 유효성 검증 코드 후 필요하다면 redirect!
	if(session.getAttribute("loginMember") != null){
		// 로그인이 된 상태
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta http-equiv="x-ua-compatible" content="ie=edge" />
    <title>inderMemberForm</title>
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.11.2/css/all.css" />
    <!-- Google Fonts Roboto -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" />
    <!-- MDB -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap-5-login-cover-template-main/css/mdb.min.css" />
    <!-- Custom styles -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap-5-login-cover-template-main/css/style.css" />
</head>
<body>
      <!--Main Navigation-->
  <header>
    <style>
      #intro {
        background-image: url(https://mdbootstrap.com/img/new/fluid/city/008.jpg);
        height: 100vh;
      }

      /* Height for devices larger than 576px */
      @media (min-width: 992px) {
        #intro {
          margin-top: -58.59px;
        }
      }

      .navbar .nav-link {
        color: #fff !important;
      }
    </style>

    <!-- Background image -->
    <div id="intro" class="bg-image shadow-2-strong">
      <div class="mask d-flex align-items-center h-100" style="background-color: rgba(0, 0, 0, 0.8);">
        <div class="container">
          <div class="row justify-content-center">
            <div class="col-xl-5 col-md-8">
              <form id="signinForm" class="bg-white rounded shadow-5-strong p-5" action="<%=request.getContextPath()%>/member/insertMemberAction.jsp" method="post">
                <h4 style="float:left;">회원가입</h4><br><br>	
				<!-- msg 파라메타값이 있으면 출력 -->
				<%
					String msg = request.getParameter("msg");
					if(msg != null) {
				%>
						<div class="text-danger"><%=msg%></div>
				<%		
					}
				%>
                <!-- ID input -->
                <div class="form-outline mb-4">
                  <input type="text" name="memberId" id="form1Example1" class="form-control" />
                  <label class="form-label" for="form1Example1">회원 아이디</label>
                </div>

				<!-- Name input -->
                <div class="form-outline mb-4">
                  <input type="text" name="memberName" id="form1Example2" class="form-control" />
                  <label class="form-label" for="form1Example2">회원 닉네임</label>
                </div>

                <!-- Password input -->
                <div class="form-outline mb-4">
                  <input type="password" name="memberPw" id="form1Example3" class="form-control" />
                  <label class="form-label" for="form1Example3">회원 비밀번호</label>
                </div>

                <!-- Submit button -->
                <button id="signinBtn" style="float: right;" class="btn btn-primary" type="button">회원가입</button>
				<div>
				<a style="float: left;" type="button" class="btn btn-primary" href="<%=request.getContextPath()%>/member/loginForm.jsp">이전</a>
				</div>
              </form>
            </div>
          </div>
        </div>
      </div>
    </div>
    <!-- Background image -->
  </header>
	
	<!-- footer include -->
		<div>
			<jsp:include page="/inc/footer.jsp"></jsp:include>
		</div>
	
	<script>
		let signinBtn = document.querySelector('#signinBtn')
		
		signinBtn.addEventListener('click', function(){
			// 디버깅
			console.log('signinBtn click!');
			
			// ID 폼 유효성 검사
			let id = document.querySelector('#form1Example1');
			if(id.value == ''){
				alert('ID를 입력하세요.');
				id.focus();
				return;
			}
			
			// NAME 폼 유효성 검사
			let name = document.querySelector('#form1Example2');
			if(name.value == ''){
				alert('이름을 입력하세요.');
				name.focus();
				return;
			}
			
			// PASSWORD 폼 유효성 검사
			let pw = document.querySelector('#form1Example3');
			if(pw.value == ''){
				alert('비밀번호를 입력하세요.');
				pw.focus();
				return;
			}
			
			let signinForm = document.querySelector('#signiForm')
			signinForm.submit(); // action = "./signAction.jsp";
		});
	</script>
	
    <!-- MDB -->
    <script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap-5-login-cover-template-main/js/mdb.min.js"></script>
    <!-- Custom scripts -->
    <script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap-5-login-cover-template-main/js/script.js"></script>
</body>
</html>