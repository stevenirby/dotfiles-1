#!/bin/bash

cd "$(dirname "${BASH_SOURCE}")" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_plugins() {

    declare -r VUNDLE_DIR="$HOME/.vim/plugins/Vundle.vim"
    declare -r VUNDLE_GIT_REPO_URL="https://github.com/VundleVim/Vundle.vim.git"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Install plugins.

    execute \
        "rm -rf '$VUNDLE_DIR' \
            && git clone --quiet '$VUNDLE_GIT_REPO_URL' '$VUNDLE_DIR' \
            && printf '\n' | vim +PluginInstall +qall" \
        "Install plugins" \
        || return 1

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Install additional things required by some plugins.

    execute \
        ". $HOME/.bashrc \
            && cd $HOME/.vim/plugins/tern_for_vim \
            && npm install" \
        "Install plugins (extra installs for 'tern_for_vim')"

}

update_plugins() {

    execute \
        "vim +PluginUpdate +qall" \
        "Update plugins"

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    declare -r OS="$(get_os)"

    print_in_purple "\n   Vim\n\n"

    if [ "$OS" == "osx" ]; then
        execute "brew install vim --with-override-system-vi" "brew install vim"
    elif [ "$OS" == "ubuntu" ]; then
        if isServerMode; then
            execute "sudo apt-get -y install vim" "apt-get install vim"
        else
            execute "sudo apt-get -y install vim-gnome" "apt-get install vim"
        fi
    fi

    printf "\n"

    install_plugins
    update_plugins

}

main