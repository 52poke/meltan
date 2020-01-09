FROM ubuntu:18.04

ENV USERNAME mudkip
ENV USERADDARGS="-u 1000"

# Locales
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

RUN apt-get update && apt-get install -y apt-utils locales tzdata && locale-gen en_US.UTF-8

RUN apt-get install -y git openssh-server rsync zsh vim tmux sudo mosh wget curl mongo-tools mariadb-client \
    build-essential iputils-ping jq net-tools netcat-openbsd rubygems ruby-dev silversearcher-ag socat \
    software-properties-common lrzsz python3 python3-dev python3-pip unzip php-cli libpython2.7-dev

RUN echo "Port 6226" > /etc/ssh/sshd_config \
    && echo "PasswordAuthentication no" >> /etc/ssh/sshd_config \
    && echo "ChallengeResponseAuthentication no" >> /etc/ssh/sshd_config \
    && echo "UsePAM yes" >> /etc/ssh/sshd_config \
    && echo "Subsystem       sftp    /usr/lib/openssh/sftp-server" >> /etc/ssh/sshd_config \
    && cp -a /etc/ssh /etc/ssh.cache \
    && mkdir -p /run/sshd

# Install docker-ce-cli
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
RUN add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
RUN apt-get install -y docker-ce-cli

# Install go
RUN add-apt-repository ppa:longsleep/golang-backports && apt-get update
RUN apt-get install -y golang-go

# Install Node
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get install -y nodejs
RUN npm install -g forever pm2 typescript eslint npm-check-updates serverless

# Install neovim
RUN apt-add-repository ppa:neovim-ppa/stable && apt-get update
RUN apt-get install -y neovim
RUN pip3 install neovim --upgrade
RUN npm install -g neovim

# Install kafkacat
RUN wget -qO - https://packages.confluent.io/deb/5.3/archive.key | apt-key add -
RUN add-apt-repository "deb [arch=amd64] https://packages.confluent.io/deb/5.3 stable main" && apt-get update && apt-get install -y librdkafka-dev kafkacat

# Install AWS cli
RUN pip3 install awscli

# Install kubectl
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/local/bin/kubectl

# Upgrade
RUN apt-get upgrade -y

# Clean cache
RUN rm -rf /var/lib/apt/lists/*

# Fix macOS
RUN echo "UTF-8           en_US.UTF-8" >> /etc/locale.alias

COPY entry.sh /usr/local/bin/entry.sh
RUN chmod +x /usr/local/bin/entry.sh

EXPOSE 6226
EXPOSE 60001-60010

CMD ["/usr/local/bin/entry.sh"]
