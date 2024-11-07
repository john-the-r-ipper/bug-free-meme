#!/bin/bash

# Define the container name and image name
CONTAINER_NAME="OracleXE"
IMAGE_NAME="gvenzl/oracle-xe"

# Stop and remove the existing container if it's running
if [ "$(docker ps -aq -f name=$CONTAINER_NAME)" ]; then
    echo "Stopping and removing existing container: $CONTAINER_NAME"
    docker stop $CONTAINER_NAME
    docker rm $CONTAINER_NAME
fi

# Remove the old Docker image
if [ "$(docker images -q $IMAGE_NAME)" ]; then
    echo "Removing existing Docker image: $IMAGE_NAME"
    docker rmi $IMAGE_NAME
fi

# Pull the latest Oracle XE image
echo "Pulling the latest Docker image: $IMAGE_NAME"
docker pull $IMAGE_NAME

# Run the new container with the pulled image
echo "Starting a new Oracle XE container..."
docker run --name $CONTAINER_NAME --shm-size=1g -p 1521:1521 -p 8081:8080 \
    -e ORACLE_PASSWORD=12345 \
    -v oracle-data:/u01/app/oracle/oradata \
    $IMAGE_NAME

echo "Oracle XE container is up and running."