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
        <!-- 조직도 관련 CDN -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/themes/default/style.min.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" integrity="sha512-..." crossorigin="anonymous"/>
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
                <div class="edoc">
                    <!-- 폼태그 시작  -->
                    <form id="edocInputForm" class="edoc-input-group" enctype="multipart/form-data">
                        <div class="d-flex align-items-center justify-content-start mb-3">
                            <div class="d-flex">
                                <span class="display-6 fw-semibold me-3">전자문서 작성하기</span>
                                <div class="edoc-type-select-box">
                                    <select id="edoc-type" class="form-select form-select-sm" name="edocType">
                                        <option value="">양식을 선택해주세요.</option>
                                    </select>
                                </div>
                            </div>
                            <div>
                                <button id="approverModal" class="btn btn-link btn-me" data-bs-toggle="modal" data-bs-target="#approvalModalOrgChart" type="button">
                                    <i class="menu-icon bx bx-info-circle"></i>결재선 선택
                                </button>
                                <!-- 결재선 정보 모달 시작 -->
                                <div class="modal fade" id="approvalModalOrgChart" tabindex="-1" style="display: none;" aria-hidden="true">
                                    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable" role="document">
                                        <div class="modal-content p-2">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="modalCenterTitle">결재선 선택</h5>
                                                <button id="modalTopCloseBtn" type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                            </div>
                                            <div class="modal-body d-flex">
                                                <div class="approver-info me-4">
                                                    <div id="orgChart"></div>
                                                </div>
                                                <div class="approver-input-group">
                                                    <hr>
                                                    <div class="mb-3">
                                                        <div class="d-flex justify-content-between">
                                                            <h5>1차 결재선</h5>
                                                            <button type="button" class="btn btn-outline-primary btn-sm h-25" id="firstApprBtn">초기화</button>
                                                        </div>
                                                        <div class="d-flex align-items-center text-end mb-2">
                                                            <label for="firstApprover">사원번호 :</label>
                                                            <input class="form-control form-control-sm" type="text" name="firstEmpCode" id="firstEmpCode" readonly>
                                                        </div>
                                                        <div class="d-flex align-items-center text-end">
                                                            <label for="firstApprover">이름 :</label>
                                                            <input class="form-control form-control-sm" type="text" name="firstName" id="firstName" readonly>
                                                        </div>
                                                    </div>
                                                    <hr>
                                                    <div class="mb-3">
                                                        <div class="d-flex justify-content-between">
                                                            <h5>2차 결재선</h5>
                                                            <button type="button" class="btn btn-outline-primary btn-sm h-25" id="secondApprBtn">초기화</button>
                                                        </div>
                                                        <div class="d-flex align-items-center text-end mb-2">
                                                            <label for="secondApprover">사원번호 :</label>
                                                            <input class="form-control form-control-sm" type="text" name="secondEmpCode" id="secondEmpCode" readonly>
                                                        </div>
                                                        <div class="d-flex align-items-center text-end">
                                                            <label for="secondApprover">이름 :</label>
                                                            <input class="form-control form-control-sm" type="text" name="secondName" id="secondName" readonly>
                                                        </div>
                                                    </div>
                                                    <hr>
                                                </div>
                                            </div>
                                            <div class="modal-footer">
                                                <button id="modalBottomCloseBtn" type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">닫기</button>
                                                <button type="button" class="btn btn-primary" id="approverSubmit">확인</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- 결재선 정보 모달 끝 -->
                            </div>
                        </div>
                        <hr />
                        <div>
                            <div class="mb-3">
                                <span id="edoc-form-title" class="display-6 fw-semibold mb-0">전자문서양식</span>
                            </div>
                            <div class="d-flex justify-content-between">
                                <!-- 문서정보 -->
                                <div class="edoc-form-info">
                                    <div class="table-responsive text-nowrap">
                                        <table class="table table-bordered table-sm edoc-form-info-table">
                                            <tbody>
                                                <tr>
                                                    <th class="text-center">기안자</th>
                                                    <td class="small">
                                                        <input name="edocKorName" value="${loginInfo.korName}" readonly />
                                                        <input id="myEmpCode" type="hidden" name="edocWriter" value="${loginInfo.empCode}" readonly/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th class="text-center">소속</th>
                                                    <td class="small">
                                                        <input name="edocRankCode" value="${loginInfo.teamName}" readonly />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th class="text-center">기안일</th>
                                                    <td class="small">
                                                        <input name="edocDate" value="${date}" readonly />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th class="text-center">문서번호</th>
                                                    <td class="small"></td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                <!-- 결재선 시작 -->
                                <div class="d-flex">
                                    <div id="edoc-approver-one" class="me-2" style="display: none;">
                                        <div class="table-responsive text-nowrap approver-form">
                                            <table class="table table-bordered appr-table">
                                                <tr>
                                                    <th id="edocApproverOrder1" class="text-center approver-th-tag" rowspan="3">1 차</th>
                                                    <td id="edocRankCode1" class="small text-center approver-td-tag">직위</td>
                                                </tr>
                                                <tr>
                                                    <td id="edocKorName1" class="small text-center">결재자</td>
                                                </tr>
                                                <tr>
                                                    <td id="edocApprovalDate1" class="small text-center approver-td-tag">결재일</td>
                                                </tr>
                                            </table>
                                            <input type="hidden" name="approver" id="hiddenEdocApprover1">
                                            <input type="hidden" name="apprOrder" id="hiddenEdocApproverOrder1" value="1">
                                        </div>
                                    </div>
                                    <div id="edoc-approver-two" class="me-2" style="display: none;">
                                        <div class="table-responsive text-nowrap approver-form">
                                            <table class="table table-bordered appr-table">
                                                <tr>
                                                    <th id="edocApproverOrder2" class="text-center approver-th-tag" rowspan="3">2 차</th>
                                                    <td id="edocRankCode2" class="small text-center approver-td-tag">직위</td>
                                                </tr>
                                                <tr>
                                                    <td id="edocKorName2" class="small text-center">결재자</td>
                                                </tr>
                                                <tr>
                                                    <td id="edocApprovalDate2" class="small text-center approver-td-tag">결재일</td>
                                                </tr>
                                            </table>
                                            <input type="hidden" name="approver" id="hiddenEdocApprover2">
                                            <input type="hidden" name="apprOrder" id="hiddenEdocApproverOrder2" value="2">
                                        </div>
                                    </div>
                                </div>
                                <!-- 결재선 끝 -->
                            </div>
                            <hr />
                            <!-- 기안서 양식 -->
                            <div>
                                <div id="edoc-form-type">
                                    <div class="edoc-form-area">양식을 선택해주세요.</div>
                                </div>
                                <hr />
                                <!-- 버튼 -->
                                <div class="text-start">
                                    <button class="btn btn-link btn-me" type="submit">
                                        <i class="menu-icon bx bx-save"></i>결재요청
                                    </button>
                                    <a href="approval" class="btn btn-link btn-me"><i class="menu-icon bx bx-chevron-left-circle"></i>돌아가기</a>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.12.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/jstree.min.js"></script>
        <script src="https://unpkg.com/perfect-scrollbar@1.5.5/dist/perfect-scrollbar.min.js"></script>
        <script>
            $(document).ready(function() {
                selectType();
                
                $('#orgChart').jstree({
                    'core' : {
                        'data' : {
                            'url' : '/gaent/hr/tree',
                            'dataType' : 'json'
                        },
                        'themes' : {
                            'icons' : true,
                            'dots' : true,
                            'responsive' : true
                        },
                        'expand_all' : true,
                    },
                    'plugins' : [ 'themes', 'json_data', 'state' ]
                });
            });
            
            // 결재 요청
            $('#edocInputForm').submit(function (e) {
                e.preventDefault();
                
                if(!$('#edoc-type').val()) {
                    alert('결재 문서의 양식을 선택해주세요.');
                    return;
                } else if(!$('#firstEmpCode').val() && !$('#secondEmpCode').val()) {
                    alert('결재선을 선택해주세요.');
                    return;
                } else if(!$('#edocTitle').val()) {
                    alert('결재 문서의 제목을 입력해주세요.');
                    return;
                }
                
                let formData = new FormData($('#edocInputForm')[0]);

                $.ajax({
                    url: '/gaent/approver/edoc',
                    type: 'POST',
                    data: formData,
                    contentType: false,
                    processData: false,
                    success: function (data) {
                        console.log(data);
                        alert('성공');
                        $('#edocInputForm')[0].reset();
                        window.location.href='/gaent/approval/wait';
                    },
                    error: function (e) {
                        console.log(e);
                        alert('실패');
                    },
                });
            });
            
            // 결재 정보에서 조직도 선택 -> 결재선 추가하기
            $('#orgChart').on('select_node.jstree', function(e, data) {
                e.preventDefault(); // 기본 이벤트 동작 막기

                let empCode = data.node.id;
                let korName = data.node.text;
                let rankCode = data.node.rankCode;
                
                if(empCode.length < 8) {
                    alert('결재선에는 직원만 선택 가능합니다.');
                    $('#orgChart').jstree(true).deselect_node(data.node.id);
                    return;
                }
                
                if(empCode == $('#myEmpCode').val()) {
                    alert('결재선에는 본인을 선택할 수 없습니다.');
                    $('#orgChart').jstree(true).deselect_node(data.node.id);
                    return;
                }
                
                let firstEmpCode = $('#firstEmpCode');
                let firstName = $('#firstName');

                let secondEmpCode = $('#secondEmpCode');
                let secondName = $('#secondName');

                // 1차, 2차 결재선 선택
                // 1차 결재선 조건문 -> 1차 input의 value가 없거나, 2차 input의 value가 있을 때
                if(!firstEmpCode.val() || (!firstEmpCode.val() && secondEmpCode.val())) {

                    if(secondEmpCode.val() !== empCode) {
                        // 선택한 결재선이 2차와 같지 않을 때 value 삽입
                        firstEmpCode.val(empCode);
                        firstName.val(korName);
                    } else {
                        // 선택한 결재선이 2차와 같다면 경고!
                        alert('2차 결재자와 같은 결재자입니다.');
                    }

                    // 2차 결재선 조건문 -> 2차 input의 value가 없을 때
                } else if(!secondEmpCode.val()) {

                    if(firstEmpCode.val() !== empCode) {
                        // 선택한 결재선이 1차와 같지 않을 때 value 삽입
                        secondEmpCode.val(empCode);
                        secondName.val(korName);
                    } else {
                        // 선택한 결재선이 1차와 같다면 경고!
                        alert('1차 결재자와 같은 결재자입니다.');
                    }
                } else if(firstEmpCode.val() && secondEmpCode.val()) {
                    alert('2차 결재선까지 다 찼습니다. 확인을 눌러주세요.');
                }

                // 선택된 노드 해제
                $('#orgChart').jstree(true).deselect_node(empCode);
            });
            
            // 1차 결재선 초기화
            $('#firstApprBtn').on('click', function() {
                $('#firstEmpCode').val('');
                $('#firstName').val('');
            });

            // 2차 결재선 초기화
            $('#secondApprBtn').on('click', function() {
                $('#secondEmpCode').val('');
                $('#secondName').val('');
            });
            
            $('#modalTopCloseBtn').on('click', function() {
                $('#firstEmpCode').val('');
                $('#firstName').val('');
                $('#secondEmpCode').val('');
                $('#secondName').val('');
            });
            
            $('#modalBottomCloseBtn').on('click', function() {
                $('#firstEmpCode').val('');
                $('#firstName').val('');
                $('#secondEmpCode').val('');
                $('#secondName').val('');
            });

            // 결재선 등록
            $('#approverSubmit').on('click', function() {
                if(!$('#firstEmpCode').val()) {
                    alert('1차 결재자를 선택해주세요.');
                    return;
                }
                
                let firstName = $('#firstName').val();
                let firstRankName = firstName.slice(-2, firstName.length);
                let firstEmpCode = $('#firstEmpCode').val();

                let secondName = $('#secondName').val();
                let secondRankName = secondName.slice(-2, secondName.length);
                let secondEmpCode = $('#secondEmpCode').val();

                // 1차 결재자 값 설정
                $('#edoc-approver-one').show();
                $('#edocRankCode1').text(firstRankName);
                $('#edocKorName1').text(firstName);
                $('#hiddenEdocApprover1').val(firstEmpCode);

                // 2차 결재자 값 설정
                if($('#secondEmpCode').val()) {
                    $('#edoc-approver-two').show();
                    $('#edocRankCode2').text(secondRankName);
                    $('#edocKorName2').text(secondName);
                    $('#hiddenEdocApprover2').val(secondEmpCode);
                } else {
                    $('#edoc-approver-two').hide();
                    $('#hiddenEdocApprover2').val('');
                }

                // 모달 닫기
                $('#approvalModalOrgChart').modal('hide');
            });

            function selectType() {
                $.ajax({
                    url: '/gaent/edocType',
                    method: 'GET',
                    success: function(data) {
                        // console.log(data);
                        data.forEach(function(el) {
                            // console.log(el);
                            $('#edoc-type').append('<option value="' + el.edocType + '">' + el.edocFormTitle + '</option>');
                        });
                    },
                    error: function(error) {
                        console.log(error);
                    },
                });

                $('#edoc-type').change(function() {
                    let edocType = $('#edoc-type').val();

                    if(edocType == '') {
                        $('#edoc-form-title').text('전자문서양식');
                        $('#edoc-form-type').empty().append('<div class="edoc-form-area">양식을 선택해주세요.</div>');
                        return;
                    }

                    let url = '/gaent/edoc/' + edocType;
                    let title = '';

                    switch(edocType) {
                        case '0':
                            title = '기안서';
                            break;
                        case '1':
                            title = '휴가신청서';
                            break;
                        case '2':
                            title = '지출결의서';
                            break;
                        case '3':
                            title = '경조사 지출결의서';
                            break;
                        case '4':
                            title = '보고서';
                            break;
                    }

                    $.ajax({
                        url: url,
                        method: 'GET',
                        success: function(data) {
                            // console.log(data);
                            $('#edoc-form-title').text(title);
                            $('#edoc-form-type').empty().append(data);
                        },
                        error: function(error) {
                            console.log(error);
                        },
                    });
                });
            }
        </script>
    </body>
</html>
