package com.lsj.classhkotlin.entity

import javax.persistence.*

@Entity
@Table(name = "instructor")
data class Instructor (
    @Id @GeneratedValue var itno: Int? = null){
    @OneToOne @JoinColumn(name="mbno") var member: MemberEntity? = null
    @OneToOne @JoinColumn(name="csno") var course: CourseEntity? = null
}
