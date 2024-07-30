<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>채팅 - GAEnt.</title>
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/assets/img/favicon/favicon.ico"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/workspace.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/vendor/css/app-chat.css" class="template-customizer-app-chat-css"/>
    <script src="https://cdn.jsdelivr.net/npm/sockjs-client@1.5.2/dist/sockjs.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@stomp/stompjs@7.0.0/bundles/stomp.umd.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/scrollbar.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/websocket.js"></script>
  </head>
  <body>
    <div id="">
      <div id="header-area">
        <jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>
      </div>
      <div id="sidebar-area">
        <jsp:include page="/WEB-INF/view/common/sidebar.jsp"></jsp:include>
        <jsp:include page="/WEB-INF/view/chat/chat-sub-sidebar.jsp"></jsp:include>
      </div>
      <div id="workspace-area" class="d-flex">
        <div class="chat-list-from-workspace">
          <jsp:include page="/WEB-INF/view/chat/chatRoomList.jsp"></jsp:include>
        </div>
        <div class="chat-history-from-workspace">
          <input type="hidden" id="sessionEmpCode" value="${loginInfo.empCode}">
          <input type="hidden" id="sessionKorName" value="${loginInfo.korName}">
          <jsp:include page="/WEB-INF/view/chat/chatHistory.jsp"></jsp:include>
        </div>
      </div>
    </div>
  </body>
</html>