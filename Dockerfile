###################
# STAGE 1: builder
###################

FROM node:18-bullseye as builder

ARG MB_EDITION=oss
ARG VERSION

WORKDIR /home/node

RUN apt-get update && apt-get upgrade -y && apt-get install openjdk-11-jdk curl git -y \
    && curl -O https://download.clojure.org/install/linux-install-1.11.1.1262.sh \
    && chmod +x linux-install-1.11.1.1262.sh \
    && ./linux-install-1.11.1.1262.sh

# COPY . .

# version is pulled from git, but git doesn't trust the directory due to different owners
# RUN git config --global --add safe.directory /home/node

# RUN INTERACTIVE=false CI=true MB_EDITION=$MB_EDITION bin/build.sh

