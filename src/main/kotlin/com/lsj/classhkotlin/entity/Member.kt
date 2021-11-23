package com.lsj.classhkotlin.entity

import com.google.gson.JsonArray
import com.lsj.classhkotlin.hander.JsonArrayConverter
import javax.persistence.*

@Entity
@Table(name = "members")
data class Member (
    @Id @GeneratedValue val mbno: Int? = null,
    val usename: String? = null,
    val nick: String? = null,
    val name: String? = null,
    val email: String? = null,
    val introduce: String? = null,
    val password: String? = null,
    @Convert(converter = JsonArrayConverter::class) val roles: JsonArray? = null
)
