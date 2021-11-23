package com.lsj.classhkotlin.hander

import com.fasterxml.jackson.core.JsonParser
import com.fasterxml.jackson.databind.DeserializationContext
import com.fasterxml.jackson.databind.JsonDeserializer
import com.fasterxml.jackson.databind.JsonNode
import com.google.gson.Gson
import com.google.gson.GsonBuilder
import com.google.gson.JsonElement

//@JsonComponent
class JsonElementDeserializer : JsonDeserializer<JsonElement>() {

    private val gson:Gson = GsonBuilder().create()

    override fun deserialize(p: JsonParser, ctxt: DeserializationContext): JsonElement {
        return gson.fromJson(p.codec.readTree<JsonNode>(p).toString(), JsonElement::class.java)
    }
}