#!/bin/bash
set -ev
#--------------------------------------------------
# Launch tests
#--------------------------------------------------
cd "$HOME"/app
if [ "$JHIPSTER" != "app-gradle" ]; then
  ./mvnw test
else
  ./gradlew test
fi
if [[ ("$JHIPSTER" != "app-microservice") && ("$JHIPSTER" != "app-microservice-gradle") ]]; then
  gulp test --no-notification
fi
