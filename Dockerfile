FROM docker:dind

RUN apk add --no-cache bash \
    py-pip \
    git \
  && pip install docker-compose

COPY exampleup-entrypoint.sh /

ENTRYPOINT ["/exampleup-entrypoint.sh"]