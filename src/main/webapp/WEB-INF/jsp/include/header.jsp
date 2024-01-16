<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<div class="h-100 d-flex justify-content-between align-items-center">
	
	<div class="ml-2">
		<h1>Marondalgram</h1>
	</div>
	
	<div class="d-flex">
		<c:if test="${not empty userId }">
			<div class="mr-5">
				<span>${userName }님 안녕하세요!</span>
				<a href="/user/sign-out">로그아웃</a>
			</div>
		</c:if>
		<c:if test="${empty userId }">
			<div class="mr-2">
				<a href="/user/sign-in-view">로그인</a>
			</div>	
		</c:if>
	</div>

</div>    