package com.lsj.classhkotlin.entity

import javax.persistence.*

@Entity
@Table(name = "course_review")
data class CourseReviewEntity(@Id @GeneratedValue(strategy = GenerationType.IDENTITY) var crno: Int? = null) {
    var isPublic: Boolean? = false
    var rate: Int? = null
    var title: String? = null
    var content: String? = null
    @ManyToOne @JoinColumn(name = "mbno") var member: MemberEntity? = null
    @ManyToOne @JoinColumn(name = "csno") var course: CourseEntity? = null
}