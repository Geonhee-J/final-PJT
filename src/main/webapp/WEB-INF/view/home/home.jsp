<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <title>홈 - GAEnt.</title>
        <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/assets/img/favicon/favicon.ico"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/workspace.css"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/home.css"/>
    </head>
    <body>
        <div id="">
            <div id="header-area">
                <jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>
            </div>
            <div id="sidebar-area">
                <jsp:include page="/WEB-INF/view/common/sidebar.jsp"></jsp:include>
            </div>
            <div id="workspace-area" class="sidebar-from-workspace">
                <div class="content-wrapper">
                    <div class="flex-grow-1 home-container">
                        <div class="row mb-2">
                            <div class="col-2 mb-3 d-flex justify-content-center">
                                <jsp:include page="/WEB-INF/view/home/profile-card.jsp"></jsp:include>
                            </div>
                            <div class="col-2 mb-3 d-flex justify-content-center">
                                <jsp:include page="/WEB-INF/view/home/edoc-card.jsp"></jsp:include>
                            </div>
                            <div class="col-3 mb-3 d-flex justify-content-center">
                                <jsp:include page="/WEB-INF/view/home/msg-card.jsp"></jsp:include>
                            </div>
                            <div class="col-5 mb-3 d-flex justify-content-center">
                                <jsp:include page="/WEB-INF/view/home/calendar-card.jsp"></jsp:include>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-2 mb-3 d-flex justify-content-center">
                                <jsp:include page="/WEB-INF/view/home/attendance-card.jsp"></jsp:include>
                            </div>
                            <div class="col-5 mb-3 d-flex justify-content-center">
                                <jsp:include page="/WEB-INF/view/home/board-card.jsp"></jsp:include>
                            </div>
                            <div class="col-5 mb-3 d-flex justify-content-center">
                                <jsp:include page="/WEB-INF/view/home/navernews-card.jsp"></jsp:include>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div id="checkManagerModal" class="modal fade" role="dialog" tabindex="-1" aria-labelledby="checkLoginModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <!-- Modal content-->
                    <div id="message" class="modal-content text-white">
                        <div class="modal-header">
                            <h4 class="modal-title">${message}</h4>
                        </div>
                        <div class="modal-body">
                            <p>${checkManagerMessage}</p>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        </div>
                    </div>
                <!-- Modal content-->
            </div>
        </div>
        <script>
            $(document).ready(function(){
                if(${!empty message}){
                    $("#message").attr("class", "modal-content");
                    $("#checkManagerModal").modal("show");
                };
            });
        </script>
    </body>
</html>
