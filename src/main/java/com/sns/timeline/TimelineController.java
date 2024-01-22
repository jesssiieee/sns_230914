package com.sns.timeline;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sns.comment.bo.CommentBO;
import com.sns.comment.domain.CommentView;
import com.sns.timeline.bo.TimelineBO;
import com.sns.timeline.domain.CardView;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/timeline")
public class TimelineController {

	// TimelineController -> TimelineBO -> PostBO
	// (화면용 객체) -> CommentBO
	// -> UserBo

//	@Autowired
//	private PostBO postBO;

	@Autowired
	private CommentBO commentBO;
	
	@Autowired
	private TimelineBO timelineBO;
	

	// url : http://localhost:8080/timeline/timeline-view
	@GetMapping("/timeline-view")
	public String timeLineView(Model model, HttpSession session) {

		// 로그인 여부 확인
//		Integer userId = (Integer) session.getAttribute("userId");
//		if (userId == null) {
//			return "redirect:/timeline/timeline-view";
//		}

		// DB 목록 조회
//		List<PostEntity> postList = postBO.getPostList();
//		List<Comment> commentList = commentBO.getComment();
//
//		model.addAttribute("postList", postList);
//		model.addAttribute("commentList", commentList);
		
		List<CardView> cardViewList =  timelineBO.generateCardViewList();
		model.addAttribute("cardViewList", cardViewList);
		
//		List<CommentView> commentViewList = commentBO.generateCommentViewListByPostId(0);
		
		model.addAttribute("viewlist", "timeline/timeline");
		return "template/layout";
	}

}
