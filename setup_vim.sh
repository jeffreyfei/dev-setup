#!/bin/bash

set -e

# Load constants and functions
source constants.sh

colorscheme="colorscheme jellybeans"
jellybean_theme_url=https://raw.githubusercontent.com/nanotech/jellybeans.vim/master/colors/jellybeans.vim
vimcompletesme_url=git://github.com/ajh17/VimCompletesMe.git
mdr_url=https://github.com/MichaelMure/mdr/releases/download/v0.2.5/mdr_linux_386

repo_home=$(pwd)

echo "Update .vimrc? (y/n)"
read res
if [[ $res = "y" ]]; then
    if type vim > /dev/null || type vimx > /dev/null; then
        check_and_replace_file $vimrc_path $repo_home/.vimrcbase
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
    # Install vimplug
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    # Install VimPlug plugins
    echo "call plug#begin('~/.vim/plugged')"  >> $vimrc_path
    echo "Install vimtex?"
    read res
    if [[ $res = "y" ]]; then
        echo "Plug 'lervag/vimtex'" >> $vimrc_path
    fi

    echo "Install nerdtree?"
    read res
    if [[ $res = "y" ]]; then
        echo "Plug 'preservim/nerdtree'" >> $vimrc_path
    fi

    echo "call plug#end()" >> $vimrc_path

    vim +PlugInstall +qall

    # Insert NerdTree config
    cat $repo_home/nerdtree_conf >> $vimrc_path

    # Install VimCompletesMe
    echo "Install VimCompletesMe?"
    read res
    if [[ $res = "y" ]]; then
        git clone $vimcompletesme_url ~/.vim/pack/vendor/start/VimCompletesMe
    fi

    echo "Install MD Preview?"
    read res
    if [[ $res = "y" ]]; then
        git clone git@github.com:skanehira/preview-markdown.vim.git /tmp/mdplug
        mkdir -p ~/.vim/autoload
        cp -r /tmp/mdplug/autoload/* ~/.vim/autoload
        mkdir -p ~/.vim/plugin
        cp -r /tmp/mdplug/plugin/* ~/.vim/plugin

        cat $repo_home/mdpreview_conf >> $vimrc_path

        # Install mdr
        mkdir -p ~/bin
        wget $mdr_url -O ~/bin/mdr
    fi
fi
