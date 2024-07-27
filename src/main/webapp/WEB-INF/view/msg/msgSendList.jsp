<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>보낸쪽지함</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/workspace.css" />
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        .inbox-container {
            width: 100%;
            margin: 0 auto;
            margin-top: 20px;
        }
        .inbox-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
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
        .inbox-table .checkbox {
            text-align: center;
            width: 60px;
        }
        .msg-sub-size {
            width: 160px;
            text-align: center;
        }
        .msg-time-size {
            width: 200px;
            text-align: right;
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
            <h2 class="card-title" style="margin:50px 0px 0px 30px">보낸쪽지함</h2>            
            <div class="card-body inbox-container">            
                <div class="care-body" style="height:600px; position: relative;">
                    <table class="inbox-table">
                        <thead>
                            <tr>
                                <th colspan="2"></th>
                                <th style="padding-left:80px">
                                    <form class="d-flex align-items-center" action="/gaent/msg/2">
                                        <input class="form-control me-2" type="search" placeholder="검색어를 입력하세요..." aria-label="Search" name="searchMsg" style="max-width:80%">
                                        <button class="btn btn-secondary" type="submit">검색</button>
                                    </form>
                                </th>
                                <th style="text-align:right">
                                    <button type="button" id="deleteButton" class="btn btn-danger">삭제</button>
                                </th>
                            </tr>
                            <tr>
                                <th class="checkbox"><input type="checkbox" id="selectAll" class="form-check-input form-check-input-lg"></th>
                                <th class="msg-sub-size">받은사람</th>
                                <th class="msg-title-size">제목</th>
                                <th class="msg-time-size">발송시간</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:if test="${empty list}">
                                <tr>
                                    <td colspan="4" style="text-align:center">보낸 쪽지가 없습니다</td>
                                </tr>
                            </c:if>
                            <c:forEach var="m" items="${list}">
                                <tr onclick="location.href='/gaent/msg/msgDetail/${m.msgNum}'">
                                    <td class="checkbox">
                                        <input type="checkbox" class="form-check-input form-check-input-lg" name="msgNum" value="${m.msgNum}">
                                    </td>
                                    <td class="msg-sender-size">${m.receiverName}</td>
                                    <td class="msg-title-size">
                                        <a href="/gaent/msg/msgDetail/${m.msgNum}">
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
            checkNotReadMsg();

            $('#deleteButton').click(function() {
                let checkedItems = $('input[name="msgNum"]:checked');
                let count = checkedItems.length;
                let empCode = "${loginInfo.empCode}";
                if (count > 0) {
                    if (confirm(count + '개 항목을 삭제하시겠습니까?')) {
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
                                request: 1
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

            // 한번에 체크
            $('#selectAll').click(function() {
                $('input[name="msgNum"]').prop('checked', this.checked);
            });

            function checkNotReadMsg() {
                $.ajax({
                    url: "/gaent/msg/msgNotReadCnt", // 데이터를 가져올 URL
                    type: "GET", // GET 메서드를 사용
                    dataType: "json", // 반환 데이터 타입은 int
                    success: function(notReadCnt) { // 요청이 성공하면 실행
                        // 서버에서 반환된 JSON 데이터에서 값을 읽어와서 msgAlert 요소에 표시
                        $("#notReadCnt").text(notReadCnt);
                    },
                    error: function() { // 요청이 실패하면 실행
                        alert("error"); // 에러 메시지 출력
                    }
                });
            }
        });
    </script>
</body>
</html>
