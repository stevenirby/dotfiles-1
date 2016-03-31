#!/bin/bash

cd "$(dirname "${BASH_SOURCE}")";

sudo rm -r ~/Documents/ ~/Documents/
ln -s -f ~/Dropbox/DellXPS13/Downloads/ ~/Downloads/
ln -s -f ~/Dropbox/DellXPS13/Documents/ ~/Documents/
