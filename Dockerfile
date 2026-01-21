# Use a lightweight Alpine Linux image
FROM alpine:latest

# Install curl and bash (Internet access required during build)
RUN apk add --no-cache curl bash

# Copy your script from your computer into the container
COPY health_check.sh /usr/local/bin/health_check.sh

# Give the script permission to run
RUN chmod +x /usr/local/bin/health_check.sh

# Run the script when the container starts
CMD ["/usr/local/bin/health_check.sh"]
