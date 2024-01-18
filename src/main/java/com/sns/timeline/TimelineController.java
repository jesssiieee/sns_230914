package com.sns.timeline;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sns.post.Entity.PostEntity;
import com.sns.post.bo.PostBO;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/timeline")
public class TimelineController {

	@Autowired
	private PostBO postBO;
	
	// url : http://localhost:8080/timeline/timeline-view
	@GetMapping("/timeline-view")
	public String timeLineView(Model model, HttpSession session) {
		
		// 로그인 여부 확인
		Integer userId = (Integer) session.getAttribute("userId");
		if (userId == null) {
			return "redirect:/timeline/timeline-view";
		}
		
		// DB 목록 조회
		List<PostEntity> postList = postBO.getPostList();
		
		model.addAttribute("postList", postList);
		model.addAttribute("viewlist", "timeline/timeline");
		return "template/layout";
	}
	
	// 댓글
	// <게시> 버튼에 글 번호를 심어두고 댓글 내용 => js 함수 <- 근처
	
}
