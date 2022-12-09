<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.net.URLEncoder" %>
<%
	// 1. Controller
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/member/loginForm.jsp");
		return;
	}

	request.setCharacterEncoding("UTF-8");
	String msg = null;
	int memberNo = 0;
	
	// 방어코드
	if(request.getParameter("memberNo")== null || request.getParameter("memberNo").equals("")){
		msg = URLEncoder.encode("오류입니다.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/admin/member/memberList?msg="+msg);
		return;
	} else {
		memberNo = Integer.parseInt(request.getParameter("memberNo"));
	}
	
	Member paramMember = new Member();
	paramMember.setMemberNo(memberNo);
	
	// 디버깅 코드
	System.out.println(memberNo);
	
	// 2. Model 호출
	MemberDao memberDao = new MemberDao();
	Member member = new Member();
	member = memberDao.selectMember(paramMember);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<meta name="description" content="Responsive Admin &amp; Dashboard Template based on Bootstrap 5">
	<meta name="author" content="AdminKit">
	<meta name="keywords" content="adminkit, bootstrap, bootstrap 5, admin, dashboard, template, responsive, css, sass, html, theme, front-end, ui kit, web">

	<link rel="preconnect" href="https://fonts.gstatic.com">
	<link rel="shortcut icon" href="<%=request.getContextPath()%>/adminkit-dev/static/img/icons/icon-48x48.png" />

	<link rel="canonical" href="https://demo-basic.adminkit.io/" />
	
	<title>updateMemberForm</title>
	
	<link href="<%=request.getContextPath()%>/adminkit-dev/static/css/app.css" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
	<style>
		/*
		body {
			padding:1.5em;
			background: #f5f5f5;
		}
		*/
		/*
		table {
			border: 1px #BDBDBD solid;
			font-size: .9em;
			box-shadow: 0 2px 5px #BDBDBD;
			width: 100%;
			border-collapse: collapse;
			border-radius: 20px;
			overflow: hidden;
		}
		*/
		/*
		#datepicker{
			table-layout:fixed;
			width: 1000px;
		}
		*/
		#dateblock{
			width: 150px;
    		height: 150px;
		}
		#dateblock:hover{
			background-color: #EAEAEA;
			border-radius: 5px;
		}
		a {
			text-decoration: none;
			color: black;
		}
		a:hover{
			text-decoration: none;
			color: black;
		}
	</style>
