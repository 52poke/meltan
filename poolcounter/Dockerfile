FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y poolcounter

EXPOSE 7531

ENTRYPOINT [ "/usr/bin/poolcounterd" ]