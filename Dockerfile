FROM alpine:edge

RUN apk --no-cache add haproxy
COPY etc /etc/

CMD ["/usr/sbin/haproxy","-d","-f","/etc/haproxy/haproxy.cfg"] 
