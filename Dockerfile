# Container image that runs your code
FROM openjdk:8-jre-alpine

# install everything needed
RUN apk --no-cache add curl jq 

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh
COPY lib /lib

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
