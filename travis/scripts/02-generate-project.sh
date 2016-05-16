#!/bin/bash
set -ev
#-------------------------------------------------------------------------------
# Generate project and entities
#-------------------------------------------------------------------------------
cd "$HOME"/app
yo jhipster --force --no-insight --with-entities
ls -al "$HOME"/app

#-------------------------------------------------------------------------------
# Check Javadoc generation
#-------------------------------------------------------------------------------
if [ "$JHIPSTER" != "app-gradle" ]; then
  ./mvnw javadoc:javadoc
else
  ./gradlew javadoc
fi
