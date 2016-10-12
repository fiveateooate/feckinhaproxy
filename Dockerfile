FROM alpine:edge

RUN apk --no-cache add haproxy supervisor
RUN apk add confd --update-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted \
  && rm -rf /var/cache/apk/*
COPY etc /etc/

CMD ["/usr/bin/supervisord","-n"] 
