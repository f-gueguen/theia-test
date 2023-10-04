ARG NODE_VERSION=16.14

# Build image
FROM node:${NODE_VERSION}-alpine
RUN apk add --no-cache make pkgconfig gcc g++ python3 libx11-dev libxkbfile-dev libsecret-dev


WORKDIR /home/theia
COPY package.json /home/theia

ARG GITHUB_TOKEN
ENV NODE_OPTIONS="--max-old-space-size=4096"

RUN yarn --pure-lockfile && \
    yarn theia build && \
    yarn theia download:plugins && \
    yarn --production && \
    yarn autoclean --init && \
    echo *.ts >> .yarnclean && \
    echo *.ts.map >> .yarnclean && \
    echo *.spec.* >> .yarnclean && \
    yarn autoclean --force && \
    yarn cache clean

# Final image
FROM node:${NODE_VERSION}-alpine
# See : https://github.com/theia-ide/theia-apps/issues/34


LABEL version="1.0" \
      description="Theia IDE Docker Image"

RUN apk add --no-cache git openssh bash libsecret

SHELL ["/bin/bash", "-c"]

ENV HOME /home/theia
ENV SHELL=/bin/bash \
    THEIA_DEFAULT_PLUGINS=local-dir:/home/theia/plugins \
    USE_LOCAL_GIT=true

RUN addgroup theia && \
    adduser -G theia -s /bin/bash -D theia;

RUN chmod g+rw /home && \
    mkdir -p /home/workspace && \
    chown -R theia:theia /home/theia && \
    chown -R theia:theia /home/workspace;


WORKDIR /home/theia
COPY --from=0 --chown=theia:theia /home/theia /home/theia

# Script to clone git repo and run Theia
COPY startup-script.sh /startup-script.sh
RUN chmod +x /startup-script.sh

EXPOSE 3000

USER theia

#SHELL ["/bin/bash", "-ec"]

#RUN echo $SHELL

CMD [ "/startup-script.sh" ]