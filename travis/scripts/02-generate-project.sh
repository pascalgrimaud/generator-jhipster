#!/bin/bash

#-------------------------------------------------------------------------------
# Generate project and entities
#-------------------------------------------------------------------------------
cd "$HOME"/"$JHIPSTER"
yo jhipster --force --no-insight --with-entities
bower install
gulp install
ls -al "$HOME"/"$JHIPSTER"

#-------------------------------------------------------------------------------
# Check Javadoc generation
#-------------------------------------------------------------------------------
if [ "$JHIPSTER" != "app-gradle" ]; then
  ./mvnw javadoc:javadoc
else
  ./gradlew javadoc
fi
