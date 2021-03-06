<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>getRentalList</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
<!-- JQuery CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!-- VENDOR CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/vendor/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/vendor/font-awesome/css/font-awesome.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/vendor/linearicons/style.css">
<!-- MAIN CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
<!-- GOOGLE FONTS -->
<link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700" rel="stylesheet">
<script>
$(document).ready(function(){
	$('#searchBtn').click(function(){
		console.log('searchBtn click!');
		$('#searchForm').submit();
	});
})
</script>
</head>
<body>
<div id="wrapper">
	<!-- NAVBAR -->
	<nav class="navbar navbar-default navbar-fixed-top">
		<div class="brand">
			<a href="${pageContext.request.contextPath}/index"><img src="${pageContext.request.contextPath}/assets/img/sakila.png" class="img-responsive logo"></a>
		</div>
		<div class="container-fluid">
			<div class="navbar-btn">
				<button type="button" class="btn-toggle-fullwidth"><i class="lnr lnr-arrow-left-circle"></i></button>
			</div>
			
			<div class="navbar-btn navbar-btn-right">
				<i class="fa fa-rocket"></i> <span>${loginStaff.email}</span>
			</div>
		</div>
	</nav>
	
	<!-- LEFT SIDEBAR -->
	<div id="sidebar-nav" class="sidebar">
		<div class="sidebar-scroll">
			<nav>
				<ul class="nav">
					<li><jsp:include page="/WEB-INF/view/inc/mainMenu.jsp"></jsp:include></li>
				</ul>
			</nav>
		</div>
	</div>
	
	<!-- MAIN -->
	<div class="main">
		<!-- MAIN CONTENT -->
		<div class="main-content">
			<div class="container-fluid">
				<!-- OVERVIEW -->
				<h3 class="page-title">???????????????</h3>
				<div class="panel panel-headline">
					<div class="panel-body">
						<form id="searchForm" action="${pageContext.request.contextPath}/admin/getRentalList" method="get">
							<select name="storeId" class="form-control" style="width:120px;">
								<option value="">==store==</option>
								<c:if test="${storeId == 1}">
									<option value="1" selected>1</option>
								</c:if>
								<c:if test="${storeId != 1}">
									<option value="1">1</option>
								</c:if>
								<c:if test="${storeId == 2}">
									<option value="2" selected>2</option>
								</c:if>
								<c:if test="${storeId != 2}">
									<option value="2">2</option>
								</c:if>
							</select>
							<input type="text" name="searchWord"  class="form-control" style="width:200px;" placeholder="title ??????">
							<button id="searchBtn" class="btn btn-default" type="button">??????</button>
							<a class="btn btn-default" href="${pageContext.request.contextPath}/admin/getCustomerList"><i class="fa fa-refresh"></i></a>
						</form>
						<br>
							
						<div>
							<span>&nbsp;</span>
							<c:if test="${storeId != null}">
								[store${storeId}]
							</c:if>	
							<c:if test="${searchWord != null}">
								"${searchWord}"
							</c:if>
							<c:if test="${storeId != null || searchWord != null}">
								???????????? (${totalRow})
							</c:if>
						</div>
						
						<table class="table table-striped">
							<thead>
								<tr>
									<th width="22%">name</th>
									<th width="38%">title</th>
									<th width="20%">rentalDate</th>
									<th width="10%">storeId</th>
									<th width="10%">paymentFee</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="r" items="${rentalList}">
									<tr>
										<td>${r.name}</td>
										<td>${r.title}</td>
										<td>${r.rentalDate}</td>
										<td>${r.storeId}</td>
										<td>${r.paymentFee}</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					
						<ul class="pager">
					        <c:if test="${currentPage > 1}">
					            <li class="previous"><a class="btn btn-default" href="${pageContext.request.contextPath}/admin/getRentalList?currentPage=${currentPage-1}&searchWord=${searchWord}&storeId=${storeId}">??????</a></li>
					        </c:if>
					        <c:if test="${currentPage < lastPage}">
					            <li class="next"><a class="btn btn-default" href="${pageContext.request.contextPath}/admin/getRentalList?currentPage=${currentPage+1}&searchWord=${searchWord}&storeId=${storeId}">??????</a></li>
					        </c:if>
					    </ul>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<!-- ?????? ????????????
	rental; rentalId ?????? ?????? ???.
	payment; ???????????? ?????? ????????? ????????? paymentId??? ?????? ????????????. -> rental fee, ????????? ????????? ?????? ?????? 
	rental??? payment??? paymentdate, rentaldate??? ??????. -> ??? ????????? id??? ?????? ????????????.
	??????, payment?????? rentalId null?????? ?????? ?????? ???????????? ????????????..
	
	????????? ??? 1) ??????????????? ????????? ?????? -> ?????? ???????????? ???????????? -> payment??? amount??? ???????????????, if rental??? return_date??? rentalDuration??? ????????? ?????? +1??????, *2????????? replaceCost
	????????? ??? 2) ??????????????? ??? ????????? ?????? -> amount??? ?????? 0 -> ????????? ????????? amount ?????????, ???????????? ?????? ?????? ??????????????????.
	-->
	
	<!-- ?????? ????????????
	rental; return_date ????????? update ??????
	payment; lastUpdate ????????? update. ????????????????????? ??????????????? ????????? ????????????.
	-->
</div>
<!-- Javascript -->
<script src="${pageContext.request.contextPath}/assets/vendor/jquery/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/vendor/bootstrap/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/vendor/jquery-slimscroll/jquery.slimscroll.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/scripts/klorofil-common.js"></script>
</body>
</html>