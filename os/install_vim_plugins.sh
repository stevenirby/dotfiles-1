#!/bin/bash
set -e
set -x
cd vim
sudo cp -av . /usr/share/vim/vimfiles/.
sudo helpztags /usr/share/vim/vimfiles/doc
sudo apt-get install libxml2-utils exuberant-ctags
