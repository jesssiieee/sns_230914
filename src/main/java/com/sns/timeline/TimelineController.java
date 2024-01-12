package com.sns.timeline;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/timeline")
public class TimelineController {

	// url : http://localhost:8080/timeline/list-view
	@GetMapping("/list-view")
	public String listView(Model model) {
		model.addAttribute("viewlist", "user/signUp");
		return "template/layout";
	}
	
}
