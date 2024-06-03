FROM traefik

ARG STATIC_FILE=selfsigned.yml
# ARG STATIC_FILE=acme.yml


ARG DYNAMIC_FILE=routeros.yml

ENV EDITOR=vi

RUN apk add wabt --no-cache --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing/ && \
    apk add make --no-cache

COPY plugins/ /plugins-local
COPY cellar/ cellar/
COPY cellar/static/${STATIC_FILE} /etc/traefik/traefik.yml
COPY cellar/dynamic/${DYNAMIC_FILE} /etc/traefik
COPY cellar/container/ /usr/local/bin
COPY cellar/routeros/ /etc/traefik

RUN chmod a+x /usr/local/bin/* && \
    ln -s /usr/local/bin/cdd /usr/local/bin/-= && \
    ln -s /usr/local/bin/edit /usr/local/bin/::

