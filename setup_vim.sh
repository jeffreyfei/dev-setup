#!/bin/bash

set -e

# Load constants and functions
source constants.sh

colorscheme="colorscheme jellybeans"
jellybean_theme_url=https://raw.githubusercontent.com/nanotech/jellybeans.vim/master/colors/jellybeans.vim
vimcompletesme_url=git://github.com/ajh17/VimCompletesMe.git


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
read res
if [[ $res = "y" ]]; then
    mkdir -p ~/.vim/colors
    cd ~/.vim/colors; curl -O $jellybean_theme_url
    echo $colorscheme >> $vimrc_path
fi

echo "Install plugins? (y/n)"
read res
if [[ $res = "y" ]]; then
    # Install VimPlug plugins
    echo "plug#begin('~/.vim/plugged')"  >> $vim_path
    echo "Install vimtex?"
    read res
    if [[ $res = "y" ]]; then
        echo "Plug 'lervag/vimtex'" >> $vim_path
    fi

    echo "Install nerdtree?"
    read res
    if [[ $res = "y" ]]; then
        echo "Plug 'preservim/nerdtree'" >> $vim_path
    fi

    echo "call plug#end()" >> $vim_path

    vim +PlugInstall +qall

    # Insert NerdTree config
    cat $(pwd)/nerdtree_conf >> $vim_path

    # Install VimCompletesMe
    echo "Install VimCompletesMe?"
    read res
    if [[ $res = "y" ]]; then
        git clone $vimcompletesme_url ~/.vim/pack/vendor/start/VimCompletesMe
    fi
fi
