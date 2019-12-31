FROM gcc as builder
RUN wget https://github.com/wikimedia/mediawiki-services-poolcounter/archive/master.tar.gz && \
    tar xf master.tar.gz && mv ./mediawiki-services-poolcounter-master/* .
RUN make
RUN make install

FROM debian:buster
RUN apt-get update && apt-get install -y libevent-2.1-6 && rm -rf /var/lib/apt/lists/*
COPY --from=builder /usr/bin/poolcounterd /usr/bin/poolcounterd
EXPOSE 7531
ENTRYPOINT [ "/usr/bin/poolcounterd" ]
