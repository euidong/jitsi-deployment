ARG JITSI_REPO=jitsi

FROM ${JITSI_REPO}/base as builder
RUN	\
  mkdir -p /usr/share/man/man1 && \
  wget -q https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public -O /etc/apt/trusted.gpg.d/openjdk.asc && \
  echo "deb https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/ buster main" > /etc/apt/sources.list.d/openjdk.list && \
  apt-dpkg-wrap apt-get update && \
  apt-dpkg-wrap apt-get install -y adoptopenjdk-8-hotspot && \
  apt-cleanup

RUN \
  cd /opt/ && \
  wget -q http://apache.mirrors.pair.com/maven/maven-3/3.5.4/binaries/apache-maven-3.5.4-bin.tar.gz && \
  tar -xvzf apache-maven-3.5.4-bin.tar.gz && \
  mv apache-maven-3.5.4 maven
ENV M2_HOME=/opt/maven
ENV PATH=${M2_HOME}/bin:${PATH}

COPY src /jitsi-videobridge

RUN cd /jitsi-videobridge/jvb && \
  mvn clean verify package


FROM ${JITSI_REPO}/base-java

ENV VIDEOBRIDGE_VERSION=2.1-376-g9f12bfe2-1

RUN \
  apt-dpkg-wrap apt-get update && \
  apt-dpkg-wrap apt-get install -y jitsi-videobridge2=${VIDEOBRIDGE_VERSION} jq curl iproute2 dnsutils && \
  apt-cleanup

EXPOSE 8125/udp 8092/udp 8094 9090

COPY rootfs/ /

COPY --from=builder /jitsi-videobridge/jvb/target/jitsi-videobridge-2.1-SNAPSHOT.jar /usr/share/jitsi-videobridge/jitsi-videobridge.jar
