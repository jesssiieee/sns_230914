package com.sns.like.bo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sns.like.mapper.LikeMapper;

@Service
public class LikeBO {

	@Autowired
	private LikeMapper likeMapper;
	
	// input: postId, userId 		output: X
	public void likeToggle(int postId, int userId) {
		
		// like가 있으면
		if (likeMapper.selectLikeCountByPostIdUserId(postId, userId) > 0) {
			// 삭제
			likeMapper.deleteLikeByPostIdUserId(postId, userId);
		} 
		// 없으면
		else {
			// 추가
			likeMapper.addLikeByPostIdUserId(postId, userId);
		}
	
	}
	
	public int likeCount(int postId) {
		return likeMapper.getlikeCount(postId);
	}
	
	public int getLikeCountByPostIdUserId(int postId, int userId) {
		return likeMapper.selectLikeCountByPostIdUserId(postId, userId);
	}
	
}
