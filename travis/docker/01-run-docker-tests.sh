#!/bin/bash

#-------------------------------------------------------------------------------
# Functions
#-------------------------------------------------------------------------------
runContainer() {
    local application="$1"
    docker run \
        -d --name $application --label=test \
        -v "$JHIPSTER_DOCKER"/samples/"$application":/home/jhipster/volume/app:ro \
        -v "$HOME"/.m2:/home/jhipster/volume/.m2:ro \
        -v "$HOME"/app/node_modules:/home/jhipster/volume/node_modules:ro \
        -v "$TRAVIS_BUILD_DIR":/home/jhipster/volume/generator-jhipster:ro \
        -t tester
}

runContainerSkipFront() {
    local application="$1"
    docker run \
        -d --name $application --label=test \
        -v "$JHIPSTER_DOCKER"/samples/"$application":/home/jhipster/volume/app:ro \
        -v "$HOME"/.m2:/home/jhipster/volume/.m2:ro \
        -v "$TRAVIS_BUILD_DIR":/home/jhipster/volume/generator-jhipster:ro \
        -e JHIPSTER_TEST_FRONT=0
        -t tester
}

#-------------------------------------------------------------------------------
if [ "$DOCKER_TESTS" == 0 ]; then
    exit 0
fi

cd "$JHIPSTER_DOCKER"
if [ "$JHIPSTER" == "app-mongodb" ]; then
    runContainer app-mongodb-oauth2
    runContainer app-mongodb-social
fi
