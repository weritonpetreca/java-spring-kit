# Java Spring Kit 🛡️

Configurações base para projetos Spring Boot profissionais. Este repositório serve como um template para iniciar novos projetos com boas práticas já configuradas.

## 📂 Arquivos Inclusos

*   **Git**:
    *   `.gitignore`: Padrões de ignorar arquivos para Java/Spring.
    *   `.gitattributes`: Configuração de Safe CRLF/LF para consistência entre sistemas operacionais.
*   **Build**:
    *   `gradle.properties`: Configurações de performance ajustadas para o Gradle.
*   **CI (Integração Contínua)**:
    *   `.github/workflows/ci-pipeline.yml`: Pipeline configurado para Java 21 com Cache do Gradle.
*   **IDE**:
    *   `.editorconfig`: Padronização de código entre diferentes IDEs.
*   **Ambiente**:
    *   `env.example`: Exemplo de variáveis de ambiente.

## 🚀 Como usar

1.  **Gere o projeto**: Crie seu projeto base no [Spring Initializr](https://start.spring.io/).
2.  **Copie os arquivos**: Copie os arquivos deste kit para a raiz do seu novo projeto.
3.  **Personalize**:
    *   Ajuste o nome do projeto no arquivo `.github/workflows/ci-pipeline.yml`.
    *   Atualize este `README.md` com as informações do seu novo projeto.

---
*Este projeto é um template para agilizar o setup inicial de aplicações Spring Boot.*
