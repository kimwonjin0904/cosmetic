<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 수정</title>
</head>
<body>
	<jsp:include page="/WEB-INF/inc/top.jsp"></jsp:include>
	
    <!-- 로그인 -->
    <section class="page-section" id="contact" style="margin-top:150px">
        <div class="container">
            <!-- Contact Section Heading-->
            <h2 class="page-section-heading text-center text-uppercase text-secondary mb-0">게시글 수정</h2>
            <!-- Icon Divider-->
            <div class="divider-custom">
                <div class="divider-custom-line"></div>
                <div class="divider-custom-icon"><i class="fas fa-star"></i></div>
                <div class="divider-custom-line"></div>
            </div>
            <!-- Contact Section Form-->
            <div class="row justify-content-center">
                <div class="col-lg-8 col-xl-7">
                	<form method="post" action="<c:url value="boardEditDo" />" >
                       	<div class="mb-3">
                       		<label>제목</label>
                       		<input type="text" class="form-control" name="boardTitle" value="${board.boardTitle}">
                       	</div>
                       	<div class="mb-3">
                       		<label>내용</label>
                       		<textarea class="form-control" name="boardContent">${board.boardContent }</textarea>
                       	</div>
               			<input type="hidden" name="boardNo" value="${board.boardNo }">
               			<input type="hidden" name="memId" value="${sessionScope.login.memId}">
               			<input class="btn btn-warning btn-lx" type="submit" name="action" value="수정" >
               		</form>
                </div>
            </div>
        </div>
    </section>
    <script>
		 document.getElementById("boardForm").addEventListener("submit", function(e){
			  var clickBtn = e.submitter;
			  if(clickBtn.value=="삭제"){
				  if(!confirm("정말.. 삭제하시겠습니까?!")){
					  e.preventDefault();  // 취소 
					  return;
				  }
				  this.action = "<c:url value='/boardDeleteDo' />";
			  }
		 });
    
    
    </script>
	<jsp:include page="/WEB-INF/inc/footer.jsp"></jsp:include>        
</body>
</html>