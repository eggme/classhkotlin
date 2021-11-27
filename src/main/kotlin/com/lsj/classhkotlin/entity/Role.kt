package com.lsj.classhkotlin.entity

import javax.persistence.*

@Entity
@Table(name = "role")
data class Role(@Id @GeneratedValue(strategy = GenerationType.IDENTITY)var rlno: Int? = null) {
    @ManyToOne @JoinColumn(name = "mbno") var member: MemberEntity? = null
    var role: String? = null
}
