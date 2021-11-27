package com.lsj.classhkotlin.entity

import javax.persistence.*

@Entity
@Table(name = "course_history")
data class CourseHistoryEntity (@Id @GeneratedValue(strategy = GenerationType.IDENTITY) var chno: Int? = null){
    @ManyToOne @JoinColumn(name = "mbno") var member: MemberEntity? = null
    @OneToOne @JoinColumn(name = "cono") var course: CourseEntity? = null
    @OneToOne @JoinColumn(name = "ccno") var courseClass: CourseClassEntity? = null
    var startTime: Int? = null
    var endTime: Int? = null
}