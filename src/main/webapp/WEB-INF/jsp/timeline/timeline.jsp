<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>     
<div class="d-flex justify-content-center">
	<div class="contents-box">

		<%-- 글쓰기 영역(로그인 된 사람만 보이게) --%>
		<c:if test="${not empty userId}">
			<div class="write-box border rounded m-3">
				<textarea id="writeTextArea" placeholder="내용을 입력해주세요" class="w-100 border-0"></textarea>
				
				<div class="d-flex justify-content-between">
					<div class="file-upload d-flex">
						<%-- file 태그를 숨겨두고 이미지를 클릭하면 file 태그를 클릭한 것과 같은 효과 --%>
						<input type="file" id="file" accept=".jpg, .jpeg, .gif, .png" class="d-none">
					
						<%-- 이미지에 마우스를 올리면 마우스 커서가 변하도록 적용 --%>
						<a href="#" id="fileUploadBtn"><img width="35" src="https://cdn4.iconfinder.com/data/icons/ionicons/512/icon-image-512.png"></a>
						
						<%-- 업로드 된 임시 이미지 파일 이름 나타내는 곳 --%>
						<div id="fileName" class="ml-2"></div>
					</div>
					<button id="writeBtn" class="btn btn-info">게시</button>
				</div>
			</div> <%--// 글쓰기 영역 끝 --%>
		</c:if>
		
		<%-- 타임라인 영역 --%>
		<div class="timeline-box my-5">
			<c:forEach items="${cardViewList}" var="card">
			<%-- 카드1 --%>
			<div class="card border rounded mt-3">
				<%-- 글쓴이, 더보기(삭제) --%>
				<div class="p-2 d-flex justify-content-between">
					<span class="font-weight-bold">${card.user.loginId}</span> <%-- CardView의 user객체 안의 UserEntity의 loginId를 선택 가능 --%>
					
					<a href="#" class="more-btn">
						<img src="https://www.iconninja.com/files/860/824/939/more-icon.png" width="30">
					</a>
				</div>	
				
				<%-- 카드 이미지 --%>
				<div class="card-img">
					<img src="${card.post.imagePath}" class="w-100" alt="본문 이미지">
				</div>
				
				<%-- 좋아요 --%>
				<div class="card-like m-3">
					<a href="#" class="like-btn" data-post-id="${card.post.id }">
						<img src="https://www.iconninja.com/files/214/518/441/heart-icon.png" width="18" height="18" alt="empty heart">
					</a>
					
					좋아요 ${card.likeCount }개
				</div>
				
				<%-- 글 --%>
				<div class="card-post m-3">
					<span class="font-weight-bold">${card.user.loginId}</span>
					<span>${post.content}</span>
				</div>
				
				<%-- 댓글 제목 --%>
				<div class="card-comment-desc border-bottom">
					<div class="ml-3 mb-1 font-weight-bold">댓글</div>
				</div>
				
				<%-- 댓글 목록 --%>
				<div class="card-comment-list m-2">
					<%-- 댓글 내용들 --%>
					<c:forEach items="${card.commentList }" var="commentView"> <%-- CardView안의 commentList 사용 --%>
					<%-- <c:if test="${comment.postId eq post.id}"> --%>
						<div class="card-comment m-1">
							<span class="font-weight-bold">${commentView.user.loginId }</span>
							<span >${commentView.comment.content }</span>
							<%-- 댓글 삭제 버튼 --%>
							<c:if test="${userId eq commentView.comment.userId}"> 
								<a href="#" class="comment-del-btn" data-comment-id="${commentView.comment.id}" >
									<img src="https://www.iconninja.com/files/603/22/506/x-icon.png" width="10" height="10">
								</a>
							</c:if>
						</div>
					<%-- /c:if> --%>
					</c:forEach> 
					
					<%-- 댓글 쓰기 --%>
					<div class="comment-write d-flex border-top mt-2">
						<input type="text" class="form-control border-0 mr-2 comment-input" placeholder="댓글 달기"/> 
						<button type="button" class="comment-btn btn btn-light" data-user-id="${card.user.loginId}" data-post-id="${card.post.id}">게시</button>
					</div>
				</div> <%--// 댓글 목록 끝 --%>
			</div> <%--// 카드1 끝 --%>
			</c:forEach>
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
			console.log(content);
			
			let file = $("#file").val();
			console.log(file);
			
			if (!file) {
				alert("사진을 선택해주세요.");
			}
			
			// 이미지 확장자 체크
			if (file) {
				// alert("파일 존재");
				let extension = file.split(".").pop().toLowerCase();
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
						location.reload();
					} else if (data.code == 500) { // 비로그인
						location.href = "/user/sign-in-view";
					} else {
						alert(data.error_message);
					}
				}
				
				,error: function(request, status, error) {
					alert("글을 게시하는데 실패하였습니다.");
				}
			});
			

			
		}); // writeBtn
		
		// 전체가 반복문을 돌고 있기 때문에 class로 이벤트를 잡는다.
		$(".comment-btn").on('click', function() {
			// alert("댓글 쓰기");
			let userId = $(this).data("user-id"); // session에 있는 값을 script에서도 가져올 수 있다, 버튼에 담아 가져온다.
			// alert(userId);
			if (!userId) {
				// 비로그인이면 로그인 화면으로 이동
				alert("로그인이 필요합니다.");
				location.href = "/user/sign-in-view";
				return;
			}
			
			let postId = $(this).data("post-id");
			// alert(postId);
			
			// 댓글 내용 가져오기 
			// 1) 이전 태그 값 가져오기 button 전의 text 태그 지칭
			// let content = $(this).prev().val().trim();
			// alert(content);
			
			// 2) 형제 태그 + 지칭 으로 태그 지칭 / 형제 태그 중 input 값 가져오기 
			let content = $(this).siblings("input").val().trim();
			alert(content); 
			
			// ajax로 댓글 게시하기
			$.ajax({
				
				// request
				type:"POST"
				, url:"/comment/create"
				, data:{"postId":postId, "content":content}
				
				// response
				,success:function(data) {
					if (data.code==200) {
						location.reload(true);
						alert("댓글 게시에 성공하였습니다.");
					} else {
						alert(data.error_message);
					}
				}
				
				, error(request, status, error) {
					alert("댓글 게시에 실패하였습니다.");
				}
				
				
			}); // comment-btn ajax
			
		}); //comment-btn
		
		$(".comment-del-btn").on('click', function(e) {
			// alert("댓글삭제");
			e.preventDefault(); // 위로 올라감 방지
			
			let commentId = $(this).data("comment-id");
			// alert(commentId);
			
			$.ajax ({
				// request
				type:"DELETE"				
				, url:"/comment/delete"
				, data:{"commentId":commentId}
				// response
				, success:function(data) {
					if (data.code==200) {
						location.reload(true);
						alert("댓글 삭제에 성공하였습니다.");
					} else {
						alert(data.error_message);
					}
				}
				, error(request, status, error) {
					alert("댓글 삭제에 실패하였습니다.");
				}
			}); // comment-del-btn ajax

		}); // comment-del-btn
		
		// 좋아요
		$(".like-btn").on('click', function(e) {
			e.preventDefault();
			// alert("좋아요");
			
			let postId = $(this).data("post-id");
			// alert(postId);
			
			$.ajax ({
				// get이면 생략
				// param도 컨트롤러에서 보냄 (생략)
				url: "/like/"+postId				// like/13
				, success:function(data) {
					if (data.code == 200) {
						// 성공
						// 새로고침 => timeline-view가 update
						// 좋아요여부, 개수는 CardView에서 timeline으로 뿌려준다.
						location.reload(true);
					} else if(data.code == 300) {
						// 비로그인
						alert(data.error_message);
						// 로그인 페이지로
						location.href = "/user/sign-in-view";
					}
				}
				, error:function(request, status, error) {
					alert("좋아요를 하는데 실패했습니다.");
				}
				
			}); // like-btn ajax
			
		}); // like-btn
		
	}); // ready

</script>