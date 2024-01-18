<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>     
<div class="d-flex justify-content-center">
	<div class="contents-box">

		<%-- 글쓰기 영역(로그인 된 사람만 보이게) --%>
		<c:if test="${not empty userId}">
		<div class="write-box border rounded m-3">
			<textarea id="writeTextArea" name="content" placeholder="내용을 입력해주세요" class="w-100 border-0"></textarea>
			
			<div class="d-flex justify-content-between">
				<div class="file-upload d-flex">
					<%-- file 태그를 숨겨두고, 이미지를 클릭하면, file 태그를 클릭한 것과 같은 효과 --%>
					<input type="file" id="file" name="file" accept=".jpg, .jpeg, .gif, .png" class="d-none">
				
					<%-- 이미지에 마우스를 올리면 마우스 커서가 변하도록 적용 --%>
					<a href="#" id="fileUploadBtn"><img width="35" src="/static/img/picture-icon.png"></a>
					<%-- 업로드 된 임시 이미지 파일 이름 나타내는 곳 --%>
					<div id="fileName" class="ml-2 mt-2"></div>
				</div>
				<button id="writeBtn" class="btn btn-info">게시</button>
			</div>
		</div> <%--// 글쓰기 영역 끝 --%>
		</c:if>
		
		<%-- 타임라인 영역 --%>
		<div class="timeline-box my-5">
			<%-- 카드1 --%>
			<div class="card border rounded mt-3">
				<%-- 글쓴이, 더보기(삭제) --%>
				<c:forEach items="${postList }" var="post">
					<div class="p-2 d-flex justify-content-between">
						<span class="font-weight-bold">${post.userId }</span>
						
						<a href="#" class="more-btn">
							<img src="/static/img/more-icon.png" width="30">
						</a>
					</div>	
					
					<%-- 카드 이미지 --%>
					<div class="card-img">
						<img src="${post.imagePath }" class="w-100" alt="본문 이미지">
					</div>
				</c:forEach>
				
				<%-- 좋아요 --%>
				<div class="card-like m-3">
					<a href="#" class="like-btn">
						<img src="/static/img/heart-icon.png" width="18" height="18" alt="empty heart">
					</a>
					
					좋아요 13개
				</div>
				
				<%-- 글 --%>
				<c:forEach items="${postList }" var="post">
					<div class="card-post m-3">
						<span class="font-weight-bold">${post.userId }</span>
						<span>${post.content }</span>
					</div>
				</c:forEach>
				
				<%-- 댓글 제목 --%>
				<div class="card-comment-desc border-bottom">
					<div class="ml-3 mb-1 font-weight-bold">댓글</div>
				</div>
				
				<%-- 댓글 목록 --%>
				<div class="card-comment-list m-2">
					<%-- 댓글 내용들 --%>
					<div class="card-comment m-1">
						<span class="font-weight-bold">댓글쓰니</span>
						<span>댓글 내용1111</span>
						
						<%-- 댓글 삭제 버튼 --%>
						<a href="#" class="comment-del-btn">
							<img src="/static/img/x-icon.png" width="10" height="10">
						</a>
					</div>
					
					<%-- 댓글 쓰기 --%>
					<div class="comment-write d-flex border-top mt-2">
						<input type="text" class="form-control border-0 mr-2 comment-input" placeholder="댓글 달기"/> 
						<button type="button" class="comment-btn btn btn-light">게시</button>
					</div>
				</div> <%--// 댓글 목록 끝 --%>
			</div> <%--// 카드1 끝 --%>
		</div> <%--// 타임라인 영역 끝  --%>
	</div> <%--// contents-box 끝  --%>
</div>

<script>

	$(document).ready(function() {
		// 파일 이미지 클릭 => 숨겨져 있는 id="file"을 동작시킨다.
		$("#fileUploadBtn").on('click', function(e) {
			e.preventDefault(); // a 태그의 기본 동작을 멈춘다.(스크롤이 위로 올라가는 현상)
			$("#file").click(); // input file을 클릭한 효과
		}); // fileUploadBtn
		
		// 사용자가 이미지를 선택하는 순간 + validation 확인 + 업로드 된 파일명 노출
		$("#file").on('change', function(e) {
			// alert("이미지 선택");
			let file = e.target.files[0].name;
			// 취소를 눌렀을 때 이미지 선택이 안됨 처리.
			if (file ==  null) {
				$("#file").val(""); // 파일 태그 파일 제거(보이지 않지만, 업로드 될 수 있으므로 주의!)
				$("#fileName").text("");
				return;
			}
			
			let fileName = e.target.files[0].name; // change 이벤트가 일어나는 중, target(this)시점에서, 파일들 중 사진하나 files[0]
			console.log(fileName); // dog-8448345_1280.jpg
			
			// 확장장 유효성 check
			let ext = fileName.split(".").pop().toLowerCase();
			// alert(ext);
			if (ext != "jpg" && ext != "jpeg" && ext != "png" && ext != "gif") {
				alert("이미지 파일만 업로드 할 수 있습니다.");
				$("#file").val(""); // 파일 태그 파일 제거(보이지 않지만, 업로드 될 수 있으므로 주의!)
				$("#fileName").text("");
				return;
			}
			
			// 유효성을 통과한 이미지의 경우, 파일명 노출 
			$("#fileName").text(fileName);
			
		}); // file change
		
		// 글 게시
		$("#writeBtn").on('click', function() {
			// alert("게시버튼 클릭");
			
			// 글 내용
			// 이미지
			let content = $("#writeTextArea").val();
			let imagePath = $("#file").val();
			
			if (!imagePath) {
				alert("사진을 선택해주세요.");
			}
			// 이미지 확장자 체크
			if (imagePath) {
				// alert("파일 존재");
				let extension = imagePath.split(".").pop().toLowerCase();
				// alert(extension);
				
				if ($.inArray(extension, ['jpg', 'png', 'gif', 'jpeg']) == -1) {
					alert("이미지 파일만 업로드 할 수 있습니다.");
					$("#file").val("");
					$("#fileName").val("");
					return;
				}
				
			}
			
			// form 태그
			let formData = new FormData();
			formData.append("content", content); // ("name", value)
			formData.append("file", $("#file")[0].files[0]);
			
			// ajax로 게시하기
			$.ajax ({
				// request
				type:"POST"
				, url:"/post/create"
				, data:formData
				, enctype:"multipart/form-data"
				, processData:false
				, contentType:false
				
				// response
				, success:function(data) {
					if(data.code == 200) {
						alert("글을 게시했습니다.");
						location.href = "/timeline/timeline-view";
					} else {
						alert(data.error_message);
					}
				}
				
				,error: function(request, status, error) {
					alert("글을 게시하는데 실패하였습니다.");
				}
			});
			
			
		}); // writeBtn
		
	}); // ready

</script>