FROM node:12

ARG GH_PAT
ARG GH_REPO
ARG REMOTE_URL="https://neighborlynook.com"
ARG GHOST_SERVER_URL
ARG GIT_NAME
ARG GIT_EMAIL

ENV GH_USERNAME=$GH_USERNAME
ENV GH_PAT=$GH_PAT
ENV GH_REPO=$GH_REPO
ENV REMOTE_URL=$REMOTE_URL
ENV GHOST_PATH="/ghost"
ENV GHOST_SERVER_URL=$GHOST_SERVER_URL
ENV GIT_NAME=$GIT_NAME
ENV GIT_EMAIL=$GIT_EMAIL

RUN apt-get update -y
RUN apt-get -y install rsync
RUN npm install -g ghost-static-site-generator


WORKDIR /app

COPY ./ ./

# RUN git clone https://${GH_PAT}:x-oauth-basic@${GH_REPO} /app

# @TODO: use a script for this, make the commit smart and show the number of updates or something.
ENTRYPOINT [ "./entrypoint.sh" ]