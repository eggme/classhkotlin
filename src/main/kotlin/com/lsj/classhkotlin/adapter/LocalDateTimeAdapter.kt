package com.lsj.classhkotlin.adapter

import com.google.gson.*
import java.lang.reflect.Type
import java.time.LocalDateTime
import java.time.format.DateTimeFormatter

class LocalDateTimeAdapter : JsonSerializer<LocalDateTime>, JsonDeserializer<LocalDateTime> {

    override fun serialize(src: LocalDateTime?, typeOfSrc: Type?, context: JsonSerializationContext): JsonElement? {
        return if(src == null) null else JsonPrimitive( DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss").format(src) )
    }

    override fun deserialize(json: JsonElement?, typeOfT: Type?, context: JsonDeserializationContext?): LocalDateTime {
        return LocalDateTime.parse(json?.asString,  DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss") )
    }
}