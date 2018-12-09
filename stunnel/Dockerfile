FROM alpine:edge

RUN apk add --no-cache stunnel ca-certificates

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
