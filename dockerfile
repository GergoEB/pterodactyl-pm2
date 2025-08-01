# Use a build argument for the Node.js version
ARG NODE_VERSION=22

FROM node:${NODE_VERSION}

# Im not tech support, no emails please
LABEL author="GergoEB" maintainer="example@example.com"

RUN apt update \
    && apt -y install ffmpeg iproute2 git sqlite3 libsqlite3-dev python3 python3-dev ca-certificates dnsutils tzdata zip tar curl build-essential libtool iputils-ping \
    && useradd -m -d /home/container container

RUN npm install npm@latest -g
RUN npm install pm2 -g

USER container
ENV USER=container HOME=/home/container
WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh
CMD [ "/bin/bash", "/entrypoint.sh" ]