<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<%	
	// 1. C
	// 로그인이 되어 있을 때는 접근 불가
	if(session.getAttribute("loginMember") != null){
		// 로그인이 된 상태
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		return;
	}

	// 알림 메시지
	String msg = null;
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta http-equiv="x-ua-compatible" content="ie=edge" />
    <title>loginForm</title>
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
              <form id="loginForm" class="bg-white rounded shadow-5-strong p-5" action="<%=request.getContextPath()%>/member/loginAction.jsp" method="post">
                <h4 style="float:left;">로그인</h4><br><br>	
                <!-- msg 파라메타값이 있으면 출력 -->
				<%
					msg = request.getParameter("msg");
					if(msg != null) {
				%>
						<div class="text-danger"><%=msg%></div>
				<%		
					}
				%>
                <!-- ID input -->
                <div class="form-outline mb-4">
                  <input type="text" name="memberId" id="form1Example1" class="form-control" />
                  <label class="form-label" for="form1Example1">아이디</label>
                </div>

                <!-- Password input -->
                <div class="form-outline mb-4">
                  <input type="password" name="memberPw" id="form1Example2" class="form-control" />
                  <label class="form-label" for="form1Example2">비밀번호</label>
                </div>

                <!-- 2 column grid layout for inline styling -->
                <div class="row mb-4">
                  <div class="col d-flex justify-content-center">
                    <!-- Checkbox -->
                    <div class="form-check">
                      <input class="form-check-input" type="checkbox" value="" id="form1Example3" checked />
                      <label class="form-check-label" for="form1Example3">
                        자동 로그인 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      </label>
                    </div>
                  </div>

                  <div class="col text-center">
                    <!-- Simple link -->
                    <a href="#!">아이디와 비밀번호 찾기</a>
                  </div>
                </div>

                <!-- Submit button -->
                <button id="loginBtn" style="float: right;" class="btn btn-primary" type="button">로그인</button>
				<div>
				<!-- id가 없는 경우 회원가입 부터 -->
				<a style="float: left;" type="button" class="btn btn-primary" href="<%=request.getContextPath()%>/member/insertMemberForm.jsp">회원가입</a>
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
		let loginBtn = document.querySelector('#loginBtn')
		
		loginBtn.addEventListener('click', function(){
			// 디버깅
			console.log('loginBtn Click!');
			
			// ID 폼 유효성 검사
			let id = document.querySelector('#form1Example1');
			if(id.value == ''){
				alert('ID를 입력하세요.');
				id.focus();
				return;
			}		
			
			// PASSWORD 폼 유효성 검사
			let pw = document.querySelector('#form1Example2');
			if(pw.value == ''){
				alert('비밀번호를 입력하세요.');
				pw.focus();
				return;
			}
			
			let loginForm = document.querySelector('#loginForm')
			loginForm.submit();
		});
	</script>
	
    <!-- MDB -->
    <script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap-5-login-cover-template-main/js/mdb.min.js"></script>
    <!-- Custom scripts -->
    <script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap-5-login-cover-template-main/js/script.js"></script>
</body>
</html>