<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="d-flex justify-content-center">
	<div class="sign-up-box">
		<h1 class="m-4 font-weight-bold">회원가입</h1>
		<form id="signUpForm" method="post" action="/user/sign-up">
			<span class="sign-up-subject">ID</span>
			<%-- 인풋 옆에 중복확인 버튼을 옆에 붙이기 위해 div 만들고 d-flex --%>
			<div class="d-flex ml-3 mt-3">
				<input type="text" id="loginId" name="loginId" class="form-control col-6" placeholder="ID를 입력해주세요">
				<button type="button" id="loginIdCheckBtn" class="btn btn-success">중복확인</button>
			</div>
			
			<%-- 아이디 체크 결과 --%>
			<div class="ml-3 mb-3">
				<div id="idCheckLength" class="small text-danger d-none">ID를 4자 이상 입력해주세요.</div>
				<div id="idCheckDuplicated" class="small text-danger d-none">이미 사용중인 ID입니다.</div>
				<div id="idCheckOk" class="small text-success d-none">사용 가능한 ID 입니다.</div>
			</div>
			
			<span class="sign-up-subject">Password</span>
			<div class="m-3">
				<input type="password" id="password" name="password" class="form-control col-6" placeholder="비밀번호를 입력하세요">
			</div>

			<span class="sign-up-subject">Confirm password</span>
			<div class="m-3">
				<input type="password" id="confirmPassword" name="confirmPassword" class="form-control col-6" placeholder="비밀번호를 입력하세요">
			</div>

			<span class="sign-up-subject">Name</span>
			<div class="m-3">
				<input type="text" id="name" name="name" class="form-control col-6" placeholder="이름을 입력하세요">
			</div>

			<span class="sign-up-subject">이메일</span>
			<div class="m-3">
				<input type="text" id="email" name="email" class="form-control col-6" placeholder="이메일을 입력하세요">
			</div>
			
			<br>
			<div class="d-flex justify-content-center m-3">
				<button type="submit" id="signUpBtn" class="btn btn-info">가입하기</button>
			</div>
		</form>
	</div>
</div>   

<script>
	
	$(document).ready(function () {
		
		// 아이디 중복 확인
		$('#loginIdCheckBtn').on('click', function () {
			
			// alert("아이디 중복 확인 버튼");
			
			// 아이디 경고 문구 초기화
			$("#idCheckLength").addClass('d-none');
			$("#idCheckDuplicated").addClass('d-none');
			$("#idCheckOk").addClass('d-none');
			
			// 아이디 4글자 이상. idCheckLength
			let loginId = $("#loginId").val().trim();
			if (loginId.length < 4) {
				$("#idCheckLength").removeClass("d-none");
				return;
			}
			
			// 아이디 중복확인, $.get(ajax)
			$.get("/user/is-duplicated-id", {"loginId":loginId})
			.done(function(data) {
				if (data.code == 200) {
					if (data.is_duplicated_id) {
						$("#idCheckDuplicated").removeClass("d-none");
					} else {
						$("#idCheckOk").removeClass('d-none');
					}
				} else {
					alert(data.error_message);
				}
			});
			
		});
		
		$('#signUpForm').on('submit', function(e) { // form 태그 action
			
			e.preventDefault(); // submit기능에서 화면전환이 되지 않는다. (ajax가 아니면 화면전환이 있음.)
			// alert("회원가입 버튼.");
			
			// validation check 
			let loginId = $("#loginId").val().trim();
			let password = $("#password").val();
			let confirmPassword = $("#confirmPassword").val();
			let name = $("#name").val().trim();
			let email = $("#email").val().trim();
			
			if (!loginId) {
				alert("아이디를 입력하세요.");
				return false;
			}
			
			if (!password || !confirmPassword) {
				alert("비밀번호를 입력하세요.");
			}
			
			if (!name) {
				alert("이름을 입력하세요.");
				return false;
			}
			
			if (!email) {
				alert("이메일을 입력하세요.");
				return false;
			}
			
			if ($("#idCheckOk").hasClass("d-none")) {
				alert("아이디 중복 확인을 다시 해주세요.");
				return false;
			}
			
			// alert("회원가입."); // 모든 validation 통과
			let url = $(this).attr("action");
			alert(url);
			
			let params = $(this).serialize();
			console.log(params);
			
			$.post(url, params)
			.done(function(data) {
				if (data.code == 200) {
					alert("가입을 환영합니다. 로그인 해주세요.");
					location.href("/user/sign-in-view");
				} else {
					alert(data.error_message);
				}
			});
			
		});
		
	});
	
</script>