#!/bin/bash

# Start Docker daemon in the background
dockerd --host=unix:///var/run/docker.sock --host=tcp://0.0.0.0:2375 &

# Wait for Docker daemon to be ready
echo "Waiting for Docker daemon to start..."
while ! docker ps > /dev/null 2>&1; do
    sleep 1
done
echo "Docker daemon is ready!"

# Load environment variables for Railway
export registry=exadel/
export postgres_username=${PGUSER:-postgres}
export postgres_password=${PGPASSWORD:-postgres}
export postgres_db=${PGDATABASE:-frs}
export postgres_domain=${PGHOST:-127.0.0.1}
export postgres_port=${PGPORT:-5432}
export email_host=smtp.gmail.com
export email_username=${EMAIL_USERNAME:-}
export email_from=${EMAIL_FROM:-}
export email_password=${EMAIL_PASSWORD:-}
export enable_email_server=${ENABLE_EMAIL_SERVER:-false}
export save_images_to_db=${SAVE_IMAGES_TO_DB:-true}
export compreface_api_java_options=${COMPREFACE_API_JAVA_OPTIONS:--Xmx4g}
export compreface_admin_java_options=${COMPREFACE_ADMIN_JAVA_OPTIONS:--Xmx1g}
export max_file_size=${MAX_FILE_SIZE:-5MB}
export max_request_size=${MAX_REQUEST_SIZE:-10M}
export max_detect_size=${MAX_DETECT_SIZE:-640}
export uwsgi_processes=${UWSGI_PROCESSES:-2}
export uwsgi_threads=${UWSGI_THREADS:-1}
export connection_timeout=${CONNECTION_TIMEOUT:-10000}
export read_timeout=${READ_TIMEOUT:-60000}
export ADMIN_VERSION=${ADMIN_VERSION:-1.2.0}
export API_VERSION=${API_VERSION:-1.2.0}
export FE_VERSION=${FE_VERSION:-1.2.0}
export CORE_VERSION=${CORE_VERSION:-1.2.0}
export POSTGRES_VERSION=${POSTGRES_VERSION:-1.2.0}

echo "Starting CompreFace services..."

# Start the application using docker-compose
docker-compose up -d

# Wait for services to be healthy
echo "Waiting for services to be ready..."
sleep 30

# Check if the main service is running
while ! curl -f http://localhost:8000/ > /dev/null 2>&1; do
    echo "Waiting for CompreFace UI to be ready..."
    sleep 10
done

echo "CompreFace is ready!"

# Keep the container running
tail -f /dev/null