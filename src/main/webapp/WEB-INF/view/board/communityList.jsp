<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>소통공간 - GAEnt.</title>
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/assets/img/favicon/favicon.ico" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/workspace.css"/>
    <style>
      .board-list-area {
        height: 84vh;
      }
    
      .board-body {
        height: 100%;
      }
      
      .board-num .board-category .board-file {
        width: 1rem;
      }
      
      .board-title {
      }
      
      .board-writer .board-date {
        width: 4rem;
      }
    </style>
  </head>
  <body>
    <div id="">
      <div id="header-area">
        <jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>
      </div>
      <div id="sidebar-area">
        <jsp:include page="/WEB-INF/view/common/sidebar.jsp"></jsp:include>
        <jsp:include page="/WEB-INF/view/board/board-sub-sidebar.jsp"></jsp:include>
      </div>
      <div id="workspace-area" class="subsidebar-from-workspace">
        <div class="board-list-area">
          <div class="mb-4">
            <span class="display-6 fw-semibold">자유게시판</span>
          </div>
          <div class="community-list">
            <!-- 일자 순 5개만 보이는 자유게시판 리스트 -->
            <div class="card p-2 board-body">
              <div class="table-responsive text-nowrap d-flex flex-column align-items-center">
                <table class="table table-hover text-center">
                  <thead>
                    <tr>
                      <th class="board-num">번호</th>
                      <th class="board-title">제목</th>
                      <th class="board-writer">작성자</th>
                      <th class="board-file">파일</th>
                      <th class="board-date">작성일</th>
                    </tr>
                  </thead>
                  <tbody class="table-border-bottom-0">
                    <c:forEach var="c" items="${communityList}">
                      <tr onclick="location.href='/gaent/board/community/boardDetail?boardNum=${c.commNum}'">
                        <td><span class="fw-medium">${c.commNum}</span></td>
                        <td class="text-start"><span class="fw-medium">${c.commTitle}</span></td>
                        <td><span class="fw-medium">${c.commWriter}</span></td>
                        <c:choose>
                          <c:when test="${c.commFileName == null}">
                            <td><span class="fw-medium"><i class="tf-icon bx bx-file-blank"></i></span></td>
                          </c:when>
                          <c:otherwise>
                            <td><span class="fw-medium"><i class="tf-icon bx bx-file"></i></span></td>
                          </c:otherwise>
                        </c:choose>
                        <td><span class="fw-medium">${c.commCreateDate}</span></td>
                      </tr>
                    </c:forEach>
                  </tbody>
                </table>
                <!-- 페이징시작 -->
                <div class="mt-4">
                  <jsp:include page="/WEB-INF/view/board/board-paging.jsp"></jsp:include>
                </div>
                <!-- 페이징끝 -->
              </div>
            </div>
            <!-- 일자 순 5개만 보이는 자유게시판 리스트 -->
          </div>
        </div>
      </div>
    </div>
  </body>
</html>
