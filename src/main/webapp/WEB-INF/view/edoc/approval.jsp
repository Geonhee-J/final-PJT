<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>전자결재 - GAEnt.</title>
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/assets/img/favicon/favicon.ico"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/workspace.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/edoc.css"/>
  </head>
  <body>
    <div id="">
      <div id="header-area">
        <jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>
      </div>
      <div id="sidebar_area">
        <jsp:include page="/WEB-INF/view/common/sidebar.jsp"></jsp:include>
        <jsp:include page="/WEB-INF/view/edoc/edoc-sub-sidebar.jsp"></jsp:include>
      </div>
      <div id="workspace-area" class="subsidebar-from-workspace">
        <div>
          <div class="mb-3">
            <span class="display-6 fw-semibold mb-0">전자결재 홈</span>
          </div>
          <div class="edoc-card-area mb-4">
            <jsp:include page="/WEB-INF/view/edoc/approvalCard.jsp"></jsp:include>
          </div>
          <div class="edoc-list-area">
            <div class="card mb-3 px-4 py-2">
              <h5 class="card-header-edoc">기안 대기 문서</h5>
              <c:choose>
                <c:when test="${!empty draftList}">
                  <div class="table-responsive home-draft-list text-nowrap d-flex flex-column align-items-center justify-content-between">
                    <table class="table table-hover">
                      <thead>
                        <tr>
                          <th>기안일</th>
                          <th>결재양식</th>
                          <th>제목</th>
                          <th>첨부</th>
                          <th>결재상태</th>
                        </tr>
                      </thead>
                      <!-- 문서 조회 반복문 영역 -->
                      <tbody class="table-border-bottom-0">
                        <c:forEach var="app" items="${draftList}">
                          <tr onclick="location.href='/gaent/edocDetail/${app.edocType}/${app.edocNum}'">
                            <td><span class="fw-medium">${app.edocEnrollDate}</span></td>
                            <td><span class="fw-medium">${app.edocTypeName}</span></td>
                            <td><span class="fw-medium">${app.edocTitle}</span></td>
                            <td><span class="fw-medium">${app.edocFileName}</span></td>
                            <td><span class="badge bg-label-primary me-1">${app.edocStatus}</span></td>
                          </tr>
                        </c:forEach>
                      </tbody>
                    </table>
                    <!-- 페이징 시작 -->
                    <div class="mt-4">
                      <jsp:include page="/WEB-INF/view/edoc/edoc-paging.jsp"></jsp:include>
                    </div>
                    <!-- 페이징 종료 -->
                  </div>
                </c:when>
                <c:otherwise>
                  <div class="table-responsive home-draft-list text-nowrap d-flex flex-column align-items-center justify-content-center">
                    <h5>내 대기 문서가 없습니다.</h5>
                  </div>
                </c:otherwise>
              </c:choose>
            </div>
          </div>
        </div>
      </div>
    </div>
  </body>
</html>
