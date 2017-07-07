FROM alpine:3.6

MAINTAINER Tim Ehlers <ehlerst@gmail.com>

ARG VERSION

RUN mkdir /opt

RUN mkdir /etc/carbon-c-relay

RUN \
  apk --no-cache update && \
  apk --no-cache upgrade && \
  apk --no-cache add git bc build-base curl && \
  curl --silent --location --retry 3 https://github.com/grobian/carbon-c-relay/archive/v${VERSION}.tar.gz | gunzip | tar x -C /opt/ && \
  cd /opt/carbon-c-relay-${VERSION} && \
  if [ $(echo "$VERSION > 3.0" | bc) -eq 1 ]; then ./configure; make; else make; fi && \
  cp relay /usr/bin/carbon-c-relay && \
  apk del --purge git bc build-base ca-certificates curl && \
  rm -rf /opt/* /tmp/* /var/cache/apk/*

EXPOSE 2003

VOLUME ["/etc/carbon-c-relay"]

CMD ["carbon-c-relay", "-f", "/etc/carbon-c-relay/carbon-c-relay.conf"]

