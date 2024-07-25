<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<style>
  .edocForm {
    margin-bottom: 0rem !important;
  }
  
  .typeDraftThTag {
    color: #fff !important;
    background-color: rgba(105, 108, 255, 0.6) !important;
    padding: 0.1rem !important;
  }
  
  .typeDraftTdTag {
    background-color: rgba(255, 255, 255, 1) !important;
  }
  
  .typeDraftTdTag textarea {
    resize: none;
  }
</style>
<div class="table-responsive text-nowrap">
    <table class="table table-bordered edocForm">
        <tbody>
            <tr>
                <th class="text-center typeDraftThTag">제목</th>
                <td class="typeDraftTdTag" colspan="3">
                    ${edocDetail.edocTitle}
                </td>
            </tr>
            <tr>
                <th class="text-center typeDraftThTag">시작일자</th>
                <td class="typeDraftTdTag">${formDetail.vacStartDate}</td>
                <th class="text-center typeDraftThTag">종료일자</th>
                <td class="typeDraftTdTag">${formDetail.vacEndDate}</td>
            </tr>
            <tr>
                <th class="text-center typeDraftThTag">휴가종류</th>
                <td class="typeDraftTdTag" colspan="3">
                   ${formDetail.vacType}
                </td>
            </tr>
            <tr>
                <th class="text-center typeDraftThTag" colspan="4">사유</th>
            </tr>
            <tr>
                <td class="typeDraftTdTag" colspan="4"><textarea class="form-control" rows="4" name="vacReason" readonly>${formDetail.vacReason}</textarea></td>
            </tr>
            <tr>
                <th class="text-center typeDraftThTag">파일첨부</th>
                <td class="typeDraftTdTag" colspan="4">
                    ${edocDetail.edocFileName == null ? '첨부파일 없슴':edocDetail.edocFileName }
                </td>
            </tr>
        </tbody>
    </table>
</div>