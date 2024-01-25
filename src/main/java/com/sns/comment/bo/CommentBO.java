package com.sns.comment.bo;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sns.comment.domain.Comment;
import com.sns.comment.domain.CommentView;
import com.sns.comment.mapper.CommentMapper;
import com.sns.user.bo.UserBO;
import com.sns.user.entity.UserEntity;

@Service
public class CommentBO {

	@Autowired
	private UserBO userBO;
	
	@Autowired
	private CommentMapper commentMapper;

	// input: content output : content
	public void addComment(int postId, int userId, String content) {
		commentMapper.insertComment(postId, userId, content);
	}

	public List<Comment> getComment() {
		return commentMapper.selectcomment();
	}

	public List<CommentView> generateCommentViewListByPostId(int postId) {

		// 결과 리스트 만들기
		List<CommentView> commentViewList = new ArrayList<>(); // 댓글들 + 댓글쓴이

		// 글에 해당하는 댓글 목록 가져오기 List<Comment>
		List<Comment> commentList = commentMapper.selectCommentListByPostId(postId);
				
		
		// 반복문 순회 List<Comment> -> List<CommentView> => 리스트에 넣기
		for(Comment comment : commentList) {
			
			CommentView commentView = new CommentView();
			
			// 댓글 1개
			commentView.setComment(comment);
			
			// 댓글 쓴 이
			UserEntity user = userBO.getUserEntityById(comment.getUserId());
			commentView.setUser(user);
			
			// 결과 List<CommmentView>에 담기
			commentViewList.add(commentView);
		}
		

		// 결과 리스트 리턴
		return commentViewList;

	}
	
	public void deleteCommentById(int id) {
		commentMapper.deleteCommentById(id);
	}
	
	public void deleteCommentByPostId(int postId) {
		commentMapper.deleteCommentByPostId(postId);
	}

}
