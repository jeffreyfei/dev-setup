#!/bin/bash

function vim {
    echo "Initializing vim..."
    echo "Setting up pathogen..."
    # Get pathogen
    mkdir -p ~/.vim/autoload ~/.vim/bundle
    curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
    # Copy over vimrc
    cp ./.vimrc ~/
    cd ~/.vim/bundle
    # Get syntastic
    git clone --depth=1 https://github.com/vim-syntastic/syntastic.git
    # Get vim-vue
    git clone https://github.com/posva/vim-vue.git
    # Get vim-vue syntastic
    git clone https://github.com/sekel/vim-vue-syntastic.git
    # Get ES6 highlighting
    git clone https://github.com/isRuslan/vim-es6.git
    # Get pug highlighting
    git clone git://github.com/digitaltoad/vim-pug.git
    # Get sass highlighting
    git clone https://github.com/hail2u/vim-css3-syntax.git
}


while getopts ":avh" opt; do
    case $opt in
        a)
            echo "Full initialization in progress..."
            vim
            ;;
        v)
            vim
            ;;
        h)
            echo "-------Setup dev enviroment---------"
            echo ""
            echo "-a Apply all setup"
            echo "-v Apply vim only"
            echo ""
            echo "By: Jeffrey Fei"
            echo "------------------------------------"
            ;;
        \?)
            echo "Invalid option: -$OPTARG"
            ;;
    esac
done
