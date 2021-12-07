ARG JITSI_REPO=jitsi
FROM ${JITSI_REPO}/base

COPY rootfs/ /

# ENV JITSI_MEET_WEB_VERSION=1.0.4466-1
# ENV JITSI_MEET_WEB_CONFIG_VERSION=1.0.4466-1
ENV JITSI_MEET_WEB_VERSION=1.0.4985-1
ENV JITSI_MEET_WEB_CONFIG_VERSION=1.0.4985-1

RUN \
  apt-dpkg-wrap apt-get update && \
  apt-dpkg-wrap apt-get install -y --allow-unauthenticated cron nginx-extras vim curl make jitsi-meet-web=${JITSI_MEET_WEB_VERSION} && \
  apt-dpkg-wrap apt-get -d install -y --allow-unauthenticated jitsi-meet-web-config=${JITSI_MEET_WEB_CONFIG_VERSION} && \
  dpkg -x /var/cache/apt/archives/jitsi-meet-web-config*.deb /tmp/pkg && \
  mv /tmp/pkg/usr/share/jitsi-meet-web-config/config.js /defaults && \
  mv /usr/share/jitsi-meet/interface_config.js /defaults && \
  apt-cleanup && \
  rm -f /etc/nginx/conf.d/default.conf && \
  rm -rf /tmp/pkg /var/cache/apt

RUN echo "set encoding=utf-8" >> /etc/vim/vimrc

RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get install -y nodejs git

WORKDIR /web/jitsi-meet
COPY src/package*.json ./
RUN npm install

COPY src/ /web/jitsi-meet/
ENV NODE_ENV=production
RUN make

EXPOSE 80 443
