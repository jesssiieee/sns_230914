package com.sns.timeline.bo;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sns.comment.bo.CommentBO;
import com.sns.comment.domain.CommentView;
import com.sns.like.bo.LikeBO;
import com.sns.post.Entity.PostEntity;
import com.sns.post.bo.PostBO;
import com.sns.timeline.domain.CardView;
import com.sns.user.bo.UserBO;
import com.sns.user.entity.UserEntity;

@Service
public class TimelineBO {

	@Autowired
	private PostBO postBO;

	@Autowired
	private UserBO userBO;
	
	@Autowired
	private CommentBO commentBO;
	
	@Autowired
	private LikeBO likeBO;

	// input: (비로그인: null, 로그인: userId) output: List<CardView>
	public List<CardView> generateCardViewList(Integer userId) {

		List<CardView> cardViewList = new ArrayList<>(); // 글 + 글쓴이 + 댓글목록

		// 글 목록 가져오기 List<PostEntity>
		List<PostEntity> postList = postBO.getPostList();

		for (PostEntity post : postList) {
			// post 하나에 대응되는 하나의 카드를 만든다.
			CardView cardView = new CardView();
			// 글 1개
			cardView.setPost(post);

			// 글쓴이 정보
			UserEntity user = userBO.getUserEntityById(post.getUserId());
			cardView.setUser(user);
			
			// 댓글들 , CommentView = comments + user
			List<CommentView> commentList = commentBO.generateCommentViewListByPostId(post.getId()); 
			cardView.setCommentList(commentList);
			
			// 좋아요 개수
			int likeCount = likeBO.likeCount(post.getId());
			cardView.setLikeCount(likeCount);
			
			// 로그인된 사람이 좋아요를 눌렀는지 여부, 비로그인도 BO에 들어올 수 있으니 주의
			// Controller session에서 로그인된 아이디를 가져온다, null 오류가 나지 않도록 Integer 
			
			boolean filledLike = likeBO.getLikeCountByPostIdUserId(post.getId(), userId);
			cardView.setFilledLike(filledLike);
			
			
			// ★★★★ cardView를 list에 넣는다.
			cardViewList.add(cardView);
		}

		return cardViewList;

	}

}
