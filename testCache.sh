#!/bin/bash

if [ $JHIPSTER == "app-default-from-scratch" ]; then
  echo "create mycache.txt"
  mkdir -p /home/travis/cache/
  echo "$JHIPSTER $(date)" > /home/travis/cache/mycache.txt
fi
cat /home/travis/cache/mycache.txt
