<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>받은쪽지함</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/workspace.css" />
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        
        .inbox-container {
            margin-top: 20px;
        }
        .inbox-header {
            display: flex;
            justify-content: space-between;
            padding: 10px 0;
            border-bottom: 1px solid #ddd;
        }
        .inbox-actions span, .inbox-actions button {
            margin-right: 15px;
        }
        .inbox-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }
        .inbox-table th, .inbox-table td {
            padding: 10px;
            border: 1px solid #ddd;
        }
        .inbox-table th {
            background-color: #f9f9f9;
        }
        .inbox-table tr:hover {
            background-color: #f1f1f1;
        }
        .checkbox {
            text-align: center;
            width: 60px;
        }
        .msg-sub-size {
            width: 140px;
            text-align: center;
        }
        .msg-state-size {
            width: 80px;
            text-align: center;
        }
        .msg-time-size {
            width: 200px;
            text-align: right;
        }
        .msg-sh-btn{
            text-decoration: none;   /* 링크의 기본 밑줄 제거 */
            padding: 5px 5px;      /* 버튼의 패딩 조정 */
            color: white;            /* 버튼의 텍스트 색상 */
            border-radius: 5px;      /* 버튼의 모서리 둥글게 */
            display: inline-block;   /* 버튼이 줄바꿈 없이 나란히 위치하도록 설정 */
        }
        
    </style>
</head>
<body>
    <div id="header-area">
        <jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>
    </div>
    <div id="sidebar_area">
        <jsp:include page="/WEB-INF/view/common/sidebar.jsp"></jsp:include>
        <jsp:include page="/WEB-INF/view/msg/msg-sub-sidebar.jsp"></jsp:include>
    </div>
    <div id="workspace-area" class="subsidebar-from-workspace">
        <div class="card">
            <h2 class="card-title" style="margin:50px 0px 0px 30px">휴지통</h2>            
            <div class="card-body inbox-container">            
                <div class="care-body" style="height:600px; position: relative;">
                    <table class="inbox-table">
                        <thead>
                            <tr>
                                <th colspan="3">
                                    전체 : ${pg.lastRow}개
                                </th>
                                <th style="padding-left:80px">
                                    <form class="d-flex align-items-center" action="/gaent/msg/0">
                                        <span style="width:600px">
                                        <input class="form-control me-2" type="search" placeholder="검색어를 입력하세요..." aria-label="Search" name="searchMsg">
                                        </span>
                                        <button class="btn btn-secondary msg-sh-btn" type="submit">검색</button>
                                    </form>
                                </th>
                                <th style="text-align:right">
                                    <button type="button" id="restoreButton" class="btn btn-info">복원</button>
                                    <button type="button" id="deleteButton" class="btn btn-danger">삭제</button>
                                </th>
                            </tr>
                            <tr>
                                <th class="checkbox"><input type="checkbox" id="selectAll" class="form-check-input form-check-input-lg"></th>
                                <th class="msg-state-size">상태</th>
                                <th class="msg-sub-size">상대방</th>
                                <th class="msg-title-size">제목</th>
                                <th class="msg-time-size">시간</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:if test="${empty list}">
                                <tr>
                                    <td colspan="5" style="text-align:center">쪽지가 없습니다</td>
                                </tr>
                            </c:if>
                            <c:forEach var="m" items="${list}">
                                <tr>
                                    <td class="checkbox">
                                        <input type="checkbox" class="form-check-input form-check-input-lg" name="msgNum" value="${m.msgNum}">
                                    </td>
                                    <td class="msg-state-size">${m.receiver == m.sender ? '<span class="badge bg-label-info fs-6">나</span>' :
                                         (m.receiver == loginInfo.empCode ? '<span class="badge bg-label-primary fs-6">수신</span>': 
                                         '<span class="badge bg-label-warning fs-6">발신</span>') }
                                    </td>                                    
                                    <td class="msg-sub-size">${m.receiver == m.sender ? '내게쓰기' : (m.receiver == loginInfo.empCode ? m.receiverName : m.senderName) }</td>
                                    <td class="msg-title-size">
                                        <a href="/gaent/msg/msgDetail/${m.msgNum}" style="color: ${m.readTime == null ? 'black' : '#A0A0A0'}">
                                            ${m.msgTitle}
                                        </a>
                                    </td>
                                    <td class="msg-time-size">${m.sendTime}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    <!-- 페이징 -->
                    <div>
                        <jsp:include page="/WEB-INF/view/common/paging.jsp">
                            <jsp:param name="extraParam" value="&searchMsg=${param.searchMsg}"/>
                        </jsp:include>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script>
        $(document).ready(function() {
          
            // 한번에 체크
            $('#selectAll').click(function() {
                $('input[name="msgNum"]').prop('checked', this.checked);
            });
            
			<!-- 삭제버튼-->
            $('#deleteButton').click(function() {
                let checkedItems = $('input[name="msgNum"]:checked');
                let count = checkedItems.length;
                let empCode = "${loginInfo.empCode}";
                if (count > 0) {
                    if (confirm(count + '개 항목을 영구 삭제하시겠습니까? ')) {
                        let ids = [];
                        checkedItems.each(function() {
                            ids.push($(this).val());
                        });
                        $.ajax({
                            url: '/gaent/msg/modifyMsgStatus',
                            type: 'POST',
                            traditional: true,
                            data: {
                                msgNums: ids,
                                empCode: empCode,
                                request: 3
                            },
                            success: function(result) {
                                if (result == 0) {
                                    alert('삭제되지 않은 항목이 있습니다.');
                                } else {
                                    alert('선택된 항목이 삭제되었습니다.');
                                    location.reload();
                                }
                            },
                            error: function() {
                                alert('항목 삭제에 실패했습니다.');
                            }
                        });
                    }
                } else {
                    alert('삭제할 항목을 선택하세요.');
                }
            });
            
            			<!-- 복구버튼-->
            $('#restoreButton').click(function() {
                let checkedItems = $('input[name="msgNum"]:checked');
                let count = checkedItems.length;
                let empCode = "${loginInfo.empCode}";
                if (count > 0) {
                    if (confirm(count + '개 항목을 복원하시겠습니까? ')) {
                        let ids = [];
                        checkedItems.each(function() {
                            ids.push($(this).val());
                        });
                        $.ajax({
                            url: '/gaent/msg/modifyMsgStatus',
                            type: 'POST',
                            traditional: true,
                            data: {
                                msgNums: ids,
                                empCode: empCode,
                                request: 2
                            },
                            success: function(result) {
                                if (result == 0) {
                                    alert('복원되지 않은 항목이 있습니다.');
                                } else {
                                    alert('선택된 항목이 복원되었습니다.');
                                    location.reload();
                                }
                            },
                            error: function() {
                                alert('항목 복원에 실패했습니다.');
                            }
                        });
                    }
                } else {
                    alert('복원할 항목을 선택하세요.');
                }
            });
        });
    </script>
</body>
</html>
