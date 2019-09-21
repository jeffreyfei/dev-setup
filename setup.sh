#!/bin/bash

function vim {
    echo "Initializing vim..."
    echo "Setting up pathogen..."
    # Set syntax highlighting
    cp -v .vimrc ~
    cp -rv .vim ~
}

function profile {
    echo "Updating bash profile..."
    cp ./.bashrc ~/
    echo "Done"
    echo "Updating zshrc profile..."
    cp ./.zshrc ~/
    echo "Done"
    echo "Updating ssh profile..."
    cp -r .ssh ~
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
