<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="navbar navbar-expand-lg fixed-top navbar-dark bg-primary">
  <div class="container">
    <a href="../cash/cashList.jsp" class="navbar-brand">Cashbook</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarResponsive">
      <ul class="navbar-nav">
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#" id="themes">Themes</a>
          <div class="dropdown-menu" aria-labelledby="themes">
            <a class="dropdown-item" href="../default/">Default</a>
            <div class="dropdown-divider"></div>
            <a class="dropdown-item" href="../cerulean/">Cerulean</a>
            <a class="dropdown-item" href="../cosmo/">Cosmo</a>
            <a class="dropdown-item" href="../cyborg/">Cyborg</a>
            <a class="dropdown-item" href="../darkly/">Darkly</a>
            <a class="dropdown-item" href="../flatly/">Flatly</a>
            <a class="dropdown-item" href="../journal/">Journal</a>
            <a class="dropdown-item" href="../litera/">Litera</a>
            <a class="dropdown-item" href="../lumen/">Lumen</a>
            <a class="dropdown-item" href="../lux/">Lux</a>
            <a class="dropdown-item" href="../materia/">Materia</a>
            <a class="dropdown-item" href="../minty/">Minty</a>
            <a class="dropdown-item" href="../morph/">Morph</a>
            <a class="dropdown-item" href="../pulse/">Pulse</a>
            <a class="dropdown-item" href="../quartz/">Quartz</a>
            <a class="dropdown-item" href="../sandstone/">Sandstone</a>
            <a class="dropdown-item" href="../simplex/">Simplex</a>
            <a class="dropdown-item" href="../sketchy/">Sketchy</a>
            <a class="dropdown-item" href="../slate/">Slate</a>
            <a class="dropdown-item" href="../solar/">Solar</a>
            <a class="dropdown-item" href="../spacelab/">Spacelab</a>
            <a class="dropdown-item" href="../superhero/">Superhero</a>
            <a class="dropdown-item" href="../united/">United</a>
            <a class="dropdown-item" href="../vapor/">Vapor</a>
            <a class="dropdown-item" href="../yeti/">Yeti</a>
            <a class="dropdown-item" href="../zephyr/">Zephyr</a>
          </div>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="../help/">Help</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="https://blog.bootswatch.com/">Blog</a>
        </li>
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#" id="download">Sandstone</a>
          <div class="dropdown-menu" aria-labelledby="download">
            <a class="dropdown-item" rel="noopener" target="_blank" href="https://jsfiddle.net/bootswatch/tgf9a3L5/">Open in JSFiddle</a>
            <div class="dropdown-divider"></div>
            <a class="dropdown-item" href="../5/sandstone/bootstrap.min.css" download>bootstrap.min.css</a>
            <a class="dropdown-item" href="../5/sandstone/bootstrap.css" download>bootstrap.css</a>
            <div class="dropdown-divider"></div>
            <a class="dropdown-item" href="../5/sandstone/_variables.scss" download>_variables.scss</a>
            <a class="dropdown-item" href="../5/sandstone/_bootswatch.scss" download>_bootswatch.scss</a>
          </div>
        </li>
      </ul>
      <ul class="navbar-nav ms-md-auto">
        <li class="nav-item">
          <a target="_blank" rel="noopener" class="nav-link" href="https://github.com/YoungwooJ/GDJ58-cashbook"><i class="bi bi-github"></i> GitHub</a>
        </li>
      </ul>
    </div>
  </div>
</div>

<br><br>

<ul> <!-- adminMain inc menu 만들기 -->
	<li><a href="<%=request.getContextPath()%>/admin/adminMain.jsp">홈으로</a></li>
	<li><a href="<%=request.getContextPath()%>/admin/notice/noticeList.jsp">공지관리</a></li>
	<li><a href="<%=request.getContextPath()%>/admin/comment/commentList.jsp">고객센터관리</a></li>
	<li><a href="<%=request.getContextPath()%>/admin/category/categoryList.jsp">카테고리관리</a></li>
	<li><a href="<%=request.getContextPath()%>/admin/member/memberList.jsp">멤버관리</a></li>
	<li><a href="<%=request.getContextPath()%>/cash/cashList.jsp">가계부</a></li>
</ul>