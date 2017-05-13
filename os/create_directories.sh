#!/bin/bash

cd "$(dirname "${BASH_SOURCE}")" && source "utils.sh"

declare -a DIRECTORIES=(
    "$HOME/tmp"
    "$HOME/Downloads/torrents"
    "$HOME/projects",
    "$HOME/.vim"
)

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {
    for i in ${DIRECTORIES[@]}; do
        mkd "$i"
    done
}

main
