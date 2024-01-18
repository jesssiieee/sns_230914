package com.sns.post;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.sns.post.bo.PostBO;

import jakarta.servlet.http.HttpSession;

@RestController
@RequestMapping("/post")
public class PostRestController {

	@Autowired
	private PostBO postBO;
	
	@PostMapping("/create")
	public Map<String, Object> create(
			@RequestParam(value = "content", required = false) String content,
			@RequestParam("imagePath") MultipartFile imagePath, 
			HttpSession session ) {
		
		int userId = (int)session.getAttribute("userId");
		String userLoginId = (String) session.getAttribute("userLoginId");
		
		// db insert
		postBO.addPost(userId, content, userLoginId);
		
		
		Map<String, Object> result = new HashMap<>();
		return result;
	}
	
}
