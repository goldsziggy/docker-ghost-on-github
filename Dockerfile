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


WORKDIR /app

RUN npm install -g ghost-static-site-generator
# RUN git clone https://${GH_PAT}:x-oauth-basic@${GH_REPO} /app

CMD git config --global user.email "${GIT_EMAIL}" && \
    git config --global user.name "${GIT_NAME}" &&  \
    git clone https://${GH_PAT}:x-oauth-basic@${GH_REPO} /app && \
    gssg --domain $GHOST_SERVER_URL --url $REMOTE_URL --dest "/app" && \
    git add . && \
    git commit -am "updated site" && \
    git push
