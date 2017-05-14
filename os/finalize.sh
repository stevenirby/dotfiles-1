#!/bin/bash

cd "$(dirname "${BASH_SOURCE}")" && source "utils.sh"

main() {
    local subl="/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl"
    local sublime="/usr/local/bin/sublime"
    local gmvault="~/Dropbox/Backup/.gmvault"
    local alfredWorkflows="~/Dropbox/Backup/workflows"
    local vms="~/Dropbox/Backup/VirtualBox\ VMs/"
    local sublimePackages="~/Dropbox/Backup/sublime_text/Packages/"
    declare -r OS="$(get_os)"

    # OS specific symlinks
    if [ "$OS" == "osx" ]; then
        execute "ln -s $subl $sublime" "$subl → $sublime"
        execute "ln -s $alfredWorkflows ~/workflows" "$alfredWorkflows → ~/workflows"
        execute "ln -s $sublimePackages ~/Library/Application Support/Sublime Text 3/ Packages" "$gmvault → ~/Library/Application Support/Sublime Text 3/ Packages"
    fi

    execute "ln -s $gmvault ~/.gmvault" "$gmvault → ~/.gmvault"
    execute "ln -s $vms ~/VirtualBox\ VMs" "$vms → ~/VirtualBox\ VMs"
}

main
