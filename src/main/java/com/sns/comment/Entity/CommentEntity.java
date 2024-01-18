package com.sns.comment.Entity;

import java.time.ZonedDateTime;

import org.hibernate.annotations.UpdateTimestamp;

import com.sns.post.Entity.PostEntity;
import com.sns.user.entity.UserEntity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

@ToString
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Builder
@Entity
@Table(name="comment")
public class CommentEntity {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	@Column(name="postId")
	private int postId;
	
	private String content;
	
	@UpdateTimestamp
	@Column(name="createdAt", updatable = false)
	private ZonedDateTime createdAt;
	
	@UpdateTimestamp
	@Column(name="updatedAt")
	private ZonedDateTime updatedAt;
	
	@ManyToOne
	@JoinColumn(name="postId")
	private PostEntity post;
	
	@ManyToOne
	@JoinColumn(name="userId")
	private UserEntity user;
	
}
