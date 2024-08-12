<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
            <div id="sidebar-area">
                <jsp:include page="/WEB-INF/view/common/sidebar.jsp"></jsp:include>
                <jsp:include page="/WEB-INF/view/edoc/edoc-sub-sidebar.jsp"></jsp:include>
            </div>
            <div id="workspace-area" class="subsidebar-from-workspace">
                <div class="edoc">
                    <div>
                        <div class="mb-3">
                            <span id="edoc-form-title" class="display-6 fw-semibold mb-0">${edocDetail.edocFormTitle}</span>
                        </div>
                        <div class="d-flex justify-content-between">
                            <!-- 문서정보 -->
                            <div class="edoc-form-info">
                                <div class="table-responsive text-nowrap">
                                    <table class="table table-bordered table-sm edoc-form-info-table">
                                        <tbody>
                                            <tr>
                                                <th class="text-center">기안자</th>
                                                <td class="small"><input name="edocKorName" value="${edocDetail.edocWriter}" readonly /></td>
                                            </tr>
                                            <tr>
                                                <th class="text-center">소속</th>
                                                <td class="small"><input name="edocRankCode" value="${edocDetail.teamName}" readonly /></td>
                                            </tr>
                                            <tr>
                                                <th class="text-center">기안일</th>
                                                <td class="small"><input name="edocDate" value="${edocDetail.edocEnrollDate}" readonly /></td>
                                            </tr>
                                            <tr>
                                                <th class="text-center">문서번호</th>
                                                <td class="small"><input name="edocDate" value="${edocDetail.edocNum}" readonly /></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <!-- 결재선 -->
                            <div class="d-flex">
                                <c:choose>
                                    <c:when test="${edocDetail.approverName1 != null}">
                                        <jsp:include page="/WEB-INF/view/edoc/edoc-form-detail/approverDetail.jsp"></jsp:include>
                                    </c:when>
                                    <c:when test="${edocDetail.approverName2 != null}">
                                        <jsp:include page="/WEB-INF/view/edoc/edoc-form-detail/approverDetail.jsp"></jsp:include>
                                    </c:when>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                    <hr />
                    <div>
                        <!-- 기안서 양식 -->
                        <div id="edoc-form-type">
                            <c:choose>
                                <c:when test="${edocDetail.edocType == 0}">
                                    <jsp:include page="/WEB-INF/view/edoc/edoc-form-detail/draftDetail.jsp"></jsp:include>
                                </c:when>
                                <c:when test="${edocDetail.edocType == 1}">
                                    <jsp:include page="/WEB-INF/view/edoc/edoc-form-detail/vacationDetail.jsp"></jsp:include>
                                </c:when>
                                <c:when test="${edocDetail.edocType == 2}">
                                    <jsp:include page="/WEB-INF/view/edoc/edoc-form-detail/projectDetail.jsp"></jsp:include>
                                </c:when>
                                <c:when test="${edocDetail.edocType == 3}">
                                    <jsp:include page="/WEB-INF/view/edoc/edoc-form-detail/eventDetail.jsp"></jsp:include>
                                </c:when>
                                <c:when test="${edocDetail.edocType == 4}">
                                    <jsp:include page="/WEB-INF/view/edoc/edoc-form-detail/reportDetail.jsp"></jsp:include>
                                </c:when>
                            </c:choose>
                        </div>
                        <!-- 결재의견 -->
                        <div class="d-flex justify-content-start mt-3">
                            <c:choose>
                                <c:when test="${edocDetail.apprOrder1 == 1 && edocDetail.apprStatus1 != 0}">
                                    <jsp:include page="/WEB-INF/view/edoc/edoc-form-detail/approvalReasonDetail.jsp"></jsp:include>
                                </c:when>
                                <c:when test="${edocDetail.apprOrder2 == 2 && edocDetail.apprStatus2 != 0}">
                                    <jsp:include page="/WEB-INF/view/edoc/edoc-form-detail/approvalReasonDetail.jsp"></jsp:include>
                                </c:when>
                            </c:choose>
                        </div>
                        <hr />
                        <!-- 버튼 -->
                        <div class="text-start">
                            <c:if test="${edocDetail.writerEmpCode != loginInfo.empCode && ( edocDetail.edocDoneDate == null || edocDetail.edocDoneDate == '')}">
                                <button id="approveBtn" class="btn btn-link btn-me" type="button">
                                    <i class="menu-icon bx bx-check-square"></i>결재
                                </button>
                                <button id="rejectBtn" class="btn btn-link btn-me" type="button">
                                    <i class="menu-icon bx bx-exit"></i>반려
                                </button>
                            </c:if>
                            <a href="javascript:history.back()" class="btn btn-link btn-me">
                                <i class="menu-icon bx bx-chevron-left-circle"></i>돌아가기
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- 결재의견 모달 시작 -->
        <div class="modal fade" id="approvalModal" tabindex="-1" aria-labelledby="approvalModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="approvalModalLabel"></h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form id="approvalForm">
                        <div class="modal-body">
                        <!-- 쪽지 작성 폼 -->
                            <input type="hidden" name="empCode" value="${loginInfo.empCode}">
                            <input type="hidden" name="edocNum" value="${edocDetail.edocNum}">
                            <div class="mb-3">
                                <label for="apprReason" class="form-label">의견</label>
                                <textarea class="form-control" id="apprReason" name="apprReason" rows="3" placeholder="의견을 작성해 주세요"></textarea>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                            <button type="submit" class="btn btn-primary">
                                <span id="modalInBtn"></span>
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!-- 결재의견 모달 종료 -->
        <script>
            $(document).ready(function() {
                
                if(${loginInfo.empCode == edocDetail.approver1}) { // 1차 승인자인 경우
                    console.log('1차승인자입니다');
                    $('#approveBtn').click(function() {
                        if(${edocDetail.apprStatus1} != '0') {
                            alert('이미 결재하신 문서입니다');
                        } else {
                            $('#approvalModalLabel').text('결재하기');
                            $('#modalInBtn').text('승인');
                            $('#approvalForm').data('request', 1); // request 값 설정
                            $('#approvalModal').modal('show');
                        };
                    });
                    
                    $('#rejectBtn').click(function() {
                        if(${edocDetail.apprStatus1} != '0'){
                            alert('이미 결재하신 문서입니다');
                        } else {
                            $('#approvalModalLabel').text('반려하기');
                            $('#modalInBtn').text('반려');
                            $('#approvalForm').data('request', -1); // request 값 설정
                            $('#approvalModal').modal('show');
                        };
                    });
                } else if (${loginInfo.empCode == edocDetail.approver2}){ // 2차 승인자인 경우
                    console.log('2차승인자입니다');
                    $('#approveBtn').click(function() {
                        if(${edocDetail.apprStatus2} != '0' ){
                            alert('이미 결재하신 문서입니다');
                        } else {
                            $('#approvalModalLabel').text('결재하기');
                            $('#modalInBtn').text('승인');
                            $('#approvalForm').data('request', 2); // request 값 설정
                            $('#approvalModal').modal('show');  
                        };
                    });
                    
                    $('#rejectBtn').click(function() {
                        if( ${edocDetail.apprStatus2} != '0' ) {
                            alert('이미 결재하신 문서입니다');
                        } else {
                            $('#approvalModalLabel').text('반려하기');
                            $('#modalInBtn').text('반려');
                            $('#approvalForm').data('request', -1); // request 값 설정
                            $('#approvalModal').modal('show');
                        };
                    });
                }
                
                // 폼 제출 시 AJAX 요청으로 쪽지 보내기
                $('#approvalForm').submit(function(e) {
                    e.preventDefault(); // 폼의 기본 제출 동작을 중단
                    
                    let formData = $(this).serialize(); // 폼 데이터를 직렬화하여 URL 인코딩된 문자열로 변환
                    let request = $(this).data('request'); // 저장된 request 값 가져오기
            
                    $.ajax({
                        url: '/gaent/edoc/updateEdocProcess',
                        type: 'POST',
                        data: formData + '&request=' + request,
                        success: function(response) {
                            alert('처리가 완료되었습니다.');
                            $('#approvalModal').modal('hide');
                            $('#approvalForm')[0].reset(); // 폼 초기화
                            // window.location.href = '/gaent/approval'; // 전자결재홈으로 이동
                            window.location.reload();
                        },
                        error: function() {
                            alert('처리에 실패했습니다.');
                        }
                    });
                });
            });
        </script>
    </body>
</html>