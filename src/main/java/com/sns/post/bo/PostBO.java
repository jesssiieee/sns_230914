package com.sns.post.bo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sns.post.Entity.PostEntity;
import com.sns.post.Repository.PostRepository;

@Service
public class PostBO {

	@Autowired
	private PostRepository postRepository;
	
	public List<PostEntity> getPostList() {
		return postRepository.findAllByOrderByIdDesc();
	}
	
	// input: userId, content(null), imagePath
	// output: void
	public void addPost(int userId, String content, String imagePath) {
		PostEntity post = PostEntity.builder()
				.userId(userId)
				.content(content)
				.imagePath(imagePath)
				.build();
	}
		
		
	
	
}
