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

projectsDir() {
    local project="`echo ~/Dropbox/Backup/projects.txt`"

    rm $project;
    touch $project;

    for i in ~/projects/*; do
        cd $i;
        if git -C $i rev-parse &> /dev/null; then
            execute "git remote get-url origin >> $project" "Backing up $i";
        fi
        cd ..;
    done
}

main() {
    copyAuditFile
    backupCron
    projectsDir
}

main