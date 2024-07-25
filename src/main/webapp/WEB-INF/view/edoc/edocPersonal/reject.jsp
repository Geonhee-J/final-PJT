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
</head>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/workspace.css" />
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
            <div class="card" style="height:40rem; overflow-x: hidden; overflow-y: auto;">
                    <h1 class="card-title m-2">
                        <span class="display-6 fw-semibold mb-0">대기 문서함</span>
                    </h1>
                    <div class="card-body table-responsive">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>기안일</th>
                                    <th>결재양식</th>
                                    <th>제목</th>
                                    <th>첨부</th>
                                    <th>문서번호</th>
                                    <th>결재상태</th>
                                </tr>
                            </thead>
                            <tbody class="table-border-bottom-0">
                                <!-- 문서 조회 반복문 영역 -->
                                <c:forEach items="${list}" var="el">
                                    <tr>
                                        <td><span class="fw-medium">${el.edocEnrollDate}</span></td>
                                        <td><span class="fw-medium">${el.edocType}</span></td>
                                        <td><span class="fw-medium">${el.edocTitle}</span></td>
                                        <c:choose>
                                            <c:when test="${el.edocFileName == null}">
                                                <td><span class="fw-medium d-flex align-items-center"><i class="tf-icon bx bx-file-blank"></i></span></td>
                                            </c:when>
                                            <c:otherwise>
                                                <td><span class="fw-medium d-flex align-items-center"><i class="tf-icon bx bx-file"></i></span></td>
                                            </c:otherwise>
                                        </c:choose>
                                        <td><span class="fw-medium">${el.edocNum}</span></td>
                                        <td><span class="fw-medium">${el.edocStatus}</span></td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
