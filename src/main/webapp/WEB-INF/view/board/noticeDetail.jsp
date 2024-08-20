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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/board.css"/>
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
        <div class="board-detail-area d-flex flex-column align-items-center justify-content-center">
          <div class="mb-5">
            <span class="display-5 fw-semibold mb-0">공지사항</span>
          </div>
          <c:choose>
            <c:when test="${boardDetail.noticeEmpCode == loginInfo.empCode}">
              <div class="mb-3 w-100 d-flex justify-content-end">
                <button onclick="location.href='/gaent/board/getModifyNotice?boardNum=${boardDetail.noticeNum}'" class="btn btn-sm btn-outline-primary me-2">수정</button>
                <button type="button" class="btn btn-sm btn-outline-danger" data-bs-toggle="modal" data-bs-target="#deleteModal">삭제</button>
                <!-- 삭제 버튼 모달 시작 -->
                <div class="modal fade" id="deleteModal" tabindex="-1" aria-hidden="true" style="display: none;">
                  <div class="modal-dialog modal-sm modal-dialog-centered" role="document">
                    <div class="modal-content">
                      <div class="modal-header">
                        <h5 class="modal-title" id="modalCenterTitle">게시글 삭제</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                      </div>
                      <div class="modal-body">정말 삭제하시겠습니까?</div>
                      <div class="modal-footer">
                        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">취소</button>
                        <a href="/gaent/board/removeNotice?boardNum=${boardDetail.noticeNum}" class="btn btn-outline-danger">삭제</a>
                      </div>
                    </div>
                  </div>
                </div>
                <!-- 삭제 버튼 모달 끝 -->
              </div>
            </c:when>
          </c:choose>
          <div>
            <div class="card board-detail">
              <div class="px-4 pt-4 d-flex align-items-start">
                <label class="me-2">제목 :</label>
                <h3>${boardDetail.noticeTitle}</h3>
              </div>
              <hr>
              <div class="px-4 d-flex justify-content-between">
                <div class="d-flex align-items-center">
                  <label class="me-2">작성자 :</label>
                  <span>${boardDetail.noticeWriter}</span>
                </div>
                <div>
                  <span>${boardDetail.noticeCreateDate}</span>
                </div>
              </div>
              <hr>
              <div class="px-4 py-2">
                <div class="board-content">${boardDetail.noticeContent}</div>
              </div>
              <c:choose>
                <c:when test="${boardDetail.noticeFileName != null}">
                  <div class="px-4 py-2 d-flex flex-column align-items-start">
                    <label for="boardFileName" class="mb-2">첨부파일 :</label>
                    <input class="form-control" type="file" id="boardFileName" name="boardFileName" value="${boardDetail.noticeFileName}">
                  </div>
                </c:when>
                <c:otherwise>
                  <hr>
                  <div class="px-4 py-2">
                    <label for="boardFileName" class="me-2">첨부파일 :</label>
                    <span>첨부파일 없음</span>
                  </div>
                </c:otherwise>
              </c:choose>
            </div>
          </div>
        </div>
      </div>
    </div>
    <!--삭제 메세지 모달 시작 -->
    <div id="deleteMessageModal" class="modal fade" role="dialog" tabindex="-1" aria-labelledby="deleteMessageModal" aria-hidden="true">
      <div class="modal-dialog">
        <div id="message" class="modal-content text-white">
          <div class="modal-header">
            <h4 class="modal-title">${message}</h4>
          </div>
          <div class="modal-body">
            <p>${deleteMessage}</p>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
          </div>
        </div>
      </div>
    </div>
    <!-- 삭제 메세지 모달 끝 -->
    <script>
      $(document).ready(function(){
        if(${!empty message}){
          $("#message").attr("class", "modal-content");
          $("#deleteMessageModal").modal("show");
        };
      });
    </script>
  </body>
</html>
