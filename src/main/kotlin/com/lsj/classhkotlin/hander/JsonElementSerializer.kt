package com.lsj.classhkotlin.hander

import com.fasterxml.jackson.core.JsonGenerator
import com.fasterxml.jackson.databind.JsonSerializer
import com.fasterxml.jackson.databind.SerializerProvider
import com.google.gson.JsonElement

class JsonElementSerializer : JsonSerializer<JsonElement>() {

    override fun serialize(value: JsonElement, gen: JsonGenerator, serializers: SerializerProvider) {
        gen.writeRawValue( value.toString() )
    }
}