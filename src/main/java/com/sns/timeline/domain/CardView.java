package com.sns.timeline.domain;

import com.sns.post.Entity.PostEntity;
import com.sns.user.entity.UserEntity;

import lombok.Data;
import lombok.ToString;

// View용 객체
// 글 1개와 CardView 1개가 매핑됨
@Data // getter, setter
@ToString
public class CardView {

	// 글 1개
	private PostEntity post;
	
	// 글쓴이 정보
	private UserEntity user;
	
	// (해당 글에 대한) 댓글들
	
	// 좋아요 개수
	
	
}
