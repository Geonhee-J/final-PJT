<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <title>전자결재 - GAEnt.</title>
        <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/assets/img/favicon/favicon.ico" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/workspace.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/edoc.css" />
    </head>
    <body>
        <div id="">
            <div id="header-area">
                <jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>
            </div>
            <div id="sidebar-area">
                <jsp:include page="/WEB-INF/view/common/sidebar.jsp"></jsp:include>
                <jsp:include page="/WEB-INF/view/edoc/edoc-sub-sidebar.jsp"></jsp:include>
            </div>
            <div id="workspace-area" class="subsidebar-from-workspace">
                <div>
                    <div class="mb-3">
                        <span class="display-6 fw-semibold mb-0">전자결재 홈</span>
                    </div>
                    <div class="edoc-card-area mb-4">
                        <c:choose>
                            <c:when test="${!empty toDoList}">
                                <jsp:include page="/WEB-INF/view/edoc/approvalCard.jsp"></jsp:include>
                            </c:when>
                            <c:otherwise>
                                <div class="h-100 d-flex align-items-center justify-content-center">
                                    <h5>결재 대기 문서가 없습니다.</h5>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="edoc-list-area">
                        <div class="mb-3">
                            <span class="display-6 fw-semibold mb-0">기안 대기 문서</span>
                        </div>
                        <div class="card my-3 px-4 py-3">
                            <c:choose>
                                <c:when test="${!empty draftList}">
                                    <div class="table-responsive text-nowrap d-flex flex-column align-items-center justify-content-between edoc-home-draft-list">
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
                                                        <c:choose>
                                                            <c:when test="${app.fileName == null}">
                                                                <td><span class="fw-medium d-flex align-items-center"><i class="tf-icon bx bx-file-blank"></i></span></td>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <td><span class="fw-medium d-flex align-items-center"><i class="tf-icon bx bx-file"></i></span></td>
                                                            </c:otherwise>
                                                        </c:choose>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${app.edocStatus == '0'}">
                                                                    <span class="badge bg-label-info me-1">대기중</span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="badge bg-label-warning me-1">진행중</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
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
                                    <div class="table-responsive text-nowrap d-flex flex-column align-items-center justify-content-center edoc-home-draft-list">
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
