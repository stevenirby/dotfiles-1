#!/bin/bash

# set -x

cd "$(dirname "${BASH_SOURCE}")" && source "utils.sh"


copyAuditFile() {
    # backup audit file
    cp $HOME/.audit ~/Dropbox/Backup/.audit
}

backupCron() {
    crontab -l > ~/Dropbox/Backup/crontab_backup
}

main() {
    copyAuditFile
    backupCron
}

main