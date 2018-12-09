FROM node:8

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

ENV NODE_ENV=production \
    daemon=false \
    silent=false

VOLUME ["/usr/src/app"]
CMD ./nodebb start
EXPOSE 4567
