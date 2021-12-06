ARG JITSI_REPO=jitsi
FROM ${JITSI_REPO}/base

COPY rootfs/ /

RUN \
  apt-dpkg-wrap apt-get update && \
  apt-dpkg-wrap apt-get install -y --allow-unauthenticated cron nginx-extras vim curl make && \
  apt-dpkg-wrap apt-get -d install -y --allow-unauthenticated && \
  apt-cleanup && \
  rm -f /etc/nginx/conf.d/default.conf && \
  rm -rf /tmp/pkg /var/cache/apt

RUN echo "set encoding=utf-8" >> /etc/vim/vimrc

RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get install -y nodejs git

WORKDIR /web/jitsi-meet
COPY src/package*.json ./
RUN npm install
RUN npm install -g webpack
RUN npm install -g webpack-cli

COPY src/ /web/jitsi-meet/
RUN cp -f /web/jitsi-meet/interface_config*.js /defaults
RUN cp -f /web/jitsi-meet/config*.js /defaults
ENV NODE_ENV=production
RUN make all

EXPOSE 80 443
