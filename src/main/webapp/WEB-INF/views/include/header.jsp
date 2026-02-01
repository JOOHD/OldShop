<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<header class="header">
  <!-- Top bar -->
  <div class="container header__topbar">
    <nav class="topbar" aria-label="상단 메뉴">
      <ul class="topbar__list">
        <c:if test="${member == null}">
          <li class="topbar__item"><a class="topbar__link" href="/member/login">로그인</a></li>
          <li class="topbar__item"><a class="topbar__link" href="/member/join">회원가입</a></li>
        </c:if>

        <c:if test="${member != null}">
          <c:if test="${member.adminCk == 1}">
            <li class="topbar__item"><a class="topbar__link" href="/admin/main">관리자 페이지</a></li>
          </c:if>

          <li class="topbar__item">
            <button type="button" class="topbar__button" id="gnb_logout_button">로그아웃</button>
          </li>

          <li class="topbar__item"><a class="topbar__link" href="/mypage">마이페이지</a></li>
          <li class="topbar__item"><a class="topbar__link" href="/cart/${member.memberId}">장바구니</a></li>
          <li class="topbar__item"><a class="topbar__link" href="/support">고객센터</a></li>
        </c:if>
      </ul>
    </nav>
  </div>

  <!-- Main header row -->
  <div class="container header__main">

    <div class="brand">
      <a class="brand__link" href="/main" aria-label="홈으로">
        <img class="brand__logo" src="<c:url value='/resources/img/mainLogo.png'/>" alt="JooBook" />
      </a>
    </div>

    <div class="search">
      <form class="search__form" id="searchForm" action="/search" method="get">
        <select class="search__select" name="type">
          <option value="T">책 제목</option>
          <option value="A">작가</option>
        </select>

        <input class="search__input"
               type="text"
               name="keyword"
               placeholder="책 제목 / 작가로 검색"
               autocomplete="off" />

        <button class="btn btn--primary search__btn" type="submit">검색</button>
      </form>
    </div>

    <!-- ✅ account 래퍼를 반드시 둬야 CSS가 맞음 -->
    <div class="account">
      <c:if test="${member == null}">
        <a class="btn btn--ghost account__login" href="/member/login">로그인</a>
        <a class="account__join" href="/member/join">회원가입</a>
      </c:if>

      <c:if test="${member != null}">
        <div class="account-card">
          <div class="account-card__title">
            <span class="account-card__name">${member.memberName}</span> 님
          </div>
          <dl class="account-card__meta">
            <div class="account-card__row">
              <dt>충전금액</dt>
              <dd>${member.money}</dd>
            </div>
            <div class="account-card__row">
              <dt>포인트</dt>
              <dd>${member.point}</dd>
            </div>
          </dl>
          <a class="btn btn--soft account-card__logout" href="/member/logout.do">로그아웃</a>
        </div>
      </c:if>
    </div>

  </div>

  <!-- Category nav -->
  <div class="nav">
    <div class="container nav__inner">

      <div class="nav__group">
        <button class="nav__trigger" type="button">국내 ▾</button>
        <div class="nav__menu">
          <c:forEach items="${cate1}" var="cate">
            <a class="nav__item" href="search?type=C&cateCode=${cate.cateCode}">
              ${cate.cateName}
            </a>
          </c:forEach>
        </div>
      </div>

      <div class="nav__group">
        <button class="nav__trigger" type="button">국외 ▾</button>
        <div class="nav__menu">
          <c:forEach items="${cate2}" var="cate">
            <a class="nav__item" href="search?type=C&cateCode=${cate.cateCode}">
              ${cate.cateName}
            </a>
          </c:forEach>
        </div>
      </div>

    </div>
  </div>
</header>
