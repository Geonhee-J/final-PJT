<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="en" class="light-style customizer-hide" dir="ltr" data-theme="theme-default" data-assets-path="${pageContext.request.contextPath}/assets/" data-template="vertical-menu-template-free">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0"/>
    <title>로그인 - GAEnt.</title>
    <meta name="description" content="" />
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/assets/img/favicon/favicon.ico"/>
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" />
    <link href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap" rel="stylesheet"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/vendor/fonts/boxicons.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/vendor/css/core.css" class="template-customizer-core-css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/vendor/css/theme-default.css" class="template-customizer-theme-css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/demo.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/vendor/css/pages/page-auth.css"/>
    <script src="${pageContext.request.contextPath}/assets/vendor/js/helpers.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/config.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
  </head>
  <body>
    <div class="container-xxl">
      <div class="authentication-wrapper authentication-basic container-p-y">
        <div class="authentication-inner">
          <div class="card">
            <div class="card-body">
              <div class="app-brand justify-content-center">
                <span class="app-brand-text demo text-body fw-bolder">GA Entertainment</span>
              </div>
              <form id="formAuthentication" class="mb-3" action="login" method="POST">
                <div class="mb-3">
                  <div class="d-flex justify-content-between">
                    <label for="email" class="form-label">Email</label>
                    <a href="findId"><small>아이디 찾기</small></a>
                  </div>
                  <c:choose>
                    <c:when test="${!empty loginInfo}">
                      <input type="text" class="form-control" id="email" name="email" placeholder="이메일을 입력해주세요." value="${loginInfo.empId}" autofocus/>
                    </c:when>
                    <c:otherwise>
                      <input type="text" class="form-control" id="email" name="email" placeholder="이메일을 입력해주세요." value="admin" autofocus/>
                    </c:otherwise>
                  </c:choose>
                </div>
                <div class="mb-3 form-password-toggle">
                  <div class="d-flex justify-content-between">
                    <label class="form-label" for="password">Password</label>
                    <a href="findPw"><small>비밀번호 찾기</small></a>
                  </div>
                  <div class="input-group input-group-merge">
                    <input type="password" id="password" class="form-control" name="password" value="1234" placeholder="&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;" aria-describedby="password"/>
                    <span class="input-group-text cursor-pointer"><i class="bx bx-hide"></i></span>
                  </div>
                </div>
                <div class="mb-3">&nbsp;</div>
                <div class="mb-3">
                  <button class="btn btn-primary d-grid w-100" type="submit">로그인</button>
                </div>
              </form>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div id="checkLoginModal" class="modal fade" role="dialog" tabindex="-1" aria-labelledby="checkLoginModalLabel" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered">
        <!-- Modal content-->
        <div id="message" class="modal-content text-white">
          <div class="modal-header">
            <h4 class="modal-title">${message}</h4>
          </div>
          <div class="modal-body">
            <p>${checkLoginMsg}</p>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
          </div>
        </div>
        <!-- Modal content-->
      </div>
    </div>
    <script src="${pageContext.request.contextPath}/assets/vendor/libs/jquery/jquery.js"></script>
    <script src="${pageContext.request.contextPath}/assets/vendor/libs/popper/popper.js"></script>
    <script src="${pageContext.request.contextPath}/assets/vendor/js/bootstrap.js"></script>
    <script src="${pageContext.request.contextPath}/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>
    <script src="${pageContext.request.contextPath}/assets/vendor/js/menu.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
    <script>
      $(document).ready(function(){
        if(${!empty message}){
          $("#message").attr("class", "modal-content");
          $("#checkLoginModal").modal("show");
        };
      });
    </script>
  </body>
</html>
