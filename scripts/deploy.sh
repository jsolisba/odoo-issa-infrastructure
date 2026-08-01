#!/bin/bash

set -euo pipefail

########################################
# Validación
########################################

if [ $# -lt 1 ]; then
    echo "Uso:"
    echo "  $0 dev"
    echo "  $0 prod"
    echo
    echo "Opcional:"
    echo "  $0 dev sha-a49f3de"
    exit 1
fi

ENVIRONMENT="$1"

case "$ENVIRONMENT" in
    dev)
        ENV_FILE="docker/dev.env"
        ;;
    prod)
        ENV_FILE="docker/prod.env"
        ;;
    *)
        echo "Ambiente inválido: $ENVIRONMENT"
        exit 1
        ;;
esac

########################################
# Cargar variables
########################################

set -a
source "$ENV_FILE"
set +a

########################################
# Permitir tag opcional
########################################

if [ $# -eq 2 ]; then
    ODOO_IMAGE_TAG="$2"
fi

IMAGE="ghcr.io/jsolisba/odoo:${ODOO_IMAGE_TAG}"

echo "======================================"
echo " Environment : ${ENVIRONMENT}"
echo " Stack       : ${STACK_NAME}"
echo " Image       : ${IMAGE}"
echo "======================================"

########################################
# Descargar imagen
########################################

docker pull "${IMAGE}"

docker compose \
    --env-file "$ENV_FILE" \
    -f docker/compose.yml \
    config > /tmp/compose-rendered.yml

########################################
# Deploy
########################################

docker stack deploy \
    --compose-file /tmp/compose-rendered.yml \
    "${STACK_NAME}"

########################################
# Guardar versión desplegada
########################################

echo "${ODOO_IMAGE_TAG}" > "/opt/odoo/current-${ENVIRONMENT}-version"

echo
echo "======================================"
echo " Deploy finalizado correctamente"
echo "======================================"