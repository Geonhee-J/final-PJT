<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>근태내역</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/workspace.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/attendance.css" />
    </head>
    <body>
        <div id="header-area">
            <jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>
        </div>
        <div id="sidebar-area">
            <jsp:include page="/WEB-INF/view/common/sidebar.jsp"></jsp:include>
            <jsp:include page="/WEB-INF/view/attendance/atd-sub-sidebar.jsp"></jsp:include>
        </div>
            <div id="workspace-area" class="subsidebar-from-workspace ">
                <div class="" style="height: 50rem; max-height: 800px !important; overflow-y: auto !important; transition: height 0.5s ease;">
                    <h2 class="card-title  mt-2 ms-2 fw-bold">근태내역</h2>
                        <div class="card p-3">
                            <div style="text-align: center">
                                <h4>
                                    <a href="/gaent/atd?year=${c.prevYear}&month=${c.prevMonth}">◀</a> ${c.tgYear}년 ${c.tgMonth}월 <a href="/gaent/atd?year=${c.nextYear}&month=${c.nextMonth}">▶</a>
                                </h4>
                            </div>
                            <div class=" justify-content-center ">
                                <table border="1" class="table" style="text-align: center; margin: 0 auto; border-radius: 30px; width: auto;">
                                    <tr>
                                        <td class="w-25">금일 근무 시간</td>
                                        <td class="w-25">이번주 누적</td>
                                        <td class="w-25 justify-content-end">이번달 누적</td>
                                    </tr>
                                    <tr>
                                        <td><span id="daily"></span></td>
                                        <td><span id="weekly"></span></td>
                                        <td><span id="monthly"></span></td>
                                    </tr>
                                </table>
                            </div>
                             <div class="d-flex justify-content-end">
                                <span class="pe-3" id="attendanceCount"></span>
                                <span class="pe-3" id="lateCount"></span>
                                <span class="pe-3" id="earlyLeaveCount"></span>
                                <span class="pe-3" id="absenceCount"></span>
                            </div><hr class="m-0" style="  border: 1px solid black">
                            <div class="card-body pt-0" style="positions: relative;">
                                <c:set var="currentWeek" value="1"/>
                                <c:set var="previousWeek" value="1"/>
                                <c:forEach var="day" begin="1" end="${c.tgLastDate}">
                                    <!-- 요일 계산 -->
                                    <c:set var="dayOfWeekIndex" value="${(day + c.preBlank - 2) % 7}" />
                                    <!-- 주차 계산 -->
                                    <c:set var="week" value="${fn:substringBefore((day + c.preBlank - 2) / 7 + 1, '.')}주차"/>
                                    <!-- 주가 변경되었는지 확인하고 테이블을 생성 -->
                                    <c:if test="${currentWeek != week}">
                                        <div>
                                            <div>
                                                <table>
                                                    <tr>
                                                        <td><td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </div>
                                    </c:if>
                                    <!-- 주가 변경되었으면, 주 버튼과 테이블 생성 -->
                                    <c:if test="${currentWeek != week && week != '0주차'}">
                                        <c:set var="currentWeek" value="${week}" />
                                        <button class="juchaBtn btn" type="button" data-bs-toggle="collapse" data-bs-target="#week${currentWeek}Collapse" id="${currentWeek}colBtn" aria-expanded="false" aria-controls="week${currentWeek}Collapse" style="padding:0px;">
                                            <span style="font-size:18px;">▼&nbsp;${currentWeek}</span>
                                        </button>
                                        <hr class="juCha-underline">
                                        <div class="collapse" id="week${currentWeek}Collapse">
                                            <div class="card card-body">
                                                <table class="table table-bordered">
                                                    <tr>
                                                        <th class="w-25">날짜</th>
                                                        <th class="w-25">출근시간</th>
                                                        <th class="w-25">퇴근시간</th>
                                                        <th>상태</th>
                                                    </tr>
                                        </c:if>
                                        <!-- 오늘날짜 스타일처리 -->
                                        <c:set var="todayDate" value="${day == c.today &&c.tgMonth == c.todayMonth && c.tgYear == c.todayYear ? 'today' : ''}" />
                                        <tr <c:if test="${todayDate == 'today'}"> style="background-color:rgba(105, 108, 255, 0.3); " </c:if>>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${todayDate == 'today'}">
                                                        <span class="todaynal"  >Day ${day} (${c.dayOfWeek[dayOfWeekIndex]})</span>
                                                    </c:when>
                                                    <c:when test="${dayOfWeekIndex == 6}">
                                                        <span class="sunday">Day ${day} (${c.dayOfWeek[dayOfWeekIndex]})</span>
                                                    </c:when>
                                                    <c:when test="${  week != '0주차' }">
                                                        Day ${day} (${c.dayOfWeek[dayOfWeekIndex]})
                                                    </c:when>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <!-- 출근 시간을 출력 -->
                                                <c:forEach var="vo" items="${list}">
                                                    <c:if test="${vo.year == c.tgYear && vo.month == c.tgMonth && vo.day == day}">${vo.inTime}</c:if>
                                                </c:forEach>
                                            </td>
                                            <td>
                                                <!-- 퇴근 시간을 출력 -->
                                                <c:forEach var="vo" items="${list}">
                                                    <c:if test="${vo.year == c.tgYear && vo.month == c.tgMonth && vo.day == day}">
                                                        ${vo.outTime}
                                                    </c:if>
                                                </c:forEach>
                                            </td>
                                            <td>
                                                <!-- 퇴근 시간을 출력 -->
                                                <c:forEach var="vo" items="${list}">
                                                    <c:if test="${vo.year == c.tgYear && vo.month == c.tgMonth && vo.day == day}">
                                                        ${vo.atdStatus}
                                                    </c:if>
                                                </c:forEach>
                                            </td>
                                        </tr>
                                        <c:if test="${day == c.tgLastDate}">
                                            </table>
                                        </div>
                                    </div>
                                </c:if>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
        <!-- 출퇴근 버튼 모달 시작 -->
        <div class="modal fade" id="confirmationModal" tabindex="-1" aria-labelledby="confirmationModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="confirmationModalLabel"></h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        현재시간은 '<span id="currentTime"></span>' 입니다. <span id="actionText"></span>하시겠습니까?
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-seÍcondary" data-bs-dismiss="modal">취소</button>
                        <button type="button" class="btn btn-primary" id="confirmActionBtn">확인</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- 출퇴근 버튼 모달 종료 -->
        <script>
            $(document).ready(function() {
                atdStatus();
                if(${c.tgMonth == c.todayMonth && c.tgYear == c.todayYear}){
                    $("#${c.todayWeek}주차colBtn").click();
                }
                atdStatusCnt();
            });
            
            function atdStatus(){
                $.ajax({
                    url: "/gaent/atd/atdStatus", // 데이터를 가져올 URL
                    type: "POST", 
                    dataType: "json",
                    success: function(data) {
                        $("#daily").text(data.dailyWorkTime);
                        $("#weekly").text(data.weeklyWorkTime);
                        $("#monthly").text(data.montlyWorkTime);
                    },
                    error: function() {
                        console.error("에러 발생"); // 에러 메시지 출력
                        alert("근무시간 조회중 에러가 발생했습니다."); // 에러 메시지 출력
                    }
                }); 
            }
            
            function atdStatusCnt(){
                $.ajax({
                    url: "/gaent/atd/getAtdStatusCnt",
                    type: "POST",
                    data: {
                        "year": ${c.tgYear},
                        "month": ${c.tgMonth}
                    },
                    dataType: "json",
                    success: function(data) {
                        $("#absenceCount").text("결근: " + data.absenceCount + "회");
                        $("#lateCount").text("지각: " +data.lateCount+ "회");
                        $("#earlyLeaveCount").text("조퇴: " +data.earlyLeaveCount+ "회");
                        $("#attendanceCount").text("출근: " +data.attendanceCount+ "회"); 
                    },
                    error: function() { 
                    }
                });
            }
        </script>
    </body>
</html>
