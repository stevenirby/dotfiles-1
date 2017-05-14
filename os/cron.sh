#!/bin/bash

cd "$(dirname "${BASH_SOURCE}")" && source "utils.sh"

main() {
    crontab ~/Dropbox/Backup/crontab_backup
}

main