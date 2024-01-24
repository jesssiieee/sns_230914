package com.sns.like.bo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sns.like.mapper.LikeMapper;
import com.sns.user.entity.UserEntity;

@Service
public class LikeBO {

	@Autowired
	private LikeMapper likeMapper;

	// input: postId, userId output: X
	public void likeToggle(int postId, int userId) {

		// like가 있으면
		if (likeMapper.selectLikeCountByPostIdOrUserId(postId, userId) > 0) {
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
		return likeMapper.selectLikeCountByPostIdOrUserId(postId, null);
	}

	public int getLikeCountByPostIdUserId(int postId, int userId) {
		return likeMapper.selectLikeCountByPostIdOrUserId(postId, userId);
	}

	// input: postId, userId(null or) output: boolean
	public boolean getLikeCountByPostIdUserId(int postid, Integer userId) {
		// 비로그인이면 무조건 빈 하트 => false
		if (userId == null) {
			return false;
		}
		
		// 로그인	 -  Count값이 0보다 크면(==1이면) 채운 하트, 그렇지 않으면 false
		return likeMapper.selectLikeCountByPostIdOrUserId(postid, userId) > 0; // <- true
		
	}

}
