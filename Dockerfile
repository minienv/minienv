FROM docker:dind

RUN apk add --no-cache bash \
    py-pip \
    git \
  && pip install docker-compose

COPY exampleup-entrypoint.sh \
     exampleup-docker-compose.yml /

ENTRYPOINT ["/exampleup-entrypoint.sh"]
