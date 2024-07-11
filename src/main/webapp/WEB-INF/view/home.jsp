<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <title>홈 - GAEnt.</title>
    </head>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/workspace.css" />
  <body>
    <div id="">
      <div id="header-area">
        <jsp:include page="common/header.jsp"></jsp:include>
      </div>
      <div id="sidebar_area">
        <jsp:include page="common/sidebar.jsp"></jsp:include>
        <jsp:include page="common/sub-sidebar.jsp"></jsp:include>
      </div>
      <div id="workspace-area" class="workspace">
        <h1>테스트</h1>
      </div>
    </div>
  </body>
</html>