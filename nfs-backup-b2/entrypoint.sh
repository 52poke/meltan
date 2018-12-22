#!/bin/sh

export B2_ACCOUNT_ID=$(cat /run/secrets/b2_account)
export B2_ACCOUNT_KEY=$(cat /run/secrets/b2_key)
export RESTIC_PASSWORD=$(cat /run/secrets/nfs_backup)

restic -r b2:52poke-backup:nfs backup /srv/nfs