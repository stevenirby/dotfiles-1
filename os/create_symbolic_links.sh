#!/bin/bash

cd "$(dirname "${BASH_SOURCE}")" && source "utils.sh"

declare -a DOT_FILES_TO_SYMLINK=(
    "shell/bash_aliases"
    "shell/bash_exports"
    "shell/bash_functions"
    "shell/bash_logout"
    "shell/bash_options"
    "shell/bash_profile"
    "shell/bash_prompt"
    "shell/bashrc"
    "shell/curlrc"
    "shell/inputrc"

    "git/gitattributes"
    "git/gitignore"

    "vim/vim"
    "vim/vimrc"
    "vim/gvimrc"

    "tmux/tmux.conf"
)

declare -a FILES_TO_SYMLINK=(
    "Dropbox/Backup"
    "Dropbox/Documents"
    "Dropbox/Downloads"
    "Dropbox/Gmail"

)

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

createDotfileLinks() {

    local i=""
    local sourceFile=""
    local targetFile=""

    for i in ${DOT_FILES_TO_SYMLINK[@]}; do

        sourceFile="$(cd .. && pwd)/$i"
        targetFile="$HOME/.$(printf "%s" "$i" | sed "s/.*\/\(.*\)/\1/g")"

        if [ -e "$targetFile" ]; then
            if [ "$(readlink "$targetFile")" != "$sourceFile" ]; then

                ask_for_confirmation "'$targetFile' already exists, do you want to overwrite it?"
                if answer_is_yes; then
                    # rm -rf "$targetFile"
                    execute "ln -fs $sourceFile $targetFile" "$targetFile → $sourceFile"
                else
                    print_error "$targetFile → $sourceFile"
                fi

            else
                print_success "$targetFile → $sourceFile"
            fi
        else
            execute "ln -fs $sourceFile $targetFile" "$targetFile → $sourceFile"
        fi

    done

}

createFolderLinks() {

    local i=""
    local sourceFile=""
    local targetFile=""

    for i in ${FILES_TO_SYMLINK[@]}; do

        sourceFile="$(cd .. && pwd)/$i"
        targetFile="$HOME/$(printf "%s" "$i" | sed "s/.*\/\(.*\)/\1/g")"

        if [ -e "$targetFile" ]; then
            if [ "$(readlink "$targetFile")" != "$sourceFile" ]; then

                ask_for_confirmation "'$targetFile' already exists, do you want to overwrite it?"
                if answer_is_yes; then
                    # rm -rf "$targetFile"
                    execute "ln -fs $sourceFile $targetFile" "$targetFile → $sourceFile"
                else
                    print_error "$targetFile → $sourceFile"
                fi

            else
                print_success "$targetFile → $sourceFile"
            fi
        else
            execute "ln -fs $sourceFile $targetFile" "$targetFile → $sourceFile"
        fi

    done
}

others() {
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

createDotfileLinks
createFolderLinks
