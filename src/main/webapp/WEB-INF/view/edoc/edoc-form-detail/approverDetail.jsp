<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:if test="${edocDetail.apprOrder1 == 1}">
    <div class="table-responsive text-nowrap approver-form">
        <table class="table table-bordered appr-table">
            <tbody>
                <tr>
                    <th id="edocApproverOrder" class="text-center approver-th-tag" rowspan="4">1 차</th>
                    <td id="edocRankCode" class="small text-center approver-td-tag">직위</td>
                </tr>
                <tr>
                    <td id="edocKorName" class="small text-center d-flex flex-column align-items-center">
                        <div>
                            <c:choose>
                                <c:when test="${edocDetail.apprStatus1 == '1'}">
                                    <i class='bx bx-md bx-check-shield' style="color: #00b300"></i>
                                </c:when>
                                <c:when test="${edocDetail.apprStatus1 == '-1'}">
                                    <i class='bx bx-md bx-registered' style="color: #b00"></i>
                                </c:when>
                                <c:otherwise>
                                    <span>&nbsp;</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div>${edocDetail.approverName1}</div> 
                    </td>
                </tr>
                <tr>
                    <td id="edocApprovalDate" class="small text-center approver-td-tag">
                        ${edocDetail.apprDate1 == null ? '결재일' :edocDetail.apprDate1}
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
</c:if>
<c:if test="${edocDetail.apprOrder2 == 2}">
    <div class="table-responsive text-nowrap approver-form">
        <table class="table table-bordered appr-table">
            <tbody>
                <tr>
                    <th id="edocApproverOrder" class="text-center approver-th-tag" rowspan="4">2 차</th>
                    <td id="edocRankCode" class="small text-center approver-td-tag">직위</td>
                </tr>
                <tr>
                    <td id="edocKorName" class="small text-center d-flex flex-column align-items-center">
                        <div>
                            <c:choose>
                                <c:when test="${edocDetail.apprStatus2 == '1'}">
                                    <i class='bx bx-md bx-check-shield' style="color: #00b300"></i>
                                </c:when>
                                <c:when test="${edocDetail.apprStatus2 == '-1'}">
                                    <i class='bx bx-md bx-registered' style="color: #b00"></i>
                                </c:when>
                                <c:otherwise>
                                    <span>&nbsp;</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div>${edocDetail.approverName2}</div>
                    </td>
                </tr>
                <tr>
                    <td id="edocApprovalDate" class="small text-center approver-td-tag">
                        ${edocDetail.apprDate2 == null ? '결재일' : edocDetail.apprDate2}
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
</c:if>