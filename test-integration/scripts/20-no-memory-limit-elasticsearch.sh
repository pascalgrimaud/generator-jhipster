#!/bin/bash

set -e
source $(dirname $0)/00-init-env.sh

#-------------------------------------------------------------------------------
# Functions
#-------------------------------------------------------------------------------
noLimitElasticsearch() {
    cd $1
    if [ -a src/main/docker/elasticsearch.yml ]; then
        sed -i -e 's/        environment:/        # environment:/1;' src/main/docker/elasticsearch.yml
        sed -i -e 's/            - \"ES_JAVA_OPTS=-Xms1024m -Xmx1024m\"/        #     - \"ES_JAVA_OPTS=-Xms1024m -Xmx1024m\"/1;' src/main/docker/elasticsearch.yml
        cat src/main/docker/elasticsearch.yml
    fi
}

#-------------------------------------------------------------------------------
# Remove memory limit for Elasticsearch
#-------------------------------------------------------------------------------
cd "$JHI_FOLDER_APP"
if [[ -a ".yo-rc.json" ]]; then
    echo "*** Remove memory limit for Elasticsearch inside $JHI_FOLDER_APP"
    noLimitElasticsearch $JHI_FOLDER_APP

else
    for dir in $(ls -1 "$JHI_FOLDER_APP"); do
        if [[ -d $dir ]]; then
            pushd $dir
            echo "*** Remove memory limit for Elasticsearch inside $JHI_FOLDER_APP/$dir"
            noLimitElasticsearch "$JHI_FOLDER_APP/$dir"
            popd
        fi
    done
fi


if [ -a src/main/docker/elasticsearch.yml ]; then
    sed -i -e 's/        environment:/        # environment:/1;' src/main/docker/elasticsearch.yml
    sed -i -e 's/            - \"ES_JAVA_OPTS=-Xms1024m -Xmx1024m\"/        #     - \"ES_JAVA_OPTS=-Xms1024m -Xmx1024m\"/1;' src/main/docker/elasticsearch.yml
    cat src/main/docker/elasticsearch.yml
fi
