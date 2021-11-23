package com.lsj.classhkotlin.hander

import com.google.gson.Gson
import com.google.gson.JsonObject
import org.slf4j.LoggerFactory
import javax.persistence.AttributeConverter

class JsonObjectConverter : AttributeConverter<JsonObject?, String?> {
    private val logger = LoggerFactory.getLogger( JsonObjectConverter::class.java )
    private val gson = Gson()

    override fun convertToDatabaseColumn(attribute: JsonObject?): String? {
        if( attribute == null ) return null
        return attribute.toString()
    }

    override fun convertToEntityAttribute(dbData: String?): JsonObject? {
        if( dbData == null ) return null
        return gson.fromJson(dbData, JsonObject::class.java)
    }
}