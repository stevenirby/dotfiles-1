#!/bin/bash

cd "$(dirname "${BASH_SOURCE}")" && source "utils.sh"

main() {
    local subl="/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl"
    local gmvault="~/Dropbox/Backup/.gmvault"
    local alfredWorkflows="~/Dropbox/Backup/workflows"
    local vms="~/Dropbox/Backup/VirtualBox\ VMs/"
    local sublimePackages="~/Dropbox/Backup/sublime_text/"
    declare -r OS="$(get_os)"

    # OS specific symlinks
    if [ "$OS" == "osx" ]; then
        execute "ln -s $subl /usr/local/bin/sublime" "$subl → /usr/local/bin/sublime"
        execute "ln -s $alfredWorkflows ~/workflows" "$alfredWorkflows → ~/workflows"
        execute "ln -s $sublimePackages ~/Library/Application\ Support/Sublime Text 3/" "$sublimePackages → ~/Library/Application\ Support/Sublime\ Text\ 3"
    elif [ "$OS" == "ubuntu" ]; then
        execute "rm -r ~/.config/sublime-text-3" "rm ~/.config/sublime-text-3"
        execute "ln -s $sublimePackages ~/.config/sublime-text-3" "$sublimePackages → ~/.config/sublime-text-3"
    fi

    execute "ln -s $gmvault ~/.gmvault" "$gmvault → ~/.gmvault"
    execute "ln -s $vms ~/VirtualBox\ VMs" "$vms → ~/VirtualBox\ VMs"

    apps
}

apps() {
    local apps="~/Dropbox/Backup/Macbook\ Pro/Applications/*"

    if [ "$OS" == "osx" ]; then
        execute "cp -a $apps /Applications/" "$apps → /Applications"
    fi
}

main
