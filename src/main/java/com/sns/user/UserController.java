package com.sns.user;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/user")
public class UserController {

	/**
	 * 회원가입 화면
	 * @param model
	 * @return
	 */
	// url : http://localhost:8080/user/sign-up-view
	@GetMapping("/sign-up-view")
	public String signUpView(Model model) {
		model.addAttribute("viewlist", "user/signUp");
		return "template/layout";
	}
	
	
	/**
	 * 로그인 화면
	 * @param model
	 * @return
	 */
	// url : http://localhost:8080/user/sign-in-view
	@GetMapping("/sign-in-view")
	public String signInView(Model model) {
		model.addAttribute("viewlist", "user/signIn");
		return "template/layout";
	}
	
	@RequestMapping("/sign-out")
	public String signOut(HttpSession session) {
		
		session.removeAttribute("userId");
		session.removeAttribute("userLoginId");
		session.removeAttribute("userName");
		
		return "redirect:/user/sign-up-view";
	}
	
}