</head>
<body>
	<div class="wrapper">
		<nav id="sidebar" class="sidebar js-sidebar">
			<div class="sidebar-content js-simplebar">
				<a class="sidebar-brand" href="<%=request.getContextPath()%>/cash/cashList.jsp">
          <span class="align-middle">가계부</span>
        </a>

				<ul class="sidebar-nav">
					<li class="sidebar-header">
						메뉴
					</li>

					<li class="sidebar-item">
						<a class="sidebar-link" href="<%=request.getContextPath()%>/cash/cashList.jsp">
              <i class="align-middle" data-feather="calendar"></i> <span class="align-middle">가계부</span>
            </a>
					</li>

					<li class="sidebar-item">
						<a class="sidebar-link" href="<%=request.getContextPath()%>/member/memberOne.jsp?loginMemberId=<%=loginMember.getMemberId()%>">
              <i class="align-middle" data-feather="user"></i> <span class="align-middle">내정보</span>
            </a>
					</li>
					
            		<li class="sidebar-item">
						<a class="sidebar-link" href="<%=request.getContextPath()%>/member/logout.jsp">
              <i class="align-middle" data-feather="log-out"></i> <span class="align-middle">로그아웃</span>
            </a>
					</li>				
					
					<li class="sidebar-item">
						<a class="sidebar-link" href="https://github.com/YoungwooJ/GDJ58-cashbook">
              <i class="align-middle" data-feather="github"></i> <span class="align-middle">깃허브</span>
            </a>
					</li>
					
					<li class="sidebar-item">
						<a class="sidebar-link" href="<%=request.getContextPath()%>/help/helpList.jsp">
              <i class="align-middle" data-feather="help-circle"></i> <span class="align-middle">고객센터</span>
            </a>
					</li>

					<li class="sidebar-header">
						관리자 기능
					</li>
					
					<li class="sidebar-item">
						<a class="sidebar-link" href="<%=request.getContextPath()%>/admin/adminMain.jsp">
              <i class="align-middle" data-feather="home"></i> <span class="align-middle">관리자 홈</span>
            </a>
					</li>
            		
					<li class="sidebar-item">
						<a class="sidebar-link" href="<%=request.getContextPath()%>/admin/notice/noticeList.jsp">
              <i class="align-middle" data-feather="layout"></i> <span class="align-middle">공지사항관리</span>
            </a>
					</li>

					<li class="sidebar-item">
						<a class="sidebar-link" href="<%=request.getContextPath()%>/admin/comment/commentList.jsp">
              <i class="align-middle" data-feather="headphones"></i> <span class="align-middle">고객센터관리</span>
            </a>
					</li>

					<li class="sidebar-item">
						<a class="sidebar-link" href="<%=request.getContextPath()%>/admin/category/categoryList.jsp">
              <i class="align-middle" data-feather="list"></i> <span class="align-middle">카테고리관리</span>
            </a>
					</li>		
					
					<li class="sidebar-item active">
						<a class="sidebar-link" href="<%=request.getContextPath()%>/admin/member/memberList.jsp">
              <i class="align-middle" data-feather="user-check"></i> <span class="align-middle">멤버관리</span>
            </a>
					</li>

				</ul>
			</div>
		</nav>

		<div class="main">
			<nav class="navbar navbar-expand navbar-light navbar-bg">
				<a class="sidebar-toggle js-sidebar-toggle">
          <i class="hamburger align-self-center"></i>
        </a>

				<div class="navbar-collapse collapse">
					<ul class="navbar-nav navbar-align">
						<li class="nav-item dropdown">
							<a class="nav-icon dropdown-toggle" href="#" id="alertsDropdown" data-bs-toggle="dropdown">
								<div class="position-relative">
									<i class="align-middle" data-feather="bell"></i>
									<span class="indicator">4</span>
								</div>
							</a>
							<div class="dropdown-menu dropdown-menu-lg dropdown-menu-end py-0" aria-labelledby="alertsDropdown">
								<div class="dropdown-menu-header">
									4개의 새 알림이 있습니다.
								</div>
								<div class="list-group">
									<a href="#" class="list-group-item">
										<div class="row g-0 align-items-center">
											<div class="col-2">
												<i class="text-danger" data-feather="alert-circle"></i>
											</div>
											<div class="col-10">
												<div class="text-dark">업데이트 완료</div>
												<div class="text-muted small mt-1">업데이트를 완료하려면 시스템을 다시 시작해야 합니다.</div>
												<div class="text-muted small mt-1">30분 전</div>
											</div>
										</div>
									</a>
									<a href="#" class="list-group-item">
										<div class="row g-0 align-items-center">
											<div class="col-2">
												<i class="text-warning" data-feather="bell"></i>
											</div>
											<div class="col-10">
												<div class="text-dark">새로운 알림</div>
												<div class="text-muted small mt-1">가계부에 새로운 내역을 추가해보세요.</div>
												<div class="text-muted small mt-1">2시간 전</div>
											</div>
										</div>
									</a>
									<a href="#" class="list-group-item">
										<div class="row g-0 align-items-center">
											<div class="col-2">
												<i class="text-primary" data-feather="home"></i>
											</div>
											<div class="col-10">
												<div class="text-dark">새로운 IP에서 로그인 되었습니다.</div>
												<div class="text-muted small mt-1">5시간 전</div>
											</div>
										</div>
									</a>
									<a href="#" class="list-group-item">
										<div class="row g-0 align-items-center">
											<div class="col-2">
												<i class="text-success" data-feather="user-plus"></i>
											</div>
											<div class="col-10">
												<div class="text-dark">새로운 친구</div>
												<div class="text-muted small mt-1">크리스티나가 당신의 요청을 수락했습니다.</div>
												<div class="text-muted small mt-1">14시간 전</div>
											</div>
										</div>
									</a>
								</div>
								<div class="dropdown-menu-footer">
									<a href="#" class="text-muted">모든 알림 보기</a>
								</div>
							</div>
						</li>
						<li class="nav-item dropdown">
							<a class="nav-icon dropdown-toggle" href="#" id="messagesDropdown" data-bs-toggle="dropdown">
								<div class="position-relative">
									<i class="align-middle" data-feather="message-square"></i>
								</div>
							</a>
							<div class="dropdown-menu dropdown-menu-lg dropdown-menu-end py-0" aria-labelledby="messagesDropdown">
								<div class="dropdown-menu-header">
									<div class="position-relative">
										4개의 새 메시지가 있습니다.
									</div>
								</div>
								<div class="list-group">
									<a href="#" class="list-group-item">
										<div class="row g-0 align-items-center">
											<div class="col-2">
												<img src="../adminkit-dev/static/img/avatars/avatar-5.jpg" class="avatar img-fluid rounded-circle" alt="Vanessa Tucker">
											</div>
											<div class="col-10 ps-2">
												<div class="text-dark">Vanessa Tucker</div>
												<div class="text-muted small mt-1">밥 먹었어?</div>
												<div class="text-muted small mt-1">15분 전</div>
											</div>
										</div>
									</a>
									<a href="#" class="list-group-item">
										<div class="row g-0 align-items-center">
											<div class="col-2">
												<img src="../adminkit-dev/static/img/avatars/avatar-2.jpg" class="avatar img-fluid rounded-circle" alt="William Harris">
											</div>
											<div class="col-10 ps-2">
												<div class="text-dark">William Harris</div>
												<div class="text-muted small mt-1">다음 주에 뵙겠습니다.</div>
												<div class="text-muted small mt-1">2시간 전</div>
											</div>
										</div>
									</a>
									<a href="#" class="list-group-item">
										<div class="row g-0 align-items-center">
											<div class="col-2">
												<img src="../adminkit-dev/static/img/avatars/avatar-4.jpg" class="avatar img-fluid rounded-circle" alt="Christina Mason">
											</div>
											<div class="col-10 ps-2">
												<div class="text-dark">Christina Mason</div>
												<div class="text-muted small mt-1">감사합니다.</div>
												<div class="text-muted small mt-1">4시간 전</div>
											</div>
										</div>
									</a>
									<a href="#" class="list-group-item">
										<div class="row g-0 align-items-center">
											<div class="col-2">
												<img src="../adminkit-dev/static/img/avatars/avatar-3.jpg" class="avatar img-fluid rounded-circle" alt="Sharon Lessman">
											</div>
											<div class="col-10 ps-2">
												<div class="text-dark">Sharon Lessman</div>
												<div class="text-muted small mt-1">오늘 하루도 화이팅이에요.</div>
												<div class="text-muted small mt-1">5시간 전</div>
											</div>
										</div>
									</a>
								</div>
								<div class="dropdown-menu-footer">
									<a href="#" class="text-muted">모든 메시지 보기</a>
								</div>
							</div>
						</li>
						<li class="nav-item dropdown">
							<a class="nav-icon dropdown-toggle d-inline-block d-sm-none" href="#" data-bs-toggle="dropdown">
                <i class="align-middle" data-feather="settings"></i>
              </a>

							<a class="nav-link dropdown-toggle d-none d-sm-inline-block" href="#" data-bs-toggle="dropdown">
                <img src="<%=request.getContextPath()%>/adminkit-dev/static/img/avatars/avatar.jpg" class="avatar img-fluid rounded me-1" alt="Charles Hall" /> <span class="text-dark"><%=loginMember.getMemberName()%></span>
              </a>
							<div class="dropdown-menu dropdown-menu-end">
								<a class="dropdown-item" href="<%=request.getContextPath()%>/member/memberOne.jsp?loginMemberId=<%=loginMember.getMemberId()%>"><i class="align-middle me-1" data-feather="user"></i> 프로필</a>
								<a class="dropdown-item" href="<%=request.getContextPath()%>/cash/cashList.jsp"><i class="align-middle me-1" data-feather="calendar"></i> 가계부</a>
								<div class="dropdown-divider"></div>
								<a class="dropdown-item" href="<%=request.getContextPath()%>/help/helpList.jsp"><i class="align-middle me-1" data-feather="settings"></i> 설정</a>
								<a class="dropdown-item" href="<%=request.getContextPath()%>/help/helpList.jsp"><i class="align-middle me-1" data-feather="help-circle"></i> 고객센터</a>
								<div class="dropdown-divider"></div>
								<a class="dropdown-item" href="<%=request.getContextPath()%>/member/logout.jsp"><i class="align-middle me-1" data-feather="log-out"></i>로그아웃</a>
							</div>
						</li>
					</ul>
				</div>
			</nav>

			<main class="content">
				<div class="container-fluid p-0">

					<h1 class="h3 mb-3"><strong>멤버 관리</strong></h1>
					<!-- 
					<div class="row">
						<div class="col-xl-6 col-xxl-5 d-flex">
							<div class="w-100">
								<div class="row">
									<div class="col-sm-6">
										<div class="card">
											<div class="card-body">
												<div class="row">
													<div class="col mt-0">
														<h5 class="card-title">Sales</h5>
													</div>

													<div class="col-auto">
														<div class="stat text-primary">
															<i class="align-middle" data-feather="truck"></i>
														</div>
													</div>
												</div>
												<h1 class="mt-1 mb-3">2.382</h1>
												<div class="mb-0">
													<span class="text-danger"> <i class="mdi mdi-arrow-bottom-right"></i> -3.65% </span>
													<span class="text-muted">Since last week</span>
												</div>
											</div>
										</div>
										<div class="card">
											<div class="card-body">
												<div class="row">
													<div class="col mt-0">
														<h5 class="card-title">Visitors</h5>
													</div>

													<div class="col-auto">
														<div class="stat text-primary">
															<i class="align-middle" data-feather="users"></i>
														</div>
													</div>
												</div>
												<h1 class="mt-1 mb-3">14.212</h1>
												<div class="mb-0">
													<span class="text-success"> <i class="mdi mdi-arrow-bottom-right"></i> 5.25% </span>
													<span class="text-muted">Since last week</span>
												</div>
											</div>
										</div>
									</div>
									<div class="col-sm-6">
										<div class="card">
											<div class="card-body">
												<div class="row">
													<div class="col mt-0">
														<h5 class="card-title">Earnings</h5>
													</div>

													<div class="col-auto">
														<div class="stat text-primary">
															<i class="align-middle" data-feather="dollar-sign"></i>
														</div>
													</div>
												</div>
												<h1 class="mt-1 mb-3">$21.300</h1>
												<div class="mb-0">
													<span class="text-success"> <i class="mdi mdi-arrow-bottom-right"></i> 6.65% </span>
													<span class="text-muted">Since last week</span>
												</div>
											</div>
										</div>
										<div class="card">
											<div class="card-body">
												<div class="row">
													<div class="col mt-0">
														<h5 class="card-title">Orders</h5>
													</div>

													<div class="col-auto">
														<div class="stat text-primary">
															<i class="align-middle" data-feather="shopping-cart"></i>
														</div>
													</div>
												</div>
												<h1 class="mt-1 mb-3">64</h1>
												<div class="mb-0">
													<span class="text-danger"> <i class="mdi mdi-arrow-bottom-right"></i> -2.25% </span>
													<span class="text-muted">Since last week</span>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>

						<div class="col-xl-6 col-xxl-7">
							<div class="card flex-fill w-100">
								<div class="card-header">

									<h5 class="card-title mb-0">Recent Movement</h5>
								</div>
								<div class="card-body py-3">
									<div class="chart chart-sm">
										<canvas id="chartjs-dashboard-line"></canvas>
									</div>
								</div>
							</div>
						</div>
					</div>
					-->
					<!--  -->
					<div class="row">
						<!-- 
						<div class="col-12 col-md-6 col-xxl-3 d-flex order-2 order-xxl-3">
							<div class="card flex-fill w-100">
								<div class="card-header">

									<h5 class="card-title mb-0">최근 멤버</h5>
								</div>
								<div class="card-body d-flex">
									<div class="align-self-center w-100">
										
										<div class="py-3">
											<div class="chart chart-xs">
												<canvas id="chartjs-dashboard-pie"></canvas>
											</div>
										</div>

										<table class="table mb-0">
											<tbody>
												<tr>
													<td>Chrome</td>
													<td class="text-end">4306</td>
												</tr>
												<tr>
													<td>Firefox</td>
													<td class="text-end">3801</td>
												</tr>
												<tr>
													<td>IE</td>
													<td class="text-end">1689</td>
												</tr>
											</tbody>
										</table>
										 
									</div>
								</div>
							</div>
						</div>
						 -->
						<!-- 
						<div class="col-12 col-md-12 col-xxl-6 d-flex order-3 order-xxl-2">
							<div class="card flex-fill w-100">
								<div class="card-header">

									<h5 class="card-title mb-0">Real-Time</h5>
								</div>
								<div class="card-body px-4">
									<div id="world_map" style="height:350px;"></div>
								</div>
							</div>
						</div>
						-->
						<div class="col-12 col-md-6 col-xxl-3 d-flex order-2 order-xxl-3">
							<div class="card flex-fill w-100">
								<div class="card-header">
		
									<h5 class="card-title mb-0">월 매출</h5>
								</div>
								<div class="card-body d-flex w-100">
									<div class="align-self-center chart chart-lg">
										<canvas id="chartjs-dashboard-bar"></canvas>
									</div>
								</div>
							</div>
						</div>
						<!-- col-12 col-lg-8 col-xxl-9 d-flex -->
						<div class="col-12 col-lg-8 col-xxl-9 d-flex order-3 order-xxl-2">
							<div class="card flex-fill">
								<div class="card-header">

									<h5 class="card-title mb-0">레벨 수정</h5>
								</div>
								<div class="card-body d-flex text-center">
									<div class="align-self-center w-100">
										<div class="chart">
											<!--<div id="datetimepicker-dashboard"></div>-->
											<!-- msg 파라메타값이 있으면 출력 -->
											<%
												msg = request.getParameter("msg");
												if(request.getParameter("msg") != null) {
											%>
													<div class="text-danger"><%=msg%></div>
											<%		
												}
											%>
											<!-- 비밀번호 확인 -->
											<form action="<%=request.getContextPath()%>/admin/member/updateMemberAction.jsp?memberNo=<%=memberNo%>" method="post">
											<input type="hidden" name="memberNo" value="<%=memberNo%>">
											<table class="table table-border">
												<tr>
													<th>회원 번호</th>
													<td>
														<input type="number" name="memberNo" value="<%=member.getMemberNo()%>" readonly="readonly">
													</td>
												</tr>
												<tr>	
													<th>회원 ID</th>
													<td>
														<input type="text" name="memberId" value="<%=member.getMemberId()%>" readonly="readonly">
													</td>
												</tr>
												<tr>
													<th>회원 닉네임</th>
													<td>
														<input type="text" name="memberName" value="<%=member.getMemberName()%>" readonly="readonly">
													</td>
												</tr>
												<tr>	
													<th>생성일자</th>
													<td>
														<input type="text" name="createdate" value="<%=member.getCreatedate()%>" readonly="readonly">
													</td>
												</tr>
												<tr>
													<th>수정일자</th>
													<td>
														<input type="text" name="updatedate" value="<%=member.getUpdatedate()%>" readonly="readonly">
													</td>
												</tr>
												<tr>	
													<th>회원 레벨</th>
													<td>
														<select name="memberLevel">
															<!-- option 선택지 -->
															<%
																if((Integer)(member.getMemberLevel()) == 1){
															%>
																	<option value="<%=1%>">
																	관리자
																	</option>
															<%
																} else {
															%>
																	<option value="<%=0%>">
																	일반회원
																	</option>
															<%
																}
															%>
															<%
																if((Integer)(member.getMemberLevel()) != 1){
															%>
																	<option value="<%=1%>">
																	관리자
																	</option>
															<%
																} else {
															%>
																	<option value="<%=0%>">
																	일반회원
																	</option>
															<%
																}
															%>
														</select>
													</td>
												</tr>
											</table>
											<a style="float:left;" class="btn btn-primary" href="<%=request.getContextPath()%>/admin/member/memberList.jsp">이전</a>
											<button style="float:right;" class="btn btn-warning" type="submit">수정</button>
											</form>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>

					<div class="row">
						<!-- 
						<div class="col-12 col-lg-8 col-xxl-9 d-flex">
							<div class="card flex-fill">
								<div class="card-header">

									<h5 class="card-title mb-0">최근 공지사항</h5>
								</div>
								<table class="table table-hover my-0">
									
								</table>
							</div>
						</div>
						 -->
						
					</div>

				</div>
			</main>
			
			<!-- footer include -->
			<div>
				<jsp:include page="/inc/footer.jsp"></jsp:include>
			</div>
		</div>
	</div>

	<script src="<%=request.getContextPath()%>/adminkit-dev/static/js/app.js"></script>

	<script>
		document.addEventListener("DOMContentLoaded", function() {
			var ctx = document.getElementById("chartjs-dashboard-line").getContext("2d");
			var gradient = ctx.createLinearGradient(0, 0, 0, 225);
			gradient.addColorStop(0, "rgba(215, 227, 244, 1)");
			gradient.addColorStop(1, "rgba(215, 227, 244, 0)");
			// Line chart
			new Chart(document.getElementById("chartjs-dashboard-line"), {
				type: "line",
				data: {
					labels: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"],
					datasets: [{
						label: "Sales ($)",
						fill: true,
						backgroundColor: gradient,
						borderColor: window.theme.primary,
						data: [
							2115,
							1562,
							1584,
							1892,
							1587,
							1923,
							2566,
							2448,
							2805,
							3438,
							2917,
							3327
						]
					}]
				},
				options: {
					maintainAspectRatio: false,
					legend: {
						display: false
					},
					tooltips: {
						intersect: false
					},
					hover: {
						intersect: true
					},
					plugins: {
						filler: {
							propagate: false
						}
					},
					scales: {
						xAxes: [{
							reverse: true,
							gridLines: {
								color: "rgba(0,0,0,0.0)"
							}
						}],
						yAxes: [{
							ticks: {
								stepSize: 1000
							},
							display: true,
							borderDash: [3, 3],
							gridLines: {
								color: "rgba(0,0,0,0.0)"
							}
						}]
					}
				}
			});
		});
	</script>
	<script>
		document.addEventListener("DOMContentLoaded", function() {
			// Pie chart
			new Chart(document.getElementById("chartjs-dashboard-pie"), {
				type: "pie",
				data: {
					labels: ["Chrome", "Firefox", "IE"],
					datasets: [{
						data: [4306, 3801, 1689],
						backgroundColor: [
							window.theme.primary,
							window.theme.warning,
							window.theme.danger
						],
						borderWidth: 5
					}]
				},
				options: {
					responsive: !window.MSInputMethodContext,
					maintainAspectRatio: false,
					legend: {
						display: false
					},
					cutoutPercentage: 75
				}
			});
		});
	</script>
	<script>
		document.addEventListener("DOMContentLoaded", function() {
			// Bar chart
			new Chart(document.getElementById("chartjs-dashboard-bar"), {
				type: "bar",
				data: {
					labels: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"],
					datasets: [{
						label: "This year",
						backgroundColor: window.theme.primary,
						borderColor: window.theme.primary,
						hoverBackgroundColor: window.theme.primary,
						hoverBorderColor: window.theme.primary,
						data: [54, 67, 41, 55, 62, 45, 55, 73, 60, 76, 48, 79],
						barPercentage: .75,
						categoryPercentage: .5
					}]
				},
				options: {
					maintainAspectRatio: false,
					legend: {
						display: false
					},
					scales: {
						yAxes: [{
							gridLines: {
								display: false
							},
							stacked: false,
							ticks: {
								stepSize: 20
							}
						}],
						xAxes: [{
							stacked: false,
							gridLines: {
								color: "transparent"
							}
						}]
					}
				}
			});
		});
	</script>
	<script>
		document.addEventListener("DOMContentLoaded", function() {
			var markers = [{
					coords: [31.230391, 121.473701],
					name: "Shanghai"
				},
				{
					coords: [28.704060, 77.102493],
					name: "Delhi"
				},
				{
					coords: [6.524379, 3.379206],
					name: "Lagos"
				},
				{
					coords: [35.689487, 139.691711],
					name: "Tokyo"
				},
				{
					coords: [23.129110, 113.264381],
					name: "Guangzhou"
				},
				{
					coords: [40.7127837, -74.0059413],
					name: "New York"
				},
				{
					coords: [34.052235, -118.243683],
					name: "Los Angeles"
				},
				{
					coords: [41.878113, -87.629799],
					name: "Chicago"
				},
				{
					coords: [51.507351, -0.127758],
					name: "London"
				},
				{
					coords: [40.416775, -3.703790],
					name: "Madrid "
				}
			];
			var map = new jsVectorMap({
				map: "world",
				selector: "#world_map",
				zoomButtons: true,
				markers: markers,
				markerStyle: {
					initial: {
						r: 9,
						strokeWidth: 7,
						stokeOpacity: .4,
						fill: window.theme.primary
					},
					hover: {
						fill: window.theme.primary,
						stroke: window.theme.primary
					}
				},
				zoomOnScroll: false
			});
			window.addEventListener("resize", () => {
				map.updateSize();
			});
		});
	</script>
	<script>
		document.addEventListener("DOMContentLoaded", function() {
			var date = new Date(Date.now() - 5 * 24 * 60 * 60 * 1000);
			var defaultDate = date.getUTCFullYear() + "-" + (date.getUTCMonth() + 1) + "-" + date.getUTCDate();
			document.getElementById("datetimepicker-dashboard").flatpickr({
				inline: true,
				prevArrow: "<span title=\"Previous month\">&laquo;</span>",
				nextArrow: "<span title=\"Next month\">&raquo;</span>",
				defaultDate: defaultDate
			});
		});
	</script>	
</body>
</html>