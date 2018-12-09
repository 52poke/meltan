#!/bin/sh

mkdir -p /etc/stunnel/certs
cp /run/secrets/client.pem /etc/stunnel/certs
c_rehash /etc/stunnel/certs
stunnel /etc/stunnel/stunnel.conf