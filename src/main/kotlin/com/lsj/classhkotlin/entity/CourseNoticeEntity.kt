package com.lsj.classhkotlin.entity

import javax.persistence.*

@Entity
@Table(name = "course_notice")
data class CourseNoticeEntity (@Id @GeneratedValue(strategy = GenerationType.IDENTITY) var cnno: Int? = null) {
    var isPublic: Boolean? = false
    var title: String? = null
    var notice: String? = null
    @OneToOne @JoinColumn(name = "mbno") var member: MemberEntity? = null
    @ManyToOne @JoinColumn(name = "cono") var course: CourseEntity? = null

}