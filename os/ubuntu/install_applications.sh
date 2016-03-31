#!/bin/bash

cd "$(dirname "${BASH_SOURCE}")" && source "../utils.sh"

declare -a APT_PACKAGES=(

    # Tools for compiling/building software from source
    "build-essential"

    # GnuPG archive keys of the Debian archive
    "debian-archive-keyring"

    # Software which is not included by default
    # in Ubuntu due to legal or copyright reasons
    #"ubuntu-restricted-extras"

    # Other
    "curl"
    "unar"
    "gimp"
    "git"
    "gparted"
    "imagemagick"
    "mac-ithemes-v3"
    "mac-icons-v3"
    "nautilus-dropbox"
    "nodejs"
    "npm"
    "network-manager-openvpn"
    "php5-cli"
    "python-pip"
    "rar"
    "transmission"
    "kazam"
    "vim"
    "virtualbox"
    "vlc"
    "xclip"
    "wine"
    "jq"
    "oracle-java8-installer"
    "rubyq"

)

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

add_key() {
    wget -qO - "$1" | sudo apt-key add - &> /dev/null
    #     │└─ write output to file
    #     └─ don't show output
}

add_ppa() {
    sudo add-apt-repository -y "$1" &> /dev/null
}

add_source_list() {
    sudo sh -c "printf 'deb $1' >> '/etc/apt/sources.list.d/$2'"
}

add_software_sources() {
    # apple theme
    add_ppa "noobslab/themes"

    [ $(cmd_exists "atom") -eq 1 ] \
        && add_ppa "webupd8team/atom"

    # Google Chrome
    [ $(cmd_exists "google-chrome") -eq 1 ] \
        && add_key "https://dl-ssl.google.com/linux/linux_signing_key.pub" \
        && add_source_list \
                "http://dl.google.com/linux/chrome/deb/ stable main" \
                "google.list"
}


install_package() {
    local q="${2:-$1}"

    if [ $(cmd_exists "$q") -eq 1 ]; then
        execute "sudo apt-get install --allow-unauthenticated -qqy $1" "$1"
        #                                      suppress output ─┘│
        #            assume "yes" as the answer to all prompts ──┘
    fi
}

remove_unneeded_packages() {

    # Remove packages that were automatically installed to satisfy
    # dependencies for other other packages and are no longer needed
    execute "sudo apt-get autoremove -qqy" "autoremove"

}

update_and_upgrade() {

    # Resynchronize the package index files from their sources
    execute "sudo apt-get update -qqy" "update"

    # Unstall the newest versions of all packages installed
    execute "sudo apt-get upgrade -qqy" "upgrade"

}

node() {
    xdg-open 'https://www.google.com/?q=download+nodejs+ubuntu' > /dev/null

    ask_for_confirmation "Is node installed and you want to continue?"
    printf "\n"

    if answer_is_yes; then
        echo
    fi
}

chrome() {
    xdg-open 'https://www.google.com/?q=download+chrome+ubuntu' > /dev/null

    ask_for_confirmation "Is chrome installed and you want to continue?"
    printf "\n"

    if answer_is_yes; then
        echo
    fi
}

slack() {
    xdg-open 'https://www.google.com/?q=download+slack+ubuntu' > /dev/null

    ask_for_confirmation "Is slack installed and you want to continue?"
    printf "\n"

    if answer_is_yes; then
        echo
    fi
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {
    local i=""

    add_software_sources
    update_and_upgrade
    slack
    node

    printf "\n"

    for i in ${!APT_PACKAGES[*]}; do
        install_package "${APT_PACKAGES[$i]}"
    done

    printf "\n"

    remove_unneeded_packages

}

main
