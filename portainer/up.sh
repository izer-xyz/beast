#!/bin/sh

docker stack up --compose-file $(pwd)/docker-compose.yml $(basename `pwd`)
