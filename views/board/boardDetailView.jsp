<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글</title>
</head>
<body>
	<jsp:include page="/WEB-INF/inc/top.jsp"></jsp:include>
	
    <!-- 로그인 -->
    <section class="page-section" id="contact" style="margin-top:150px">
        <div class="container">
            <!-- Contact Section Heading-->
            <h2 class="page-section-heading text-center text-uppercase text-secondary mb-0">게시글</h2>
            <!-- Icon Divider-->
            <div class="divider-custom">
                <div class="divider-custom-line"></div>
                <div class="divider-custom-icon"><i class="fas fa-star"></i></div>
                <div class="divider-custom-line"></div>
            </div>
            <!-- Contact Section Form-->
            <div class="row justify-content-center">
                <div class="col-lg-8 col-xl-7">
                       	<div class="mb-3">
                       		<label>제목</label>
                       		<h6>${board.boardTitle}</h6>
                       	</div>
                       	<div class="mb-3">
                       		<label>작성자</label>
                       		<h6>${board.memNm}</h6>
                       	</div>
                       	<div class="mb-3">
                       		<label>수정일</label>
                       		<h6>${board.updateDt}</h6>
                       	</div>
                       	<div class="mb-3">
                       		<label>내용</label>
                       		<textarea class="form-control" readonly>${board.boardContent }</textarea>
                       	</div>
                    		<form id="boardForm" action="<c:url value="/boardEditView" />" method="post">
	                       	<c:if test="${sessionScope.login.memId == board.memId }">
	                      			<input type="hidden" name="boardNo" value="${board.boardNo }">
	                      			<input class="btn btn-warning btn-lx" type="submit" name="action" value="수정" >
	                      			<input class="btn btn-danger btn-lx" type="submit"  name="action" value="삭제" >
	   	                   	</c:if>
                      		</form>
                </div>
            </div>
			<!-- 댓글 -->
				<!-- 댓글작성 -->
				<div class="row justify-content-center pt-1">
					<div class="col-lg-8 col-xl-7 d-flex">
						<div class="col-lg-10">
							<input type="text" id="replyInput" class="form-control">
						</div>
						<div class="col-lg-2">
							<button type="button" onclick="fn_write()" class="btn btn-info me-2">등록</button>
						</div>
					</div>
				</div>
				<!-- 댓글출력 -->
				<div class="row justify-content-center pt-1">
					<div class="col-lg-8 col-xl-7 d-flex">
						<table class="table">
							<tbody id="replyBody">
								<c:forEach items="${replyList}" var="reply">
									<tr id="${reply.replyNo}">
										<td>${reply.replyContent }</td>
										<td>${reply.memNm }</td>
										<td>${reply.replyDate }</td>
										<c:if test="${sessionScope.login.memId == reply.memId }">
											<td><a onclick="fn_del('${reply.replyNo}')">X</a></td>
										</c:if>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			<!-- 댓글 -->
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
			  }else{
				  this.action = "<c:url value='/boardEditView' />";
			  }
		 });
    	
		 function fn_write(){
			  var memId = '${sessionScope.login.memId}';
			  var boardNo = '${board.boardNo}';
			  var msg = $("#replyInput").val();
			  if(memId == ''){
				  alert("댓글은 로그인 해야함!!");
				  return;
			  }
			  if(msg == ''){
				  alert("내용을 작성해주세요!!");
				  return;
			  }
			  
			  var sendData = JSON.stringify({"memId":memId
				                           , "boardNo":boardNo
				                           , "replyContent":msg});
			  console.log(sendData);
			  $.ajax({
				  url : '<c:url value="/writeReplyDo" />'
				 ,type : 'POST'
				 ,contentType : 'application/json'
				 ,dataType: 'json'
				 ,data : sendData
				 ,success:function(res){
					 console.log("응답!");
					 console.log(res);
					 $("#replyInput").val('');
					 var str ="";
					 str += "<tr id='"+res.replyNo+"'>";
					 str += "<td>" +res.replyContent + "</td>";
					 str += "<td>" +res.memNm + "</td>";
					 str += "<td>" +res.replyDate + "</td>";
					 str += "<td><a onclick='fn_del(\""+res.replyNo +"\")' >x</a></td>";
					 str += "</tr>";
					 $("#replyBody").prepend(str);
				 }
				 ,error : function(e){
					 console.log(e);
				 }
			  });
		 }
		 
		 // 댓글 삭제 
		 function fn_del(p_reNo){
			 if(confirm("정말로 삭제!?")){
				 $.ajax({
					   url : '<c:url value="/delReplyDo" />'
					  ,type : 'POST'
					  ,contentType: 'application/json'
					  ,dataType:'text'
					  ,data : JSON.stringify({"replyNo":p_reNo})
					  ,success:function(res){
						  console.log("정상 처리");
						  console.log(res);
						  if(res == "s"){
							  $("#"+p_reNo).remove();
						  }
					  },error:function(e){
						  console.log(e);
					  }
				 });
			 }
		 }
		 
    
    </script>
	<jsp:include page="/WEB-INF/inc/footer.jsp"></jsp:include>        
</body>
</html>