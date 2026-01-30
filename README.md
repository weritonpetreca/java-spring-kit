# Java Spring Kit 🛡️

Configurações base para projetos Spring Boot profissionais. Este repositório serve como um template para iniciar novos projetos com boas práticas já configuradas.

## 📂 Arquivos Inclusos

*   **Git**:
    *   `.gitignore`: Padrões de ignorar arquivos para Java/Spring.
    *   `.gitattributes`: Configuração de Safe CRLF/LF para consistência entre sistemas operacionais.
*   **Build**:
    *   `gradle.properties`: Configurações de performance ajustadas para o Gradle.
    *   `settings.gradle.kts`: Configuração de repositórios de plugins (Maven Central prioritário).
*   **CI (Integração Contínua)**:
    *   `.github/workflows/ci-pipeline.yml`: Pipeline configurado para Java 21 com Cache do Gradle.
*   **IDE**:
    *   `.editorconfig`: Padronização de código entre diferentes IDEs.
*   **Ambiente**:
    *   `env.example`: Exemplo de variáveis de ambiente.
*   **Docker & Deploy**:
    *   `Dockerfile`: Build multi-stage otimizado (Builder + Runtime Alpine).
    *   `compose.yaml`: Ambiente de desenvolvimento local com PostgreSQL e LocalStack (AWS Mock).
    *   `run_app_template.sh`: Script de automação para deploy/execução de containers (Template).

## 🚀 Como usar

1.  **Gere o projeto**: Crie seu projeto base no [Spring Initializr](https://start.spring.io/).
2.  **Copie os arquivos**: Copie os arquivos deste kit para a raiz do seu novo projeto.
3.  **Personalize**:
    *   Ajuste o nome do projeto no arquivo `.github/workflows/ci-pipeline.yml`.
    *   Atualize este `README.md` com as informações do seu novo projeto.
    *   Configure o `compose.yaml` conforme a necessidade do seu projeto (banco de dados, serviços AWS).
    *   Utilize o `run_app_template.sh` como base para scripts de deploy, renomeando para `run_app.sh` e ajustando as variáveis.

## 🛠️ Boas Práticas Adicionais

Para manter um ambiente profissional, considere adotar:

*   **Versionamento Semântico**: Utilize tags git para versões (v1.0.0, v1.1.0).
*   **Testes Automatizados**: Mantenha uma boa cobertura de testes unitários e de integração.
*   **Linter/Formatador**: Configure ferramentas como Checkstyle ou Spotless no Gradle para garantir a formatação do código.
*   **Segurança**: Nunca commite segredos ou senhas. Use variáveis de ambiente ou gerenciadores de segredos.
*   **Documentação de API**: Integre o Swagger/OpenAPI para documentar seus endpoints automaticamente.

---
*Este projeto é um template para agilizar o setup inicial de aplicações Spring Boot.*
