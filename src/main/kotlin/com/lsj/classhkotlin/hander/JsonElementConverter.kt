package com.lsj.classhkotlin.hander

import com.google.gson.*
import org.slf4j.LoggerFactory
import javax.persistence.AttributeConverter

class JsonElementConverter : AttributeConverter<JsonElement?, String?> {
    private val gson = Gson()
    private val logger = LoggerFactory.getLogger( JsonElementConverter::class.java)

    override fun convertToDatabaseColumn(attribute: JsonElement?): String? {
        if( attribute == null ) return null
        return attribute.toString()
    }

    override fun convertToEntityAttribute(dbData: String?): JsonElement? {
        if( dbData == null ) return null

        return gson.fromJson(dbData, JsonElement::class.java)
    }
}