#!/bin/bash

#--------------------------------------------------
# Launch tests
#--------------------------------------------------
cd "$HOME"/"$JHIPSTER"
if [ "$JHIPSTER" != "app-gradle" ]; then
  ./mvnw test
else
  ./gradlew test
fi
if [ "$JHIPSTER" != "app-microservice" ]; then
  gulp test --no-notification
fi
