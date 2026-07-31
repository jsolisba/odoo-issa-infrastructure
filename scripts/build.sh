#!/bin/bash

set -e

docker build \
    -t issa-odoo:18 \
    docker/base