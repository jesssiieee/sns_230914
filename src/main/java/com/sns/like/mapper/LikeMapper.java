package com.sns.like.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.sns.like.domain.Like;

@Mapper
public interface LikeMapper {

	public List<Map<String, Object>> selectLikeList();
	
	// select
	public Integer selectLikeCountByPostIdUserId (
			@Param("postId") int postId, 
			@Param("userId") int userId
		);
	
//	public void selectLikeCountByPostIdUserId (
//			@Param("postId") int postId, 
//			@Param("userId") int userId
//		);
	
	// insert
	public void addLikeByPostIdUserId (
			@Param("postId") int postId, 
			@Param("userId") int userId
		);
	
	// delete
	public void deleteLikeByPostIdUserId (
			@Param("postId") int postId, 
			@Param("userId") int userId
		);
	
	// 좋아요 개수
	public int getlikeCount(int postId);
	
	public boolean selectLikeByUserId(
			@Param("userId") int userId
		);
	
}
