#!/bin/bash

function vim {
    echo "Initializing vim..."
    echo "Setting up pathogen..."
    # Set syntax highlighting
    mkdir -p ~/.vim/after/syntax
    cp -r syntax/* ~/.vim/after/syntax
    # Get pathogen
    mkdir -p ~/.vim/autoload ~/.vim/bundle
    curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
    # Copy over vimrc
    cp ./.vimrc ~/
    # Copy over color scheme
    mkdir -p ~/.vim/colors
    cp -r ./colors/* ~/.vim/colors

    mkdir -p  ~/vim/bundle
    cd ~/.vim/bundle
    mv vim-colors-solarized ~/.vim/bundle/
    # Get syntastic
    git clone --depth=1 https://github.com/vim-syntastic/syntastic.git
    # Get solarized
    git clone git://github.com/altercation/vim-colors-solarized.git
    # Get vim-vue
    # git clone https://github.com/posva/vim-vue.git
    # Get vim-vue syntastic
    # git clone https://github.com/sekel/vim-vue-syntastic.git
    # Get ES6 highlighting
    # git clone https://github.com/isRuslan/vim-es6.git
    # Get pug highlighting
    # git clone git://github.com/digitaltoad/vim-pug.git
    # Get sass highlighting
    # git clone https://github.com/hail2u/vim-css3-syntax.git
}

function profile {
    echo "Updating bash profile..."
    cp ./.bashrc ~/
    echo "Done"
    echo "Updating zshrc profile..."
    cp ./.zshrc ~/
    echo "Done"
    echo "Updating ssh profile..."
    cp ./config ~/.ssh
    echo "Done"
}

function thinkpad_keymap {
    echo "Configuring thinkpad keymap"
    xmodmap -e 'keycode 164 = XF86AudioStop' && \
        xmodmap -e 'keycode 162 = XF86AudioPlay' && \
        xmodmap -e 'keycode 164 = XF86AudioStop' && \
        xmodmap -e 'keycode 153 = XF86AudioNext'
    echo "Done"
}

while getopts ":avhpt" opt; do
    case $opt in
        a)
            echo "Full initialization in progress..."
            vim
            profile
            ;;
        v)
            vim
            ;;
        p)
            profile
            ;;
        t)
            thinkpad_keymap
            ;;
        h)
            echo "-------Setup dev enviroment---------"
            echo ""
            echo "-a Apply all setup"
            echo "-v Apply vim only"
            echo "-p Apply profile only"
            echo "-t Apply thinkpad specific setup"
            echo ""
            echo "By: Jeffrey Fei"
            echo "------------------------------------"
            ;;
        \?)
            echo "Invalid option: -$OPTARG"
            ;;
    esac
done
