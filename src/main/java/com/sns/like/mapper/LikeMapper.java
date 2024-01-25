package com.sns.like.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.sns.user.entity.UserEntity;

@Mapper
public interface LikeMapper {

	public List<Map<String, Object>> selectLikeList();
	
	// select
//	public Integer selectLikeCountByPostIdUserId (
//			@Param("postId") int postId, 
//			@Param("userId") int userId
//	);
	
	// 좋아요 개수
//	public int selectLikeCountByPostId(int postId);
	
	// like Count 쿼리 하나로 합치기
	public int selectLikeCountByPostIdOrUserId(
			@Param("postId") int postId, 
			@Param("userId") Integer userId // 안 쓰면 null로 체워넣을 수 있음
	);
	
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
	
	// 좋아요 여부
	public boolean selectLikeByUserId(
			@Param("userId") int userId
	);
	
	public void deleteLikeByPostId(int postId);
	
}
