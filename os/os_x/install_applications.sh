#!/bin/bash

cd "$(dirname "${BASH_SOURCE}")" && source "../utils.sh"

# Homebrew Formulae
# https://github.com/Homebrew/homebrew

declare -a HOMEBREW_FORMULAE=(
    "bash-completion"
    "caskroom/cask/brew-cask"
    "git"
    "imagemagick --with-webp"
    "vim --override-system-vi"
    "zopfli"
)

# Homebrew Casks
# https://github.com/caskroom/homebrew-cask

declare -a HOMEBREW_CASKS=(
    "android-file-transfer"
    "dropbox"
    "firefox"
    "flash"
    "imageoptim"
    "libreoffice"
    "licecap"
    "lisanet-gimp"
    "spectacle"
    "the-unarchiver"
    "transmission"
    "virtualbox"
    "vlc"
    "android-platform-tools"
    "aria2"
    "eot-utils"
    "fdupes"
    "fontforge"
    "gpg"
    "jq"
    "lame"
    "openssl"
    "pidof"
    "pip"
    "python"
    "rar"
    "reattach-to-user-namespace"
    "ruby"
    "stat"
    "tmux"
    "unrar"
    "wget"
    "yarn"
)

# Homebrew Alternate Casks
# https://github.com/caskroom/homebrew-versions

declare -a HOMEBREW_ALTERNATE_CASKS=(
    "firefox-nightly"
    "google-chrome-canary"
    "webkit-nightly"
)

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    local i="", tmp=""

    # XCode Command Line Tools
    if [ $(xcode-select -p &> /dev/null; printf $?) -ne 0 ]; then
        xcode-select --install &> /dev/null

        # Wait until the XCode Command Line Tools are installed
        while [ $(xcode-select -p &> /dev/null; printf $?) -ne 0 ]; do
            sleep 5
        done
    fi

    print_success "XCode Command Line Tools\n"

    # # Homebrew
    # if ! cmd_exists "brew"; then
    #     printf "\n" | ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    #     #  └─ simulate the ENTER keypress
    #     print_result $? "brew"
    # fi

    # if cmd_exists "brew"; then

    #     execute "brew update" "brew (update)"
    #     execute "brew upgrade" "brew (upgrade)"
    #     execute "brew cleanup" "brew (cleanup)"

    #     # Homebrew formulae
    #     for i in ${!HOMEBREW_FORMULAE[*]}; do
    #         tmp="${HOMEBREW_FORMULAE[$i]}"
    #         [ $(brew list "$tmp" &> /dev/null; printf $?) -eq 0 ] \
    #             && print_success "$tmp" \
    #             || execute "brew install $tmp" "$tmp"
    #     done

    #     printf "\n"

    #     # Homebrew casks
    #     if [ $(brew list brew-cask &> /dev/null; printf $?) -eq 0 ]; then

    #         for i in ${!HOMEBREW_CASKS[*]}; do
    #             tmp="${HOMEBREW_CASKS[$i]}"
    #             [ $(brew cask list "$tmp" &> /dev/null; printf $?) -eq 0 ] \
    #                 && print_success "$tmp" \
    #                 || execute "brew cask install $tmp" "$tmp"
    #         done

    #         printf "\n"

    #         # Homebrew alternate casks
    #         brew tap caskroom/versions &> /dev/null

    #         if [ $(brew tap | grep "caskroom/versions" &> /dev/null; printf $?) -eq 0 ]; then
    #             for i in ${!HOMEBREW_ALTERNATE_CASKS[*]}; do
    #                 tmp="${HOMEBREW_ALTERNATE_CASKS[$i]}"
    #                 [ $(brew cask list "$tmp" &> /dev/null; printf $?) -eq 0 ] \
    #                     && print_success "$tmp" \
    #                     || execute "brew cask install $tmp" "$tmp"
    #             done
    #         fi
    #     fi

    # fi

    slack
    sublime
}

slack() {
    open_webpage 'https://www.google.com/?q=download+slack+mac'


    ask_for_confirmation "Is slack installed?"
    printf "\n"
}

sublime() {
    open_webpage 'https://www.google.com/?q=download+sublime text 3+mac'

    echo 'Sublime Text License'
    cat ~/Dropbox/Backup/sublime_text/sublime.txt
    printf "\n"

    ask_for_confirmation "Is sublime text installed?"
    printf "\n"
}

main
