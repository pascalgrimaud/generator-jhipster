#!/bin/bash

if [ "$DOCKER_TESTS" == 1 ]; then
    docker build -t jhipster-tester -f travis/Dockerfile travis/
fi
