package com.sns.comment.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.sns.comment.domain.Comment;
import com.sns.comment.domain.CommentView;

@Mapper
public interface CommentMapper {

	public void insertComment(
			@Param("postId") int postId, 
			@Param("userId") int userId,
			@Param("content") String content
	);
	
	public List<Comment> selectcomment();
	
	public List<Comment> selectCommentListByPostId(int postId);
	
	public void deleteCommentById(int id);
}
