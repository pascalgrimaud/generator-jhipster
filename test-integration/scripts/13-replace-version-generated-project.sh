#!/bin/bash

set -e
source $(dirname $0)/00-init-env.sh

#-------------------------------------------------------------------------------
# Functions
#-------------------------------------------------------------------------------
replaceVersion() {
    cd $1

    if [[ -a mvnw ]]; then
        sed -e 's/<jhipster-dependencies.version>.*<\/jhipster-dependencies.version>/<jhipster-dependencies.version>'$JHI_VERSION'<\/jhipster-dependencies.version>/1;' pom.xml > pom.xml.sed
        mv -f pom.xml.sed pom.xml
        cat pom.xml | grep \<jhipster-dependencies.version\>

    elif [[ -a gradlew ]]; then
        sed -e 's/jhipster_dependencies_version=.*/jhipster_dependencies_version='$JHI_VERSION'/1;' gradle.properties > gradle.properties.sed
        mv -f gradle.properties.sed gradle.properties
        cat gradle.properties | grep jhipster_dependencies_version=

    fi
}

#-------------------------------------------------------------------------------
# Replace version
#-------------------------------------------------------------------------------

if [[ "$JHI_LIB_BRANCH" == "release" ]]; then
    echo "*** no need to change version in generated project"
    exit 0
fi

if [[ $JHI_VERSION == '' ]]; then
    JHI_VERSION=0.0.0-CICD
fi

# jhipster-dependencies.version in generated pom.xml or gradle.properties
cd "$JHI_FOLDER_APP"
if [[ -a ".yo-rc.json" ]]; then
    echo "*** Change version inside $JHI_FOLDER_APP"
    replaceVersion $JHI_FOLDER_APP

else
    for dir in $(ls -1 "$JHI_FOLDER_APP"); do
        if [[ -d $dir ]]; then
            pushd $dir
            echo "*** Change version inside $JHI_FOLDER_APP/$dir"
            replaceVersion "$JHI_FOLDER_APP/$dir"
            popd
        fi
    done
fi
