package com.lsj.classhkotlin.entity

import javax.persistence.Entity
import javax.persistence.Table

@Entity
@Table(name = "role")
data class Role(
    val rlno: Int? = null


)
