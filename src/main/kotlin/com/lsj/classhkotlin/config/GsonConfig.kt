package com.lsj.classhkotlin.config

import com.google.gson.GsonBuilder
import com.lsj.classhkotlin.adapter.LocalDateAdapter
import com.lsj.classhkotlin.adapter.LocalDateTimeAdapter
import org.springframework.boot.autoconfigure.http.HttpMessageConverters
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import org.springframework.http.HttpInputMessage
import org.springframework.http.HttpOutputMessage
import org.springframework.http.MediaType
import org.springframework.http.converter.AbstractHttpMessageConverter
import org.springframework.http.converter.HttpMessageConverter
import org.springframework.http.converter.json.GsonHttpMessageConverter
import java.io.InputStream
import java.time.LocalDate
import java.time.LocalDateTime


@Configuration
class GsonConfig {

    @Bean
    fun customConverters(): HttpMessageConverters? {
        val messageConverters: MutableCollection<HttpMessageConverter<*>> = ArrayList()
        val gson = GsonBuilder()
            .registerTypeAdapter(LocalDateTime::class.java, LocalDateTimeAdapter() )
            .registerTypeAdapter(LocalDate::class.java, LocalDateAdapter() )
            .setDateFormat("yyyy-MM-dd HH:mm:ss").create()
        val gsonHttpMessageConverter = GsonHttpMessageConverter(gson)
        messageConverters.add(gsonHttpMessageConverter)

        messageConverters.add(object : AbstractHttpMessageConverter<InputStream?>(MediaType.APPLICATION_OCTET_STREAM) {
            override fun supports(clazz: Class<*>): Boolean {
                return InputStream::class.java.isAssignableFrom(clazz)
            }

            override fun readInternal(clazz: Class<out InputStream?>, inputMessage: HttpInputMessage): InputStream {
                return inputMessage.body
            }

            override fun writeInternal(t: InputStream, outputMessage: HttpOutputMessage) {
            }
        })
        return HttpMessageConverters(true, messageConverters)
    }
}