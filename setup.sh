#!/bin/bash

function vim {
    echo "Initializing vim...\n"
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
}


while getopts ":av" opt; do
    case $opt in
        a)
            echo "Full initialization in progress...\n"
            vim
            ;;
        v)
            vim
            ;;
        \?)
            echo "Invalid option: -$OPTARG"
            ;;
    esac
done
