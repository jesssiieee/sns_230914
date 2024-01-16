package com.sns.timeline;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/timeline")
public class TimelineController {

	// url : http://localhost:8080/timeline/timeline-view
	@GetMapping("/timeline-view")
	public String timeLineView(Model model, HttpSession session) {
		
		// 로그인 여부 확인
		Integer userId = (Integer) session.getAttribute("userId");
		if (userId == null) {
			return "redirect:/user/sign-in-view";
		}
		
		// DB 목록 조회
		
		model.addAttribute("viewlist", "timeline/timeline");
		return "template/layout";
	}
	
}
