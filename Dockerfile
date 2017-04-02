FROM ubuntu:16.04

ENV NODE_VERSION 6.9.2
ENV YARN_VERSION 0.21.3

RUN apt-get update \
  && apt-get install -y --no-install-recommends python3-dev python3-pip libmemcached-dev libyaml-dev zlib1g-dev xz-utils curl

RUN curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.xz" \
  && tar -xJf "node-v$NODE_VERSION-linux-x64.tar.xz" -C /usr/local --strip-components=1 \
  && rm "node-v$NODE_VERSION-linux-x64.tar.xz" \
  && ln -s /usr/local/bin/node /usr/local/bin/nodejs

RUN curl -fSL -o yarn.js "https://yarnpkg.com/downloads/$YARN_VERSION/yarn-legacy-$YARN_VERSION.js" \
  && mv yarn.js /usr/local/bin/yarn \
  && chmod +x /usr/local/bin/yarn

RUN apt-get purge -y xz-utils curl \
  && apt-get autoremove -y \
  && apt-get clean \
  && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*
