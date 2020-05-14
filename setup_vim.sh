#!/bin/bash

set -e

# Load constants and functions
source constants.sh

colorscheme="colorscheme jellybeans"
jellybean_theme_url=https://raw.githubusercontent.com/nanotech/jellybeans.vim/master/colors/jellybeans.vim


echo "Update .vimrc? (y/n)"
read res
if [[ $res = "y" ]]; then
    if type vim > /dev/null || type vimx > /dev/null; then
        check_and_replace_file $vimrc_path $(pwd)/.vimrcbase
    else
        echo "Vim not found, please install vim first"
        exit 1
    fi
fi

echo "Install jellybean colorscheme? (y/n)"
if [[ $res = "y" ]]; then
    mkdir -p ~/.vim/colors
    cd ~/.vim/colors; curl -O $jellybean_theme_url
    echo $colorscheme >> $vimrc_path
fi
