<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>boardOne</title>

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
	$('#addCommentBtn').click(function(){
		if ($('#commentContent').val() == '') {
			alert('commentContent을 입력하세요');
			$('#commentContent').focus();
		} else if ($('#username').val() == '') {
			alert('userName을 입력하세요');
			$('#username').focus();
		} else {
			$('#addCommentForm').submit();
		}
	});
});

</script>
</head>
<body>
<div class="container">
	<h1>boardOne</h1>
		<table class="table">
			<tbody>
				<tr>
					<td>boardId</td>
					<td>${boardOne.boardId}</td>
				</tr>
				<tr>
					<td>boardTitle</td>
					<td>${boardOne.boardTitle}</td>
				</tr>
				<tr>
					<td>boardContent</td>
					<td>${boardOne.boardContent}</td>
				</tr>
				<tr>
					<td>userName</td>
					<td>${boardOne.username}</td>
				</tr>
				<tr>
					<td>insertDate</td>
					<td>${boardOne.insertDate}</td>
				</tr>
				<tr>
					<td>boardfile</td>
					<td>
						<!-- 보드파일을 출력하는 반복문 코드 구현 -->
						<c:forEach var="f" items="${boardfileList}">
							<div>
								<a href="${pageContext.request.contextPath}/resource/${f.boardfileName}">${f.boardfileName}</a>
								
								<!-- 로그인 당사자가 글쓴이일 경우에만 파일삭제 할 수 있음 -->
								<c:if test="${loginStaff.staffId == boardOne.staffId}">
									<a href="${pageContext.request.contextPath}/admin/removeBoardfile?boardfileId=${f.boardfileId}&boardId=${f.boardId}&boardfileName=${f.boardfileName}"><button class="btn btn-default" type="button">삭제</button></a>
								</c:if>
							</div>
						</c:forEach>
						
						<!-- 로그인 당사자가 글쓴이일 경우에만 파일추가 할 수 있음 -->
						<c:if test="${loginStaff.staffId == boardOne.staffId}">
							<div><a href="${pageContext.request.contextPath}/admin/addBoardfile?boardId=${boardOne.boardId}"><button class="btn btn-default" type="button">파일추가</button></a></div>
						</c:if>
					</td>
				</tr>
			</tbody>
		</table>
		
	<!-- 로그인 당사자가 글쓴이일 경우에만 수정/삭제 버튼 볼 수 있음 -->
	<c:if test="${loginStaff.staffId == boardOne.staffId}">
		<a href="${pageContext.request.contextPath}/admin/modifyBoard?boardId=${boardOne.boardId}"><button class="btn btn-default" type="button">수정</button></a>
		<a href="${pageContext.request.contextPath}/admin/removeBoard?boardId=${boardOne.boardId}"><button class="btn btn-default" type="button">삭제</button></a>
	</c:if>
	<a class="btn btn-default" href="${pageContext.request.contextPath}/admin/getBoardList">글목록</a>	
	
	<hr>
	
	<!-- 댓글 리스트 추가 -->
	<div>comment 추가</div>
	<form id="addCommentForm" action="${pageContext.request.contextPath}/admin/addComment" method="post">
		<input type="hidden" name="boardId" value="${boardOne.boardId}">
		<div class="form-group">
			<textarea id="commentContent" rows="5" cols="50" name="commentContent" class="form-control"></textarea>
		</div>
		<div class="form-group">
			userName
			<input type="text" id="username" name="username" value="${loginStaff.username}" readonly>
			<button type="button" id="addCommentBtn" class="btn btn-default" style="float: right;">추가</button>
		</div>
	</form>
	<hr>
	<div>
		등록된 comment ${commentList.size()}개
	</div>
	<br>
	<c:forEach var="i" items="${commentList}">
		<table class="table" border="1">
			<tr>
				<td>${i.username}</td>
				<td >${i.commentContent}</td>
				<td>
					${i.insertDate}
				
					<!-- 삭제 버튼은 로그인 당사자 자신의 것만 볼 수 있다. -->
					<!-- comment table내 staffId를 참조하지 않고 userName만 적도록 되어있어서. 동명이인은 고려하지 않고 이름이 같으면 삭제하도록 한다(...) -->
					<c:if test="${loginStaff.username == i.username}">
						<a href="${pageContext.request.contextPath}/admin/removeComment?commentId=${i.commentId}&boardId=${boardOne.boardId}">X</a>
					</c:if>
				</td>
			</tr>
		</table>
	</c:forEach>
</div>
</body>
</html>