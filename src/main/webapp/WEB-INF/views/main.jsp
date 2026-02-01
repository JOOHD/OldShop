<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Welcome BookMall</title>

  <link rel="stylesheet" href="resources/css/main.css" />
  <link rel="stylesheet" href="resources/css/include/header.css" />
  <link rel="stylesheet" href="resources/css/include/footer.css" />

  <script
    src="https://code.jquery.com/jquery-3.4.1.js"
    integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
    crossorigin="anonymous"></script>
</head>

<body>
  <a class="skip-link" href="#content">본문 바로가기</a>

  <div class="app">

    <!-- ✅ 공통 헤더 include -->
    <jsp:include page="/WEB-INF/views/include/header.jsp" />

    <!-- Main -->
    <main id="content" class="main">
      <div class="container">
        <section class="hero">
          <h1 class="hero__title">오늘의 추천 도서</h1>
          <p class="hero__desc">베스트셀러 / 신간 / 할인 도서를 빠르게 찾아보세요.</p>
        </section>

        <section class="content">
          <h2 class="content__title">content area</h2>
        </section>
      </div>
    </main>

    <!-- Footer -->
    <jsp:include page="/WEB-INF/views/include/footer.jsp" />
  </div>

  <script>
    $("#gnb_logout_button").on("click", function () {
      $.ajax({
        type: "GET",
        url: "/member/logout.do",
        success: function () {
          alert("로그아웃 성공");
          location.reload();
        }
      });
    });
  </script>
</body>
</html>
