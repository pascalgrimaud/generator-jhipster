#!/bin/bash
set -e

#-------------------------------------------------------------------------------
# List HOME
#-------------------------------------------------------------------------------
ls -al "$HOME"

#-------------------------------------------------------------------------------
# Install JHipster Dependencies
#-------------------------------------------------------------------------------
cd "$HOME"
if [[ "$TRAVIS_REPO_SLUG" == *"/jhipster-dependencies" || "$JHIPSTER_DEPENDENCIES_REPO" == "" ]]; then
    echo "TRAVIS_REPO_SLUG=$TRAVIS_REPO_SLUG"
    echo "No need to clone jhipster-dependencies: use local version"

    cd "$TRAVIS_BUILD_DIR"
    ./mvnw clean install -Dgpg.skip=true

elif [[ "$JHIPSTER_DEPENDENCIES_BRANCH" == "release" ]]; then
    echo "No need to clone jhipster-dependencies: use release version"

else
    git clone "$JHIPSTER_DEPENDENCIES_REPO" jhipster-dependencies
    cd jhipster-dependencies
    if [ "$JHIPSTER_DEPENDENCIES_BRANCH" == "latest" ]; then
        LATEST=$(git describe --abbrev=0)
        git checkout -b "$LATEST" "$LATEST"
    elif [ "$JHIPSTER_DEPENDENCIES_BRANCH" != "master" ]; then
        git checkout -b "$JHIPSTER_DEPENDENCIES_BRANCH" origin/"$JHIPSTER_DEPENDENCIES_BRANCH"
    fi
    git --no-pager log -n 10 --graph --pretty='%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit

    ./mvnw clean install -Dgpg.skip=true
    ls -al ~/.m2/repository/io/github/jhipster/jhipster-dependencies/
fi

#-------------------------------------------------------------------------------
# Install JHipster lib
#-------------------------------------------------------------------------------
cd "$HOME"
if [[ "$TRAVIS_REPO_SLUG" == *"/jhipster" || "$JHIPSTER_LIB_REPO" == "" ]]; then
    echo "TRAVIS_REPO_SLUG=$TRAVIS_REPO_SLUG"
    echo "No need to clone jhipster: use local version"

    cd "$TRAVIS_BUILD_DIR"
    ./mvnw clean install -Dgpg.skip=true

elif [[ "$JHIPSTER_LIB_BRANCH" == "release" ]]; then
    echo "No need to clone jhipster: use release version"

else
    git clone "$JHIPSTER_LIB_REPO" jhipster
    cd jhipster
    if [ "$JHIPSTER_LIB_BRANCH" == "latest" ]; then
        LATEST=$(git describe --abbrev=0)
        git checkout -b "$LATEST" "$LATEST"
    elif [ "$JHIPSTER_LIB_BRANCH" != "master" ]; then
        git checkout -b "$JHIPSTER_LIB_BRANCH" origin/"$JHIPSTER_LIB_BRANCH"
    fi
    git --no-pager log -n 10 --graph --pretty='%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit

    ./mvnw clean install -Dgpg.skip=true
    ls -al ~/.m2/repository/io/github/jhipster/jhipster/
fi

#-------------------------------------------------------------------------------
# Install JHipster Generator
#-------------------------------------------------------------------------------
cd "$HOME"
if [[ "$TRAVIS_REPO_SLUG" == *"/generator-jhipster" || "$JHIPSTER_REPO" == "" ]]; then
    echo "TRAVIS_REPO_SLUG=$TRAVIS_REPO_SLUG"
    echo "No need to clone generator-jhipster: use local version"

    cd "$TRAVIS_BUILD_DIR"/
    yarn install
    yarn global add file:"$TRAVIS_BUILD_DIR"
    if [[ "$JHIPSTER" == "" || "$JHIPSTER" == "ngx-default" ]]; then
        yarn test
    fi

elif [[ "$JHIPSTER_BRANCH" == "release" ]]; then
    yarn global add generator-jhipster

else
    git clone "$JHIPSTER_REPO" generator-jhipster
    cd generator-jhipster
    if [ "$JHIPSTER_BRANCH" == "latest" ]; then
        LATEST=$(git describe --abbrev=0)
        git checkout -b "$LATEST" "$LATEST"
    elif [ "$JHIPSTER_BRANCH" != "master" ]; then
        git checkout -b "$JHIPSTER_BRANCH" origin/"$JHIPSTER_BRANCH"
    fi
    git --no-pager log -n 10 --graph --pretty='%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit

    yarn install
    yarn global add file:"$TRAVIS_BUILD_DIR"/generator-jhipster
fi

#-------------------------------------------------------------------------------
# List HOME
#-------------------------------------------------------------------------------
ls -al "$HOME"
