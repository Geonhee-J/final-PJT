<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<div class="row mb-3">
    <div class="d-flex">
        <c:forEach items="${toDoList}" var="el">
            <div class="card card-size me-3">
                <div class="card-header-edoc">
                    <c:choose>
                        <c:when test="${el.edocStatus == '0'}">
                            <span class="badge bg-label-primary">대기</span>
                        </c:when>
                        <c:when test="${el.edocDoneDate == null}">
                            <span class="badge bg-label-warning">진행</span>
                        </c:when>
                        <c:otherwise>
                            <span class="badge bg-label-success">완료</span>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="card-body-edoc">
                    <c:set var="title" value="${fn:trim(el.edocTitle)}"/>
                        <c:choose>
                            <c:when test="${title.length() > 12}">
                                <h5 class="card-title fw-semibold d-inline-block text-truncate">
                                    ${title.substring(0, 12)}...
                                </h5>
                            </c:when>
                            <c:otherwise>
                                <h5 class="card-title fw-semibold d-inline-block text-truncate">
                                    ${title}
                                </h5>
                            </c:otherwise>
                        </c:choose>
                    <div class="card-text">
                        <small>기안자</small> <small>${el.korName}</small>
                    </div>
                    <div class="card-text">
                        <small>기안일</small> <small>${el.edocEnrollDate}</small>
                    </div>
                    <div class="card-text">
                        <small>결재양식</small> <small>${el.edocFormTitle}</small>
                    </div>
                </div>
                <div class="card-body-edoc text-center">
                    <a href="/gaent/edocDetail/${el.edocType}/${el.edocNum}">
                        <button class="btn btn-outline-primary btn-sm">결재하기</button>
                    </a>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
