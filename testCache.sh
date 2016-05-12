#!/bin/bash

echo ">> $JHIPSTER"
if [ "$JHIPSTER" == "app-default-from-scratch" ]; then
  echo "create mycache.txt"
  mkdir -p /home/travis/cache/
  echo "$JHIPSTER $(date)" > /home/travis/cache/mycache.txt
fi
if [ -a /home/travis/cache/mycache.txt ]; then
  cat /home/travis/cache/mycache.txt
fi
