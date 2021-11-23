import org.jetbrains.kotlin.gradle.tasks.KotlinCompile

plugins {
    id("org.springframework.boot") version "2.6.0"
    id("io.spring.dependency-management") version "1.0.11.RELEASE"
    id("org.jetbrains.kotlin.plugin.noarg") version "1.3.72"
    war
    kotlin("jvm") version "1.6.0"
    kotlin("plugin.spring") version "1.6.0"
    kotlin("plugin.jpa") version "1.6.0"
    kotlin("kapt") version "1.3.72"
}

group = "com.lsj"
version = "0.0.1-SNAPSHOT"
java.sourceCompatibility = JavaVersion.VERSION_1_8

repositories {
    mavenCentral()
    jcenter()
    maven { setUrl("https://jitpack.io") }
}

noArg {
    annotation("javax.persistence.Entity")
    annotation("javax.persistence.MappedSuperclass")
    annotation("javax.persistence.Embeddable")
}
allOpen {
    annotation("javax.persistence.Entity")
    annotation("javax.persistence.MappedSuperclass")
    annotation("javax.persistence.Embeddable")
}

dependencies {
    implementation("org.springframework.boot:spring-boot-starter-data-jpa")
    implementation("org.springframework.boot:spring-boot-starter-security")
    implementation("org.springframework.boot:spring-boot-starter-web")
    implementation("com.fasterxml.jackson.module:jackson-module-kotlin")

    implementation("org.jetbrains.kotlin:kotlin-reflect")
    implementation("org.jetbrains.kotlin:kotlin-stdlib-jdk8")

    implementation("org.bgee.log4jdbc-log4j2:log4jdbc-log4j2-jdbc4.1:1.16")

    implementation("org.modelmapper:modelmapper:2.3.0")
    implementation("org.modelmapper.extensions:modelmapper-gson:2.3.0")

    implementation("org.mapstruct:mapstruct:1.4.1.Final")
    kapt("org.mapstruct:mapstruct-processor:1.4.1.Final")

    implementation("com.google.code.gson:gson:2.8.5")
    implementation("org.mybatis.spring.boot:mybatis-spring-boot-starter:2.1.3")
    implementation("mysql:mysql-connector-java:8.0.22")
    implementation("org.apache.commons:commons-lang3:3.7")
    implementation("commons-codec:commons-codec:1.15")

    implementation("com.github.iamport:iamport-rest-client-java:0.2.12")
    implementation("com.cloudinary:cloudinary:1.0.13")
    implementation("org.webjars.bower:jquery:3.5.1")

    implementation("org.mybatis.spring.boot:mybatis-spring-boot-starter:2.2.0")
    developmentOnly("org.springframework.boot:spring-boot-devtools")

    // Jxls
    implementation("org.jxls:jxls:2.10.0")
    implementation("org.jxls:jxls-poi:2.10.0")
    implementation("org.jxls:jxls-reader:2.0.6")

    providedRuntime("org.springframework.boot:spring-boot-starter-tomcat")
    testImplementation("org.springframework.boot:spring-boot-starter-test")
    testImplementation("org.springframework.security:spring-security-test")
}

tasks.withType<KotlinCompile> {
    kotlinOptions {
        freeCompilerArgs = listOf("-Xjsr305=strict")
        jvmTarget = "1.8"
    }
}

tasks.withType<Test> {
    useJUnitPlatform()
}
