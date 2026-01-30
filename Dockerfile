# ==============================================================================
# ESTÁGIO 1: A FORJA (BUILD)
# Usa uma imagem com Gradle e JDK completo para compilar o código
# ==============================================================================
FROM gradle:8.5-jdk21-alpine AS builder

WORKDIR /home/gradle/src

# Otimização de Cache: Copia apenas arquivos de dependência primeiro
COPY --chown=gradle:gradle build.gradle settings.gradle.kts gradle.properties ./
COPY --chown=gradle:gradle src ./src

# Compila o artefato (Gera o .jar) sem rodar testes novamente (já rodaram no CI)
# --no-daemon economiza memória no ambiente de build
RUN gradle bootJar --no-daemon

# ==============================================================================
# ESTÁGIO 2: O GOLEM (RUNTIME)
# Usa uma imagem leve (Alpine) apenas com o JRE para rodar a aplicação
# ==============================================================================
FROM eclipse-temurin:21-jre-alpine

# Cria um usuário sem privilégios (Segurança: Não rodar como root)
RUN addgroup -S witcher && adduser -S geralt -G witcher
USER geralt

WORKDIR /app

# Copia apenas o JAR gerado no estágio anterior
COPY --from=builder /home/gradle/src/build/libs/*.jar app.jar

# Expõe a porta padrão do Spring Boot
EXPOSE 8080

# Comando de Invocação
ENTRYPOINT ["java", "-jar", "app.jar"]
