<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <title>차트</title>
		<!-- 차트관련 -->
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    </head>
    <body id="page-top">
        <!-- 모든 페이지 상단에 들어가는 부분 -->
    	<jsp:include page="/WEB-INF/inc/top.jsp" ></jsp:include>
        <!-- Contact Section-->
        <section class="page-section" id="contact">
            <div class="container" style="margin-top: 100px;">
            	 <h2>영화선택</h2>
            	 <select id="movieSelect">
            	 	<option value="">영화를 선택하세요</option>
            	 	<c:forEach items="${movieList }" var="movie">
            	 		<option value="${movie}" >${movie}</option>
            	 	</c:forEach>
            	 </select>
            	 <canvas id="movieChart" width="600px" height="400px"></canvas>
            </div>
        </section>
        <!-- 모든 페이지 하단에 들어가는 부분 -->
        <!-- Footer-->
		<jsp:include page="/WEB-INF/inc/footer.jsp" ></jsp:include>
		<script>
		  var chartObj = null;
		
		  $(document).ready(function(){		
			  $("#movieSelect").change(function(){
				  var movieNm = $(this).val();
				  if(!movieNm) return;
				  getData(movieNm);
			  });
		  });	
		  function getData(nm){
			  $.ajax({
				 	url : "/movie/getData",
				 	type:"GET",
				 	data: {movieNm: nm},
					success:function(res){
						console.log(res);
						var labels = res.map(row => row.TARGET_DT);
						var sales = res.map(row=> row.SALES_ACC);
						var audi = res.map(row=> row.AUDI_ACC);
						const ctx = document.getElementById("movieChart").getContext("2d");
						if(chartObj){
							chartObj.destroy();
						}
						chartObj = new Chart(ctx, {
							    type: 'line',
							    data: {
							        labels: labels,
							        datasets: [
							            {
							                label: '누적 매출액',
							                data: sales,
							                yAxisID: 'y1',
							                borderWidth: 2,
							                fill: false,
							                borderColor: 'blue',
							                tension: 0.2
							            },
							            {
							                label: '누적 관객수',
							                data: audi,
							                yAxisID: 'y2',
							                borderWidth: 2,
							                fill: false,
							                borderColor: 'green',
							                tension: 0.2
							            }
							        ]
							    },
							    options: {
							        responsive: true,
							        scales: {
							            y1: {
							                type: 'linear',
							                position: 'left',
							                title: { display: true, text: '누적 매출액 (₩)' },
							                ticks: {
							                    callback: function(value) {
							                        return value.toLocaleString();
							                    }
							                }
							            },
							            y2: {
							                type: 'linear',
							                position: 'right',
							                title: { display: true, text: '누적 관객수 (명)' },
							                grid: {
							                    drawOnChartArea: false  // 오른쪽 y축 격자선 제거
							                },
							                ticks: {
							                    callback: function(value) {
							                        return value.toLocaleString();
							                    }
							                }
							            }
							        }
							    }
							});
						
					},
					error:function(e){
						console.log(e);
					}
			  });
		  }
		</script>
    </body>
</html>


