package com.lsj.classhkotlin.entity

import javax.persistence.*

@Entity
@Table(name = "course_section")
data class CourseSectionEntity(@Id @GeneratedValue(strategy = GenerationType.IDENTITY) var csno: Int? = null) {
    @ManyToOne @JoinColumn(name = "ccno") var courseClass: CourseClassEntity? = null
    var name: String? = null
    @Column(length = 300) var desc: String? = null
    var goal: String? = null
}
