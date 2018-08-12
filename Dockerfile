FROM docker:dind

MAINTAINER Mark Watson <markwatsonatx@gmail.com>

RUN apk add --no-cache bash \
    py-pip \
    git \
  && pip install docker-compose

COPY platforms /platforms
COPY minienv-entrypoint.sh \
     minienv-docker-compose-init.sh \
     minienv-docker-compose-v2.yml \
     minienv-docker-compose-v3.yml /

ENTRYPOINT ["/minienv-entrypoint.sh"]
