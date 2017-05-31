FROM docker:dind

RUN apk update
RUN apk add bash
RUN apk add py-pip
RUN pip install docker-compose
RUN apk add git

ADD exampleup-entrypoint.sh /

ENTRYPOINT ["/exampleup-entrypoint.sh"]
