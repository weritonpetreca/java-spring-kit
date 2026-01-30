#!/bin/bash

# ==============================================================================
# 🐺 WITCHER OPS - RUNTIME SCRIPT (V2.0)
# ==============================================================================
# INSTRUÇÕES:
# 1. Duplique este arquivo: cp run_app.template.sh run_app.sh
# 2. Preencha as variáveis na seção de CONFIGURAÇÃO abaixo.
# 3. Execute: ./run_app.sh
# ==============================================================================

# --- [INÍCIO DA SEÇÃO DE CONFIGURAÇÃO] ---

# 1. Identidade da Aplicação
APP_NAME="vivaldi-bank"
APP_PORT_HOST=8080
APP_PORT_CONTAINER=8080

# 2. Credenciais AWS (Infraestrutura)
AWS_ACCOUNT_ID="635106763014"  # <--- SEU ID DE CONTA AQUI
AWS_REGION="us-east-1"
ECR_REPO_NAME="vivaldi-bank-api"
IMAGE_TAG="latest"

# URI Montada Automaticamente (Não precisa editar)
FULL_IMAGE_URI="${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPO_NAME}:${IMAGE_TAG}"

# 3. Variáveis de Ambiente da Aplicação (Injeção de Dependência)
# Estas são as "poções" que o Golem vai beber ao nascer.
ENV_SPRING_PROFILE="prod"
ENV_DB_HOST="vivaldi-db-instance.ckt006iuoepa.us-east-1.rds.amazonaws.com"
ENV_DB_PORT="5432"
ENV_DB_NAME="vivaldi_bank"
ENV_DB_USER="admin123"
ENV_DB_PASSWORD="TROQUE_ISSO_PELA_SENHA_REAL"

# 4. Credenciais de Acesso da Aplicação (AWS SDK)
ENV_AWS_ACCESS_KEY="TROQUE_ISSO_PELA_KEY_REAL"
ENV_AWS_SECRET_KEY="TROQUE_ISSO_PELA_SECRET_REAL"

# --- [FIM DA SEÇÃO DE CONFIGURAÇÃO] ---

# Cores para Logs
GREEN='\033[1;32m'
RED='\033[1;31m'
BLUE='\033[1;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Função de Log
log_step() { echo -e "${BLUE}⚡ [PASSO]${NC} $1"; }
log_success() { echo -e "${GREEN}✅ [SUCESSO]${NC} $1"; }
log_error() { echo -e "${RED}❌ [ERRO]${NC} $1"; }

# ==============================================================================
# INÍCIO DO RITUAL
# ==============================================================================
echo -e "${GREEN}"
echo "   /\\   🐺 WITCHER DEPLOYMENT PROTOCOL"
echo "  /  \\     Target: $APP_NAME"
echo " /____\\    Image:  $FULL_IMAGE_URI"
echo -e "${NC}"

# 1. Autenticação no ECR
log_step "Autenticando no Registry da AWS..."
if aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $FULL_IMAGE_URI; then
    log_success "Login realizado."
else
    log_error "Falha no login. Verifique suas credenciais AWS CLI."
    exit 1
fi

# 2. Download (Pull)
log_step "Baixando imagem..."
docker pull $FULL_IMAGE_URI

# 3. Limpeza (Kill old container)
if [ "$(docker ps -aq -f name=$APP_NAME)" ]; then
    log_step "Removendo container antigo..."
    docker rm -f $APP_NAME > /dev/null
fi

# 4. Execução (Run)
log_step "Invocando container..."

docker run -d \
  --name $APP_NAME \
  -p $APP_PORT_HOST:$APP_PORT_CONTAINER \
  --restart unless-stopped \
  -e SPRING_PROFILES_ACTIVE=$ENV_SPRING_PROFILE \
  -e DB_HOST=$ENV_DB_HOST \
  -e DB_PORT=$ENV_DB_PORT \
  -e DB_NAME=$ENV_DB_NAME \
  -e DB_USER=$ENV_DB_USER \
  -e DB_PASSWORD=$ENV_DB_PASSWORD \
  -e AWS_REGION=$AWS_REGION \
  -e AWS_ACCESS_KEY_ID=$ENV_AWS_ACCESS_KEY \
  -e AWS_SECRET_ACCESS_KEY=$ENV_AWS_SECRET_KEY \
  $FULL_IMAGE_URI

# Verificação Final
if [ $? -eq 0 ]; then
    log_success "Deployment concluído! API disponível em: http://localhost:$APP_PORT_HOST"
    echo -e "${YELLOW}📜 Logs: docker logs -f $APP_NAME${NC}"
else
    log_error "Falha ao iniciar o container."
    exit 1
fi
