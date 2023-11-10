###################
# STAGE 1: builder
###################

FROM node:18-bullseye as builder

ARG MB_EDITION=oss

WORKDIR /home/node

RUN apt-get update && apt-get upgrade -y && apt-get install openjdk-11-jdk curl git -y \
    && curl -O https://download.clojure.org/install/linux-install-1.11.1.1262.sh \
    && chmod +x linux-install-1.11.1.1262.sh \
    && ./linux-install-1.11.1.1262.sh

COPY . .

# version is pulled from git, but git doesn't trust the directory due to different owners
RUN git config --global --add safe.directory /home/node

RUN INTERACTIVE=false CI=true MB_EDITION=$MB_EDITION bin/build.sh

# ###################
# # STAGE 2: runner
# ###################

## Remember that this runner image needs to be the same as bin/docker/Dockerfile with the exception that this one grabs the
## jar from the previous stage rather than the local build
## we're not yet there to provide an ARM runner till https://github.com/adoptium/adoptium/issues/96 is ready

FROM eclipse-temurin:11-jre-jammy as runner

ENV FC_LANG=en-US LC_CTYPE=en_US.UTF-8

# Dependencies
RUN apt-get update && \
  apt-get upgrade -y && \
  apt-get install -y ca-certificates ca-certificates-java fonts-dejavu && \
  apt-get clean && \
  curl https://s3.amazonaws.com/rds-downloads/rds-combined-ca-bundle.pem -o /usr/local/share/ca-certificates/rds-combined-ca-bundle.pem && \
  curl https://cacerts.digicert.com/DigiCertGlobalRootG2.crt.pem -o /usr/local/share/ca-certificates/DigiCertGlobalRootG2.crt.pem && \
  update-ca-certificates && \
  mkdir -p /plugins && chmod a+rwx /plugins && \
  keytool -list -cacerts

RUN curl https://github.com/starburstdata/metabase-driver/releases/download/4.0.0/starburst-4.0.0.metabase-driver.jar -o /plugins/starburst-4.0.0.metabase-driver.jar

# add Metabase jar & add our run script to the image
COPY ./metabase.jar ./run_metabase.sh /app/

# expose our default runtime port
EXPOSE 3000

# if you have an H2 database that you want to initialize the new Metabase
# instance with, mount it in the container as a volume that will match the
# pattern /app/initial*.db:
# $ docker run ... -v $PWD/metabase.db.mv.db:/app/initial.db.mv.db ...

# run it
ENTRYPOINT ["/app/run_metabase.sh"]
