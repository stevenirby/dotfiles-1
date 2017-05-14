#!/bin/bash

cd "$(dirname "${BASH_SOURCE}")" && source "utils.sh"

declare -a FILES_TO_COPY=(
    "git/gitconfig"
)

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    local i=""
    local sourceFile=""
    local targetFile=""

    for i in ${FILES_TO_COPY[@]}; do

        sourceFile="$(cd .. && pwd)/$i"
        targetFile="$HOME/.$(printf "%s" "$i" | sed "s/.*\/\(.*\)/\1/g")"

        if [ -e "$targetFile" ]; then
            ask_for_confirmation "'$targetFile' already exists, do you want to overwrite it?"
            if answer_is_yes; then
                rm -rf "$targetFile"
                execute "cp $sourceFile $targetFile" "$targetFile → $sourceFile"
            else
                print_error "$targetFile → $sourceFile"
            fi
        else
            execute "cp $sourceFile $targetFile" "$targetFile → $sourceFile"
        fi

    done

    openGitConfig
    audit
    apps
    vpn
}

openGitConfig() {
    nano $HOME/.gitconfig
}

audit() {
    local audit="~/Dropbox/Backup/.audit"
    execute "cp $audit $HOME" "$audit → $HOME"
}

vpn() {
    local vpn="~/Dropbox/Backup/.audit"
    execute "cp $vpn $HOME" "$vpn → $HOME"
}

apps() {
    declare -r OS="$(get_os)"
    local apps="~/Dropbox/Backup/Macbook\ Pro/Applications/*"

    if [ "$OS" == "osx" ]; then
        execute "cp -av $apps $HOME/Applications/" "$apps → $HOME/Applications"
    fi
}

main
