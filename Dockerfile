FROM alpine:edge

RUN apk --no-cache add haproxy supervisor
COPY etc /etc/

CMD ["/usr/bin/supervisord","-n"] 
