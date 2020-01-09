#!/bin/bash

id -u $USERNAME &>/dev/null || useradd -ms /usr/bin/zsh $USERNAME $USERADDARGS \
    && echo "$USERNAME ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$USERNAME

DOCKER_SOCKET=/var/run/docker.sock
DOCKER_GROUP=docker

if [ -S ${DOCKER_SOCKET} ]; then
    DOCKER_GID=$(stat -c '%g' ${DOCKER_SOCKET})
    addgroup --gid ${DOCKER_GID} ${DOCKER_GROUP}
    usermod --append --groups ${DOCKER_GROUP} ${USERNAME}
fi

/usr/sbin/sshd -D -f /etc/ssh/sshd_config
