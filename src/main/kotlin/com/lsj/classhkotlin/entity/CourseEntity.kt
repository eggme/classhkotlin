package com.lsj.classhkotlin.entity

import javax.persistence.*
import kotlin.jvm.Transient

@Entity
@Table(name = "course")
data class CourseEntity (@Id @GeneratedValue(strategy = GenerationType.IDENTITY) var cono: Int? = null){
    var name: String? = null
    var price: Int? = null
    @ManyToOne @JoinColumn(name="csno") var courseSection: CourseSectionEntity? = null
    @Enumerated(value = EnumType.STRING) var state: CourseState? = null
    @Column(length = 1000) val shortDesc: String? = null
    @Column(columnDefinition = "CLOB") val longDesc: String? = null
    @Column(nullable = false) val courseImg: String = "/imgs/default_course_image.png"
    @Transient val validation: CourseValidation? = null
}
