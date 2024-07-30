<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일정수정 - GAEnt.</title>
<style>
.footer-btn {
	text-align: right;
}

.del-confirm {
    text-align: center;
}
</style>
</head>
<body>
	<c:forEach var="vo" items="${eventOne}">
		<form action="/gaent/calendar/modifyEvent" method="post">
			<div class="card mb-4">
		      <div class="card-body">
		      	<div class="mb-3">
		          <input type="hidden" name="calNum" value="${vo.calNum}">
		          <label for="calType" class="form-label">일정타입</label>
		          <c:choose>
					<c:when test="${vo.calType eq 'public'}">
						<select name="calType" class="form-select">
						    <option value="public" selected="selected">개인(공개)</option>
						    <option value="private">개인(제한)</option>
						    <option value="tpublic">팀(공개)</option>
						    <option value="tprivate">팀(제한)</option>
						    <option value="corp">전사(전체)</option>
						    <option value="artist">아티스트(전체)</option>
						</select>
					</c:when>
					<c:when test="${vo.calType eq 'private'}">
						<select name="calType" class="form-select">
						    <option value="public">개인(공개)</option>
						    <option value="private" selected="selected">개인(제한)</option>
						    <option value="tpublic">팀(공개)</option>
						    <option value="tprivate">팀(제한)</option>
						    <option value="corp">전사(전체)</option>
						    <option value="artist">아티스트(전체)</option>
						</select>
					</c:when>
					<c:when test="${vo.calType eq 'tpublic'}">
						<select name="calType" class="form-select">
						    <option value="public">개인(공개)</option>
						    <option value="private">개인(제한)</option>
						    <option value="tpublic" selected="selected">팀(공개)</option>
						    <option value="tprivate">팀(제한)</option>
						    <option value="corp">전사(전체)</option>
						    <option value="artist">아티스트(전체)</option>
						</select>
					</c:when>
					<c:when test="${vo.calType eq 'tprivate'}">
						<select name="calType" class="form-select">
						    <option value="public">개인(공개)</option>
						    <option value="private">개인(제한)</option>
						    <option value="tpublic">팀(공개)</option>
						    <option value="tprivate" selected="selected">팀(제한)</option>
						    <option value="corp">전사(전체)</option>
						    <option value="artist">아티스트(전체)</option>
						</select>
					</c:when>
					<c:when test="${vo.calType eq 'corp'}">
						<select name="calType" class="form-select">
						    <option value="public">개인(공개)</option>
						    <option value="private">개인(제한)</option>
						    <option value="tpublic">팀(공개)</option>
						    <option value="tprivate">팀(제한)</option>
						    <option value="corp" selected="selected">전사(전체)</option>
						    <option value="artist">아티스트(전체)</option>
						</select>
					</c:when>
					<c:when test="${vo.calType eq 'artist'}">
						<select name="calType" class="form-select">
						    <option value="public">개인(공개)</option>
						    <option value="private">개인(제한)</option>
						    <option value="tpublic">팀(공개)</option>
						    <option value="tprivate">팀(제한)</option>
						    <option value="corp">전사(전체)</option>
						    <option value="artist" selected="selected">아티스트(전체)</option>
						</select>
					</c:when>
				</c:choose>
		        </div>
		          <input name="calWriter" id="calWriter" class="form-control" type="hidden" placeholder="제목을 입력해주세요." value="${loginInfo.empCode}">
		        <div class="mb-3">
		          <label for="calTitle" class="form-label">제목</label>
		          <input name="calTitle" id="calContent" class="form-control" type="text" placeholder="내용을 입력해주세요." value="${vo.calTitle}">
		        </div>
		        <div class="mb-3">
		          <label for="calContent" class="form-label">내용</label>
		          <input name="calContent" id="calContent" class="form-control" type="text" placeholder="내용을 입력해주세요." value="${vo.calContent}">
		        </div>
		        <div class="mb-3">
		          <label for="calStartDate" class="form-label">일정시작일</label>
		          <input name="calStartDate" class="form-control" type="datetime-local" id="html5-datetime-local-input" value="${vo.calStartDate}">
		        </div>
		        <div class="mb-3">
		          <label for="calEndDate" class="form-label">일정종료일</label>
		          <input name="calEndDate" class="form-control" type="datetime-local" id="html5-datetime-local-input" value="${vo.calEndDate}">
		        </div>
				<div class="mb-3">
		          <label for="calTargetType" class="form-label">일정분류</label>
					<select name="calTargetType" class="form-select">
						<c:choose>
							<c:when test="${vo.calTargetType eq loginInfo.empCode}">
							    <option value="${loginInfo.empCode}" selected="selected">개인</option>
							    <option value="110">인사팀</option>
							    <option value="210">경영팀</option>
							    <option value="220">회계팀</option>
							    <option value="310">기획팀</option>
							    <option value="320">제작팀</option>
							    <option value="410">홍보팀</option>
							    <option value="420">영업팀</option>
							    <option value="510">매니지먼트팀</option>
							    <option value="520">스타일팀</option>
							    <option value="10">전사</option>
							    <option value="900">아티스트</option>
							</c:when>
							<c:when test="${vo.calTargetType eq 110}">
							    <option value="${loginInfo.empCode}">개인</option>
							    <option value="110" selected="selected">인사팀</option>
							    <option value="210">경영팀</option>
							    <option value="220">회계팀</option>
							    <option value="310">기획팀</option>
							    <option value="320">제작팀</option>
							    <option value="410">홍보팀</option>
							    <option value="420">영업팀</option>
							    <option value="510">매니지먼트팀</option>
							    <option value="520">스타일팀</option>
							    <option value="10">전사</option>
							    <option value="900">아티스트</option>
							</c:when>
							<c:when test="${vo.calTargetType eq 210}">
							    <option value="${loginInfo.empCode}">개인</option>
							    <option value="110">인사팀</option>
							    <option value="210" selected="selected">경영팀</option>
							    <option value="220">회계팀</option>
							    <option value="310">기획팀</option>
							    <option value="320">제작팀</option>
							    <option value="410">홍보팀</option>
							    <option value="420">영업팀</option>
							    <option value="510">매니지먼트팀</option>
							    <option value="520">스타일팀</option>
							    <option value="10">전사</option>
							    <option value="900">아티스트</option>
							</c:when>
							<c:when test="${vo.calTargetType eq 220}">
							    <option value="${loginInfo.empCode}">개인</option>
							    <option value="110">인사팀</option>
							    <option value="210">경영팀</option>
							    <option value="220" selected="selected">회계팀</option>
							    <option value="310">기획팀</option>
							    <option value="320">제작팀</option>
							    <option value="410">홍보팀</option>
							    <option value="420">영업팀</option>
							    <option value="510">매니지먼트팀</option>
							    <option value="520">스타일팀</option>
							    <option value="10">전사</option>
							    <option value="900">아티스트</option>
							</c:when>
							<c:when test="${vo.calTargetType eq 310}">
							    <option value="${loginInfo.empCode}">개인</option>
							    <option value="110">인사팀</option>
							    <option value="210">경영팀</option>
							    <option value="220">회계팀</option>
							    <option value="310" selected="selected">기획팀</option>
							    <option value="320">제작팀</option>
							    <option value="410">홍보팀</option>
							    <option value="420">영업팀</option>
							    <option value="510">매니지먼트팀</option>
							    <option value="520">스타일팀</option>
							    <option value="10">전사</option>
							    <option value="900">아티스트</option>
							</c:when>
							<c:when test="${vo.calTargetType eq 320}">
							    <option value="${loginInfo.empCode}">개인</option>
							    <option value="110">인사팀</option>
							    <option value="210">경영팀</option>
							    <option value="220">회계팀</option>
							    <option value="310">기획팀</option>
							    <option value="320" selected="selected">제작팀</option>
							    <option value="410">홍보팀</option>
							    <option value="420">영업팀</option>
							    <option value="510">매니지먼트팀</option>
							    <option value="520">스타일팀</option>
							    <option value="10">전사</option>
							    <option value="900">아티스트</option>
							</c:when>
							<c:when test="${vo.calTargetType eq 410}">
							    <option value="${loginInfo.empCode}">개인</option>
							    <option value="110">인사팀</option>
							    <option value="210">경영팀</option>
							    <option value="220">회계팀</option>
							    <option value="310">기획팀</option>
							    <option value="320">제작팀</option>
							    <option value="410" selected="selected">홍보팀</option>
							    <option value="420">영업팀</option>
							    <option value="510">매니지먼트팀</option>
							    <option value="520">스타일팀</option>
							    <option value="10">전사</option>
							    <option value="900">아티스트</option>
							</c:when>
							<c:when test="${vo.calTargetType eq 420}">
							    <option value="${loginInfo.empCode}">개인</option>
							    <option value="110">인사팀</option>
							    <option value="210">경영팀</option>
							    <option value="220">회계팀</option>
							    <option value="310">기획팀</option>
							    <option value="320">제작팀</option>
							    <option value="410">홍보팀</option>
							    <option value="420" selected="selected">영업팀</option>
							    <option value="510">매니지먼트팀</option>
							    <option value="520">스타일팀</option>
							    <option value="10">전사</option>
							    <option value="900">아티스트</option>
							</c:when>
							<c:when test="${vo.calTargetType eq 510}">
							    <option value="${loginInfo.empCode}">개인</option>
							    <option value="110">인사팀</option>
							    <option value="210">경영팀</option>
							    <option value="220">회계팀</option>
							    <option value="310">기획팀</option>
							    <option value="320">제작팀</option>
							    <option value="410">홍보팀</option>
							    <option value="420">영업팀</option>
							    <option value="510" selected="selected">매니지먼트팀</option>
							    <option value="520">스타일팀</option>
							    <option value="10">전사</option>
							    <option value="900">아티스트</option>
							</c:when>
							<c:when test="${vo.calTargetType eq 520}">
							    <option value="${loginInfo.empCode}">개인</option>
							    <option value="110">인사팀</option>
							    <option value="210">경영팀</option>
							    <option value="220">회계팀</option>
							    <option value="310">기획팀</option>
							    <option value="320">제작팀</option>
							    <option value="410">홍보팀</option>
							    <option value="420">영업팀</option>
							    <option value="510">매니지먼트팀</option>
							    <option value="520" selected="selected">스타일팀</option>
							    <option value="10">전사</option>
							    <option value="900">아티스트</option>
							</c:when>
							<c:when test="${vo.calTargetType eq 10}">
							    <option value="${loginInfo.empCode}">개인</option>
							    <option value="110">인사팀</option>
							    <option value="210">경영팀</option>
							    <option value="220">회계팀</option>
							    <option value="310">기획팀</option>
							    <option value="320">제작팀</option>
							    <option value="410">홍보팀</option>
							    <option value="420">영업팀</option>
							    <option value="510">매니지먼트팀</option>
							    <option value="520">스타일팀</option>
							    <option value="10" selected="selected">전사</option>
							    <option value="900">아티스트</option>
							</c:when>
							<c:when test="${vo.calTargetType eq 900}">
							    <option value="${loginInfo.empCode}">개인</option>
							    <option value="110">인사팀</option>
							    <option value="210">경영팀</option>
							    <option value="220">회계팀</option>
							    <option value="310">기획팀</option>
							    <option value="320">제작팀</option>
							    <option value="410">홍보팀</option>
							    <option value="420">영업팀</option>
							    <option value="510">매니지먼트팀</option>
							    <option value="520">스타일팀</option>
							    <option value="10">전사</option>
							    <option value="900" selected="selected">아티스트</option>
							</c:when>
						</c:choose>
					</select>
		      </div>
		    </div>
		  </div>
		  <div class="footer-btn">
			  <a href="/gaent/calendar/removeEvent?calNum=${vo.calNum}" class="delete-link btn btn-danger">삭제</a>
			  <!-- 삭제 확인용 모달 시작 -->
	            <div class="modal fade" id="deleteModal" tabindex="-1" aria-hidden="true">
	              <div class="modal-dialog modal-sm" role="document">
	                <div class="modal-content">
	                  <div class="modal-header">
	                    <h5 class="modal-title" id="exampleModalLabel2">일정삭제</h5>
	                  </div>
	                  <div class="modal-body del-confirm">일정을 삭제하시겠습니까?</div>
	                  <div class="modal-footer">
	                    <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">닫기</button>
	                    <button type="button" class="btn btn-danger" id="confirmDeleteBtn">삭제</button>
	                  </div>
	                </div>
	              </div>
	            </div>
	            <script>
	            // 삭제 링크 클릭 시 모달 띄우기
	            $(document).ready(function() {
	              $('a.delete-link').on('click', function(e) {
	                e.preventDefault(); // 기본 동작(링크 이동) 방지
	    
	                let deleteUrl = $(this).attr('href'); // 삭제할 링크 주소 가져오기
	                $('#deleteModal').modal('show'); // 모달 띄우기
	    
	                // 모달 안의 삭제 버튼 클릭 시
	                $('#confirmDeleteBtn').on('click', function() {
	                  window.location.href = deleteUrl; // 삭제할 링크로 이동
	                });
	              });
	            });
	          </script>
	          <!-- 삭제 확인용 모달 시작 -->
			  <button type="submit" class="btn btn-primary">수정</button>
			  <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
		  </div>
	</form>
	</c:forEach>

</body>
</html>