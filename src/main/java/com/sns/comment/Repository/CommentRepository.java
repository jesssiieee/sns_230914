package com.sns.comment.Repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.sns.comment.Entity.CommentEntity;

public interface CommentRepository extends JpaRepository<CommentEntity, Integer> {

	// https://dev-coco.tistory.com/132
	
}
