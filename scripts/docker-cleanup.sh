#!/bin/bash

echo "========== Docker Usage =========="

docker system df

echo
echo "========== Running Containers =========="

docker ps

echo
echo "========== Docker Services =========="

docker service ls

echo
echo "========== Images =========="

docker images

echo
echo "========== Dangling Images =========="

docker image ls -f dangling=true