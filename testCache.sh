#!/bin/bash

if [ ! -a "/home/travis/cache/coucou.txt" ]; then
  echo "create coucou"
  mkdir -p /home/travis/cache/
  echo "$JHIPSTER" > /home/travis/cache/coucou.txt
fi
cat /home/travis/cache/coucou.txt
