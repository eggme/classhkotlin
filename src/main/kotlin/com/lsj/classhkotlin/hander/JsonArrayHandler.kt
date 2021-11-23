package com.lsj.classhkotlin.hander

import com.google.gson.*
import com.google.gson.internal.Streams
import com.google.gson.stream.JsonWriter
import org.apache.ibatis.type.JdbcType
import org.apache.ibatis.type.MappedTypes
import org.apache.ibatis.type.TypeHandler
import java.io.IOException
import java.io.StringWriter
import java.sql.CallableStatement
import java.sql.PreparedStatement
import java.sql.ResultSet


@MappedTypes(JsonArray::class)
class JsonArrayHandler : TypeHandler<JsonArray?> {

    private val gson = Gson()

    override fun setParameter(ps: PreparedStatement?, i: Int, parameter: JsonArray?, jdbcType: JdbcType?) {
        try {
            val sw = StringWriter()
            val jsonWriter = JsonWriter(sw).apply {
                isLenient = false
            }
            if( parameter == null) ps?.setNull(i, 0)
            else {
                Streams.write(parameter, jsonWriter)
                ps?.setString(i, sw.toString())
            }
        } catch (ex: IOException) {

        }
    }

    private fun fromString(source: String?): JsonArray? {
        return gson.fromJson(source, JsonArray::class.java)
    }

    override fun getResult(rs: ResultSet, columnName: String): JsonArray? {
        val jsonSource = rs.getString(columnName)
        return jsonSource?.let { fromString(it) }
    }

    override fun getResult(rs: ResultSet, columnIndex: Int): JsonArray? {
        val jsonSource = rs.getString(columnIndex)
        return jsonSource?.let { fromString(it) }
    }

    override fun getResult(cs: CallableStatement, columnIndex: Int): JsonArray? {
        val jsonSource = cs.getString(columnIndex)
        return jsonSource?.let { fromString(it) }
    }
}