package com.lsj.classhkotlin.hander

import com.google.gson.*
import org.slf4j.LoggerFactory
import javax.persistence.AttributeConverter

class JsonArrayConverter : AttributeConverter<JsonArray?, String?> {
    private val gson = Gson()
    private val logger = LoggerFactory.getLogger( JsonArrayConverter::class.java)

    override fun convertToDatabaseColumn(attribute: JsonArray?): String? {
        if( attribute == null ) return null
        return attribute.toString()
    }

    override fun convertToEntityAttribute(dbData: String?): JsonArray? {
        if( dbData == null ) return null

        return gson.fromJson(dbData, JsonArray::class.java)
    }
}