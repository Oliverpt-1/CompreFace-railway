# Railway Dockerfile for CompreFace
FROM docker:24-dind

# Install docker-compose and other dependencies
RUN apk add --no-cache \
    docker-compose \
    curl \
    bash \
    python3 \
    py3-pip

# Copy application files
COPY . /app
WORKDIR /app

# Make sure the environment file is loaded
ENV DOCKER_BUILDKIT=1
ENV COMPOSE_DOCKER_CLI_BUILD=1

# Expose the main port
EXPOSE 8000

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
    CMD curl -f http://localhost:8000/ || exit 1

# Start script
COPY start-railway.sh /start-railway.sh
RUN chmod +x /start-railway.sh

CMD ["/start-railway.sh"]