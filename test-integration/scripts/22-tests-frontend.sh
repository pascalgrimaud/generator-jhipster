#!/bin/bash

set -e
source $(dirname $0)/00-init-env.sh

#-------------------------------------------------------------------------------
# Functions
#-------------------------------------------------------------------------------
frontendTests() {
    cd $1
    if [ -f "tsconfig.json" ]; then
        if [ -f "src/main/webapp/app/app.tsx" ]; then
            npm run test-ci
        else
            npm test
        fi
    fi
}

#-------------------------------------------------------------------------------
# Launch frontend tests
#-------------------------------------------------------------------------------
cd "$JHI_FOLDER_APP"
if [[ -a ".yo-rc.json" ]]; then
    echo "*** Frontend tests inside $JHI_FOLDER_APP"
    frontendTests "$JHI_FOLDER_APP"

else
    for dir in $(ls -1 "$JHI_FOLDER_APP"); do
        if [[ -d $dir ]]; then
            echo "*** Frontend tests inside $JHI_FOLDER_APP/$dir"
            pushd -q $dir
            frontendTests "$JHI_FOLDER_APP/$dir"
            popd -q
        fi
    done
fi
