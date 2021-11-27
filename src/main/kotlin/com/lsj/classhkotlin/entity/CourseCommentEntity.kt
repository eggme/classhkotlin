package com.lsj.classhkotlin.entity

import org.apache.ibatis.annotations.Many
import javax.persistence.*

@Entity
@Table(name = "course_comment")
data class CourseCommentEntity (@Id @GeneratedValue(strategy = GenerationType.IDENTITY) var cmno: Int? = null){
    @Column(length = 500)var comment: String? = null
    @OneToOne @JoinColumn(name = "mbno") var member: MemberEntity? = null
    @ManyToOne @JoinColumn(name = "cmno") var courseComment: CourseCommentEntity? = null
    @ManyToOne @JoinColumn(name = "cmno") var child: CourseCommentEntity? = null
    @ManyToOne @JoinColumn(name = "crno") var courseReview: CourseReviewEntity? = null
    @ManyToOne @JoinColumn(name = "cnno") var courseNotice: CourseNoticeEntity? = null
}