<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 작성</title>
</head>
<body>
	<jsp:include page="/WEB-INF/inc/top.jsp"></jsp:include>
	
    <!-- 로그인 -->
    <section class="page-section" id="contact" style="margin-top:150px">
        <div class="container">
            <!-- Contact Section Heading-->
            <h2 class="page-section-heading text-center text-uppercase text-secondary mb-0">글 작성</h2>
            <!-- Icon Divider-->
            <div class="divider-custom">
                <div class="divider-custom-line"></div>
                <div class="divider-custom-icon"><i class="fas fa-star"></i></div>
                <div class="divider-custom-line"></div>
            </div>
            <!-- Contact Section Form-->
            <div class="row justify-content-center">
                <div class="col-lg-8 col-xl-7">
                    <form id="contactForm" action="${pageContext.request.contextPath}/boardWriteDo" method="post" data-sb-form-api-token="API_TOKEN">
                       	<div class="mb-3">
                       		<label>제목</label>
                       		<input type="text" class="form-control" name="boardTitle">
                       	</div>
                       	<div class="mb-3">
                       		<label>내용</label>
                       		<textarea class="form-control" name="boardContent" style="height:20rem"></textarea>
                       	</div>
                       	<input type="hidden" name="memId" value="${sessionScope.login.memId }">
                        <button class="btn btn-primary btn-xl" id="submitButton" type="submit">등록</button>
                    </form>
                </div>
            </div>
        </div>
    </section>
   	<!-- 회원가입 -->
	
	<jsp:include page="/WEB-INF/inc/footer.jsp"></jsp:include>        
</body>
</html>