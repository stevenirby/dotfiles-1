#!/bin/bash

cd "$(dirname "${BASH_SOURCE}")";

sudo rm -r ~/Downloads/ ~/Documents/
sudo ln -s -f ~/Dropbox/DellXPS13/Downloads/ ~/Downloads/
sudo ln -s -f ~/Dropbox/DellXPS13/Documents/ ~/Documents/

# copy the auid file
cp ~/Dropbox/DellXPS13/.audit ~/

# copy the sublime text settings and what no
# TODO