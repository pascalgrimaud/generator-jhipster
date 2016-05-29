#!/bin/bash

if [ "$DOCKER_TESTS" == 0 ]; then
    exit 0
fi

retryCount=1
maxRetry=10
running=$(docker ps -q --filter status=running --filter "label=test")
while [ "$running" != "" ] && [ $retryCount -le $maxRetry ]; do
    echo "[$(date)] Containers still running... " $retryCount "/" $maxRetry
    docker ps --filter label=test --format "table {{.ID}}\t{{.Names}}\t{{.RunningFor}}\t{{.Status}}"
    echo " "
    retryCount=$((retryCount+1))
    sleep 30
    running=$(docker ps -q --filter status=running --filter "label=test")
    status=$?
done

if [ "$running" != "" ]; then
    echo "[$(date)] Containers running too long..."
else
    echo "[$(date)] Finished!"
fi
docker ps -a --filter label=test --format "table {{.ID}}\t{{.Names}}\t{{.RunningFor}}\t{{.Status}}"

echo " "
echo "--------------------------"
echo "--- containers running ---"
echo "--------------------------"
docker ps --filter status=running --format "{{.Names}}\t{{.Status}}" | awk '{print " " $1 "\t" $2}'

echo " "
echo "--------------------------"
echo "--- containers  exited ---"
echo "--------------------------"
docker ps -a --filter status=exited --format "{{.Names}}\t{{.Status}}" | \
  awk '{print " " $1 "\t" $3}' | \
  sed 's/(0)/OK/g;s/(6)/Error: backend tests/g;s/(7)/Error: frontend tests/g;s/(8)/Error: packaging/g'
echo " "
echo "--------------------------"
