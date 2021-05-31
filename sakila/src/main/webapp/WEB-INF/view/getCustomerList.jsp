<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>getCustomerList</title>
<!-- bootstrap을 사용하기 위한 CDN주소 -->
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
<!-- Optional theme -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
<!-- jquery를 사용하기위한 CDN주소 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!-- bootstrap javascript소스를 사용하기 위한 CDN주소 -->
<!-- Latest compiled and minified JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
<script>
$(document).ready(function(){
	$('#searchBtn').click(function(){
		console.log('searchBtn click!');
		$('#searchForm').submit();
	});
	
	$('#selectBtn').click(function(){
		console.log('selectBtn click!');
		$('#selectForm').submit();
	});
});
</script>
</head>
<body>
<div class="container">
	<h1>getCustomerList</h1>
	
	<form id="selectForm" action="${pageContext.request.contextPath}/admin/getCustomerList" method="get">
		상세검색
		<select name="storeId">
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
	
	
		<button id="selectBtn" type="button">검색</button>
	</form>
	
	<c:if test="${searchWord != null || storeId != null}">
	<div>검색결과 (${totalPage})</div>
	</c:if>
	
	<table class="table table-striped">
		<thead>
			<tr>
				<td>customerName</td>
				<td>phone</td>
				<td>storeId</td>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="c" items="${customerList}">
				<tr>
					<td>
						<a href="${pageContext.request.contextPath}/admin/getCustomerOne?customerId=${c.customerId}">${c.name}</a>
						
					</td>
					<td>${c.phone}</td>
					<td>${c.storeId}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	
	<!-- 페이징 -->
	<ul class="pager">
	<c:if test="${currentPage>1}">
		<li class="previous"><a class="btn btn-default" href="${pageContext.request.contextPath}/admin/getCustomerList?currentPage=${currentPage-1}&searchWord=${searchWord}">이전</a></li>
	</c:if>
	<c:if test="${currentPage<lastPage}">
		<li class="next"><a class="btn btn-default" href="${pageContext.request.contextPath}/admin/getCustomerList?currentPage=${currentPage+1}&searchWord=${searchWord}">다음</a></li>
	</c:if>
	</ul>
	
	<form id="searchForm" class="" action="${pageContext.request.contextPath}/admin/getCustomerList" method="get">
		고객 검색 : 
		<input class="" type="text" name="searchWord">
		<button id="searchBtn" type="button">검색</button>
	</form>
	<br>
	<a class="btn btn-default" href="${pageContext.request.contextPath}/admin/addCustomer">고객추가</a>
</div>
</body>
</html>