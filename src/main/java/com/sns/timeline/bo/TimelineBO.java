package com.sns.timeline.bo;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sns.post.Entity.PostEntity;
import com.sns.post.bo.PostBO;
import com.sns.timeline.domain.CardView;

@Service
public class TimelineBO {
	
	@Autowired
	private PostBO postBO;

	//input: X		output: List<CardView>
	public List<CardView> generateCardViewList() {
		
		List<CardView> cardViewList = new ArrayList<>();
		
		// 글 목록 가져오기 List<PostEntity>
		List<PostEntity> postList = postBO.getPostList();
		PostEntity post = null;
		
		// 글 목록에 대한 반복문 순회
		// post => cardView		=> cardViewList에 넣기
		for(int i = 0; i < postList.size(); i++) {
			post = postList.get(i);
//			cardViewList.add(post);
		}
		
		
		
		return cardViewList;
	}
	
}
