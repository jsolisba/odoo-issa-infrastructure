#!/bin/bash

set -e

cd /opt/odoo/odoo-issa-infrastructure

git pull

docker stack deploy \
    -c docker/prod/compose.yml \
    odoo_stack