#!/bin/bash

# set -x

cd "$(dirname "${BASH_SOURCE}")" && source "utils.sh"


copyAuditFile() {
    # backup audit file
    cp $HOME/.audit ~/Dropbox/Backup/.audit
}

main() {
    copyAuditFile
}

main