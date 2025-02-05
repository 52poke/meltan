FROM debian:bookworm-slim

RUN apt-get update \
    && apt-get install -y nginx libnginx-mod-http-cache-purge

RUN ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 80 443

STOPSIGNAL SIGTERM

CMD ["nginx", "-g", "daemon off;"]
