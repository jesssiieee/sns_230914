package com.sns.timeline.bo;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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

	//input: X		output: List<CardView>
	public List<CardView> generateCardViewList() {
		
		List<CardView> cardViewList = new ArrayList<>();
		
		// 글 목록 가져오기 List<PostEntity>
		List<PostEntity> postList = postBO.getPostList();
		
		// 사용자 목록 가져오기 
		List<UserEntity> userList = userBO.getUserList();
		
		for(PostEntity post : postList) {
			CardView cardView = convertPostToCardView(post);
			
			cardViewList.add(cardView);
		}
		
		for (UserEntity user : userList) {
			CardView cardView = convertUserToCardView(user);
			
			cardViewList.add(cardView);
		}
		
		return cardViewList;
		
	}
	
	private CardView convertPostToCardView(PostEntity post) {
		
		CardView cardView = new CardView();
		
		cardView.setPost(post);
		
		return cardView;
	}
	
	private CardView convertUserToCardView(UserEntity user) {
		CardView cardView = new CardView();
		
		cardView.setUser(user);
		
		return cardView;
	}
	
}
