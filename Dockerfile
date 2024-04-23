FROM golang:1.22-alpine3.19 AS build-image

ARG VERSION=master

RUN apk add --no-cache git make

RUN git clone --depth 1 -b "$(echo $VERSION | cut -d'-' -f1)" https://github.com/slackhq/nebula.git \
  && cd nebula  \
  && make bin

FROM alpine:3.19

COPY --from=build-image /go/nebula/nebula /bin/nebula
COPY --from=build-image /go/nebula/nebula-cert /bin/nebula-cert

RUN mkdir -p /certs
RUN mkdir -p /config

LABEL org.opencontainers.image.source=https://github.com/infinityofspace/nebula-docker
LABEL org.opencontainers.image.licenses="MIT"
LABEL org.opencontainers.image.version=$VERSION
