#!/bin/bash

cd "$(dirname "${BASH_SOURCE}")" \
    && . "./utils.sh"

declare -r -a NPM_PACKAGES=(
    "jshint"
    "gulp"
    "karma-cli"
    "bower"
    "yarn"
)

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {
    source ~/.bashrc
    # Make sure the most recent version of `npm` is installed
    execute "npm install --global npm" "npm (update)"

    # Install the `npm` packages
    for i in ${NPM_PACKAGES[@]}; do
        execute "npm install --global $i" "$i"
    done

}

main
