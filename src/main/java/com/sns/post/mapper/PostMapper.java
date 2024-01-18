package com.sns.post.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.web.multipart.MultipartFile;

@Mapper
public interface PostMapper {

	public List<Map<String, Object>> selectPostList();
	
	public void insertPost(
			@Param("userId") int userId,
			@Param("content") String content, 
			@Param("imagePath") String imagePath);
	
}
