#!/bin/bash

set -e

# Load constants and functions
source constants.sh

colorscheme="colorscheme jellybeans"
jellybean_theme_url=https://raw.githubusercontent.com/nanotech/jellybeans.vim/master/colors/jellybeans.vim
vimcompletesme_url=https://github.com/ajh17/VimCompletesMe.git
mdr_url=https://github.com/MichaelMure/mdr/releases/download/v0.2.5/mdr_linux_386
mdplug_url=https://github.com/skanehira/preview-markdown.vim.git

repo_home=$(pwd)

mkdir -p ~/.vimbackup

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
    echo "Install vimtex? (y/n)"
    read res
    if [[ $res = "y" ]]; then
        echo "Plug 'lervag/vimtex'" >> $vimrc_path
    fi

    echo "Install nerdtree? (y/n)"
    read res
    if [[ $res = "y" ]]; then
        echo "Plug 'preservim/nerdtree'" >> $vimrc_path
    fi

    echo "call plug#end()" >> $vimrc_path

    vim +PlugInstall +qall

    # Insert NerdTree config
    cat $repo_home/nerdtree_conf >> $vimrc_path

    # Install VimCompletesMe
    echo "Install VimCompletesMe? (y/n)"
    read res
    if [[ $res = "y" ]]; then
        git clone $vimcompletesme_url ~/.vim/pack/vendor/start/VimCompletesMe    
    fi

    echo "Install MD Preview? (y/n)"
    read res
    if [[ $res = "y" ]]; then
        git clone $mdplug_url /tmp/mdplug
        mkdir -p ~/.vim/autoload
        cp -r /tmp/mdplug/autoload/* ~/.vim/autoload
        mkdir -p ~/.vim/plugin
        cp -r /tmp/mdplug/plugin/* ~/.vim/plugin

        rm -rf /tmp/mdplug.zip
        rm -rf /tmp/mdplug

        cat $repo_home/mdpreview_conf >> $vimrc_path

        # Install mdr
        mkdir -p ~/bin
        wget $mdr_url -O ~/bin/mdr
        chmod +x ~/bin/mdr
    fi
fi
