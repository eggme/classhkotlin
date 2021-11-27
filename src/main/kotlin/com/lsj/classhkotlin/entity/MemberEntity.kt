package com.lsj.classhkotlin.entity

import com.google.gson.JsonArray
import com.lsj.classhkotlin.hander.JsonArrayConverter
import org.springframework.data.annotation.CreatedDate
import java.time.LocalDateTime
import javax.persistence.*

@Entity
@Table(name = "members")
data class MemberEntity (@Id @GeneratedValue(strategy = GenerationType.IDENTITY) var mbno: Int? = null) {
    @Column(length = 200, nullable = false) var usename: String? = null
    var nick: String? = null
    var name: String? = null
    var email: String? = null
    var introduce: String? = null
    @Column(length = 200, nullable = false) var password: String? = null
    @Column(length = 300)var profile: String = "/imgs/mini_icon_1.png"
    var role: String = "ROLE_USER"
    var status: String = "OK"
    @CreatedDate @Column(updatable = false) var regDt: LocalDateTime? = LocalDateTime.now()
    var lastLogin: LocalDateTime? = null
    @Convert(converter = JsonArrayConverter::class) val roles: JsonArray? = null

}
