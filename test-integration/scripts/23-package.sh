#!/bin/bash

set -e
source $(dirname $0)/00-init-env.sh

#-------------------------------------------------------------------------------
# Functions
#-------------------------------------------------------------------------------
packageApplication() {
    cd $1
    if [ -f "mvnw" ]; then
        ./mvnw verify -DskipTests -P"$JHI_PROFILE"
        mv target/*.war app.war
    elif [ -f "gradlew" ]; then
        ./gradlew bootWar -P"$JHI_PROFILE" -x test
        mv build/libs/*SNAPSHOT.war app.war
    else
        echo "*** no mvnw or gradlew"
        exit 0
    fi
    if [ $? -ne 0 ]; then
        echo "*** error when packaging"
        exit 1
    fi
}

configProtractor() {
    cd $1
    if [ "$JHI_PROTRACTOR" == 1 ] && [ -e "src/main/webapp/app/app.module.ts" ]; then
        sed -e 's/alertTimeout: 5000/alertTimeout: 1/1;' src/main/webapp/app/app.module.ts > src/main/webapp/app/app.module.ts.sed
        mv -f src/main/webapp/app/app.module.ts.sed src/main/webapp/app/app.module.ts
        cat src/main/webapp/app/app.module.ts | grep alertTimeout
    fi
}

#-------------------------------------------------------------------------------
# Package applications
#-------------------------------------------------------------------------------
cd "$JHI_FOLDER_APP"
if [[ -a ".yo-rc.json" ]]; then

    if [[ "$JHI_APP" == *"uaa"* ]]; then
        packageApplication "$JHI_FOLDER_UAA"
    fi

    configProtractor "$JHI_FOLDER_APP"
    packageApplication "$JHI_FOLDER_APP"

else
    for dir in $(ls -1 "$JHI_FOLDER_APP"); do
        if [[ -d $dir ]]; then
            pushd $dir
            configProtractor "$JHI_FOLDER_APP/$dir"
            packageApplication "$JHI_FOLDER_APP/$dir"
            popd
        fi
    done
fi
