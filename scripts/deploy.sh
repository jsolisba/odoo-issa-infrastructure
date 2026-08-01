#!/bin/bash

set -euo pipefail

if [ $# -ne 1 ]; then
    echo "Usage:"
    echo "./deploy.sh dev"
    echo "./deploy.sh prod"
    exit 1
fi

ENVIRONMENT="$1"

case "$ENVIRONMENT" in
    dev)
        ENV_FILE=docker/dev.env
        ;;
    prod)
        ENV_FILE=docker/prod.env
        ;;
    *)
        echo "Invalid environment"
        exit 1
        ;;
esac

set -a
source "$ENV_FILE"
set +a

docker pull ghcr.io/jsolisba/odoo:${ODOO_IMAGE_TAG}

docker stack deploy \
    --compose-file docker/compose.yml \
    ${STACK_NAME}