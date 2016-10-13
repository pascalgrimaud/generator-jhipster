#!/bin/bash
set -ev
#-------------------------------------------------------------------------------
# Check all versions
#-------------------------------------------------------------------------------
java -version
git --version
node -v
npm -v
yarn --version
bower -v
yo --version
gulp -v
docker version
docker-compose version
