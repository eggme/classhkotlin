package com.lsj.classhkotlin.entity

import javax.persistence.*

@Entity
@Table(name = "course_class")
data class CourseClassEntity (@Id @GeneratedValue(strategy = GenerationType.IDENTITY) var ccno: Int? = null){
    var name: String? = null
    @Column(length = 500) var mediaPath: String? = null
    @Column(length = 500) var dataPath: String? = null
    var preview: Boolean? = false
    var seconds: Int? = null
    @Column(length = 100) var memo: String? = null
}