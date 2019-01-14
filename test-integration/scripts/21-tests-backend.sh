#!/bin/bash

set -e
source $(dirname $0)/00-init-env.sh

#-------------------------------------------------------------------------------
# Functions
#-------------------------------------------------------------------------------
displayEnvironmentInformation() {
    cd $1
    if [ -f "mvnw" ]; then
        ./mvnw enforcer:display-info
    elif [ -f "gradlew" ]; then
        ./gradlew -v
    fi    
}

checkJavadoc() {
    cd $1
    if [ -f "mvnw" ]; then
        ./mvnw javadoc:javadoc
    elif [ -f "gradlew" ]; then
        ./gradlew javadoc
    fi
}

launchUAATests() {
    cd "$JHI_FOLDER_UAA"
    ./mvnw test
}

backendTests() {
    cd $1
    if [ -f "mvnw" ]; then
        ./mvnw test \
            -Dlogging.level.ROOT=OFF \
            -Dlogging.level.org.zalando=OFF \
            -Dlogging.level.io.github.jhipster=OFF \
            -Dlogging.level.io.github.jhipster.sample=OFF \
            -Dlogging.level.io.github.jhipster.travis=OFF \
            -Dlogging.level.org.springframework=OFF \
            -Dlogging.level.org.springframework.web=OFF \
            -Dlogging.level.org.springframework.security=OFF

    elif [ -f "gradlew" ]; then
        ./gradlew test \
            -Dlogging.level.ROOT=OFF \
            -Dlogging.level.org.zalando=OFF \
            -Dlogging.level.io.github.jhipster=OFF \
            -Dlogging.level.io.github.jhipster.sample=OFF \
            -Dlogging.level.io.github.jhipster.travis=OFF \
            -Dlogging.level.org.springframework=OFF \
            -Dlogging.level.org.springframework.web=OFF \
            -Dlogging.level.org.springframework.security=OFF
    fi
}

#-------------------------------------------------------------------------------
# Launch backend tests
#-------------------------------------------------------------------------------
cd "$JHI_FOLDER_APP"
if [[ -a ".yo-rc.json" ]]; then
    echo "*** Backend tests inside $JHI_FOLDER_APP"
    displayEnvironmentInformation "$JHI_FOLDER_APP"
    checkJavadoc "$JHI_FOLDER_APP"
    if [[ "$JHI_APP" == *"uaa"* ]]; then
        launchUAATests
    fi
    backendTests "$JHI_FOLDER_APP"

else
    for dir in $(ls -1 "$JHI_FOLDER_APP"); do
        if [[ -d $dir ]]; then
            echo "*** Backend tests inside $JHI_FOLDER_APP/$dir"
            pushd -q $dir
            displayEnvironmentInformation "$JHI_FOLDER_APP/$dir"
            checkJavadoc "$JHI_FOLDER_APP/$dir"
            backendTests "$JHI_FOLDER_APP/$dir"
            popd -q
        fi
    done
fi
