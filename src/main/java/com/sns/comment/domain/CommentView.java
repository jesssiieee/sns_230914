package com.sns.comment.domain;

import com.sns.user.entity.UserEntity;

import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class CommentView { // Comment에 댓글쓴이를 포함하기 위한 가공BO

	// 댓글 1개
	private Comment comment;
	
	// 댓글쓴이
	private UserEntity user;
	
}
