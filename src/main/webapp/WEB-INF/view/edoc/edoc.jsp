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
    <!-- 조직도 관련 CDN -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/themes/default/style.min.css"/>
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
          <form method="post" action="approver/edoc">
            <div class="d-flex mb-3">
              <span class="display-6 fw-semibold me-3">기안하기</span>
              <div class="edoc-type-select-box">
                <select id="edoc-type" class="form-select form-select-sm" name="edocType">
                  <option value="">양식을 선택해주세요.</option>
                </select>
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
                            <input type="hidden" name="edocWriter" value="${loginInfo.empCode}" readonly />
                          </td>
                        </tr>
                        <tr>
                          <th class="text-center">소속</th>
                          <td class="small">
                            <input name="edocRankCode" value="${loginInfo.rankCode}" readonly />
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
                <input type="hidden" name="approver1" id="hiddenEdocApprover1">
                <input type="hidden" name="apprOrder1" id="hiddenEdocApproverOrder1">
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
                <input type="hidden" name="approver2" id="hiddenEdocApprover2">
                <input type="hidden" name="apprOrder2" id="hiddenEdocApproverOrder2">
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
              <div class="text-end">
                <button class="btn btn-link btn-me" type="submit">
                  <i class="menu-icon bx bx-save"></i>결재요청
                </button>
                <button id="approverModal" class="btn btn-link btn-me" data-bs-toggle="modal" data-bs-target="#approvalModalOrgChart" type="button">
                  <i class="menu-icon bx bx-info-circle"></i>결재정보
                </button>
                <!-- 결재선 정보 모달 시작 -->
                <div class="modal fade" id="approvalModalOrgChart" tabindex="-1" style="display: none;" aria-hidden="true">
                  <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable" role="document">
                    <div class="modal-content p-2">
                      <div class="modal-header">
                        <h5 class="modal-title" id="modalCenterTitle">결재선 선택</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                      </div>
                      <div class="modal-body d-flex">
                        <div class="approver-info me-4">
                          <div id="orgChart"></div>
                        </div>
                        <div class="approver-input">
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
                        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">닫기</button>
                        <button type="button" class="btn btn-primary" id="approverSubmit">확인</button>
                      </div>
                    </div>
                  </div>
                </div>
                <!-- 결재선 정보 모달 끝 -->
                <a href="approval" class="btn btn-link btn-me">
                  <i class="menu-icon bx bx-chevron-left-circle"></i>돌아가기
                </a>
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
        
        $('#firstApproverBtn').on('click', function() {
          $('#firstApprover').val();
        });
          
        $('#secondApproverBtn').on('click', function() {
          $('#secondApprover').val();
        });
        
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
        
        $('#orgChart').on('select_node.jstree', function(e, data) {
          e.preventDefault(); // 기본 이벤트 동작 막기
          
          let empCode = data.node.id;
          let korName = data.node.text;
          let rankCode = data.node.rankCode;
          
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
      });
      
      $('#approverSubmit').on('click', function() {
        if (!$('#firstEmpCode').val()) {
          alert('1차 결재자를 선택해주세요.');
          return;
        }
        
        let firstRank = $('#firstName').val();
        let firstRankName = firstRank.slice(-2, firstRank.length);
        
        let secondRank = $('#secondName').val();
        let secondRankName = secondRank.slice(-2, secondRank.length);
        
        // 1차 결재자 값 설정
        $('#edoc-approver-one').show();
        $('#edocRankCode1').text(firstRankName);
        $('#edocKorName1').text($('#firstName').val());
        $('#hiddenEdocApprover1').val($('#firstEmpCode').val());
        
        // 2차 결재자 값 설정
        if ($('#secondEmpCode').val()) {
          $('#edoc-approver-two').show();
          $('#edocRankCode2').text(secondRankName);
          $('#edocKorName2').text($('#secondName').val());
          $('#hiddenEdocApprover2').val($('#secondEmpCode').val());
        } else {
          $('#edoc-approver-two').hide();
        }
        
        // 모달 닫기
        $('#approvalModalOrgChart').modal('hide');
      });
      
      function selectType() {
          $.ajax({
            url: '/gaent/edocType',
            method: 'GET',
            success: function (data) {
              // console.log(data);
              data.forEach(function (el) {
                // console.log(el);
                $('#edoc-type').append('<option value="' + el.edocType + '">' + el.edocFormTitle + '</option>');
              });
            },
            error: function (error) {
              console.log(error);
            },
          });
          
          $('#edoc-type').change(function () {
            let edocType = $('#edoc-type').val();
            
            if (edocType == '') {
              $('#edoc-form-type').empty().append('<div class="edoc-form-area">양식을 선택해주세요.</div>');
              return;
            }
          
            let url = '/gaent/edoc/' + edocType;
            let title = '';
            
            switch (edocType) {
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
              success: function (data) {
                console.log(data);
                $('#edoc-form-title').text(title);
                $('#edoc-form-type').empty().append(data);
              },
              error: function (error) {
                console.log(error);
              },
            });
          });
      }
    </script>
  </body>
</html>
