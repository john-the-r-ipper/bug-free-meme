#!/bin/bash

# Define the container name
CONTAINER_NAME="OracleXE"

# Stop and remove the container if it is already running
if [ "$(docker ps -aq -f name=$CONTAINER_NAME)" ]; then
    echo "Stopping and removing existing container: $CONTAINER_NAME"
    docker stop $CONTAINER_NAME
    docker rm $CONTAINER_NAME
fi

# Run a new container instance
echo "Starting a new Oracle XE container..."
docker run --name $CONTAINER_NAME --shm-size=1g -p 1521:1521 -p 8081:8080 \
    -e ORACLE_PASSWORD=12345 \
    -v oracle-data:/u01/app/oracle/oradata \
    gvenzl/oracle-xe

echo "Oracle XE container is up and running."
