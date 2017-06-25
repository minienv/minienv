FROM docker:dind

RUN apk add --no-cache bash \
    py-pip \
    git \
  && pip install docker-compose

COPY exampleup-entrypoint.sh \
     exampleup-docker-compose-v2.yml \
     exampleup-docker-compose-v3.yml /

ENTRYPOINT ["/exampleup-entrypoint.sh"]
