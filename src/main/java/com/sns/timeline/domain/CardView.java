package com.sns.timeline.domain;

import java.util.List;

import com.sns.comment.domain.CommentView;
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
	private List<CommentView> commentList;
	
	// 좋아요 개수
	private int likeCount;
	
	// 로그인 된 사람이 좋아요를 누른 여부
	private Boolean filledLike;
	
	
}
