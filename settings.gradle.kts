// settings.gradle.kts

rootProject.name = "java-spring-kit"

// BLOCO NOVO: Gerenciamento de Plugins 🛡️
pluginManagement {
    repositories {
        // 1. Procura primeiro no Maven Central (mais rápido e confiável)
        mavenCentral()
        // 2. Se não achar, procura no Portal oficial do Gradle
        gradlePluginPortal()
    }
}
