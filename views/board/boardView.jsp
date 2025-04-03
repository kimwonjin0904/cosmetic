<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 게시판</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" >
</head>
<body>
	<jsp:include page="/WEB-INF/inc/top.jsp"></jsp:include>
	
    <section class="page-section" id="contact" style="margin-top:150px">
        <div class="container">
        	
        	<!-- ✅ 검색 & 카테고리 필터 -->
        	<div class="row g-0 justify-content-md-center">
				<div class="col-auto col-sm-6 mb-3">
					<form name="search" action="<c:url value='/boardView'/>" method="get">
						<input type="hidden" name="curPage" id="curPage" value="${searchVO.curPage }">
						<input type="hidden" name="rowSizePerPage" value="${searchVO.rowSizePerPage }">
						
						<div class="input-group">
							<!-- 🔹 검색 조건 -->
							<select id="id_searchType" name="searchType" class="form-control input-sm">
								<option value="T" ${searchVO.searchType eq 'T' ? 'selected' : ''}>제목</option>
								<option value="W" ${searchVO.searchType eq 'W' ? 'selected' : ''}>작성자</option>
								<option value="C" ${searchVO.searchType eq 'C' ? 'selected' : ''}>내용</option>
							</select>
							
							<!-- 🔹 카테고리 필터 -->
							<select id="id_searchCategory" name="searchCategory" class="form-control input-sm">
								<option value="">-- 전체 --</option>
								<c:forEach items="${categoryList}" var="category">
									<option value="${category.code}" ${searchVO.searchCategory eq category.code ? 'selected' : ''}>
										${category.name}
									</option>
								</c:forEach>
							</select>
							
							<!-- 🔹 검색어 입력 -->
							<input class="form-control shadow-none search" value="${searchVO.searchWord }" 
								name="searchWord" type="search" placeholder="검색어" aria-label="search" />

							<button type="submit" class="btn btn-primary">검색</button>
						</div>
					</form>
				</div>
			</div>
        	
        	<table class="table table-hover">
        		<thead>
        			<tr>
        				<td>글번호</td><td>제목</td><td>작성자</td><td>수정일</td>
        			</tr>
        		</thead>
        		<tbody>
        			<c:if test="${empty boardList}">
        				<tr>
        					<td colspan="4">등록된 게시글이 없습니다.</td>
        				</tr>
        			</c:if>
        			<c:forEach items="${boardList}" var="board">
	        			<tr>
	        				<td>${board.boardNo}</td>
	        				<td><a href="<c:url value='/getBoard?boardNo=${board.boardNo}' />">
	        					${board.boardTitle}</a>
	        				</td>
	        				<td>${board.memNm}</td>
	        				<td>${board.updateDt}</td>
	        			</tr>
        			</c:forEach>
        		</tbody>
        	</table>

        	<!-- ✅ 페이징 처리 -->
			<nav>
				<ul class="pagination justify-content-center">
					<c:if test="${searchVO.firstPage > 1}">
						<li class="page-item">
							<a class="page-link" href="#" data-page="${searchVO.firstPage-1}">&laquo;</a>
						</li>
					</c:if>
					<c:forEach begin="${searchVO.firstPage }" end="${searchVO.lastPage }" var="i">
						<li class="page-item ${searchVO.curPage == i ? 'active' : ''}">
							<a class="page-link" href="#" data-page="${i}">${i}</a>
						</li>
					</c:forEach>
					<c:if test="${searchVO.lastPage < searchVO.totalPageCount}">
						<li class="page-item">
							<a class="page-link" href="#" data-page="${searchVO.lastPage+1}">&raquo;</a>
						</li>
					</c:if>
				</ul>
			</nav>

        	<a href="${pageContext.request.contextPath}/boardWriteView">
        		 <button type="button" class="btn btn-primary">글쓰기</button>
        	</a>
        </div>
    </section>

	<jsp:include page="/WEB-INF/inc/footer.jsp"></jsp:include>        
</body>

<script type="text/javascript">
	$(document).ready(function(){
		// 페이징 처리
		$("ul.pagination li a[data-page]").click(function(e){
			e.preventDefault();
			$("#curPage").val($(this).data("page"));
			$("form[name='search']").submit();
		});
	});
</script>
</html>
