<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="d-flex justify-content-center">
	<div class="w-50">
	
		<%-- 글 게시 --%>
		<div class="textareadiv mt-4">
			<textarea rows="5" cols="75" class="textareacontent" placeholder=" 내용을 입력해주세요"></textarea>
			<div class="d-flex justify-content-between">
				<img alt="" src="">
				<a href="" class="btn btn-info">게시</a>
			</div>
		</div>
		
		<%-- 글 목록 --%>
		<div class="contents-post mt-5">
			<div class="d-flex justify-content-between">
				<h2 class="ml-2">userName</h2>
				<img alt="" src="/static/img/more-icon.png" width="50px" height="50px">
			</div>
			
			<img alt="" src="https://cdn.pixabay.com/photo/2023/10/21/06/34/european-shorthair-8330819_1280.jpg"
				width="600px"	>
			
			<%-- 좋아요 --%>
			<div class="d-flex">
				<img alt="" src="/static/img/heart-icon.png" class="ml-4 mt-3" width="20px" height="20px">
				<div class="ml-2 mt-3">좋아요 like개</div>
			</div>
			
			<%-- 글 내용 --%>
			
		</div>
		
	</div>
</div>    