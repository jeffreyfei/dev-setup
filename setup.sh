#!/bin/bash

set -e

gitconfig_path=$HOME/.gitconfig
bashrc_path=$HOME/.bashrc
zshrc_path=$HOME/.zshrc
mybashrc_path=$HOME/.mybashrc

# Check the existence of the file and prompt the user
# $1 = target file path
# $2 = source file path
check_and_replace_file() {
    if [[ -f $1 ]]; then
        echo "Warning: $1 already exists. Replace and continue? (y/n)"
        read res
        if [[ $res = "y" ]]; then
            rm $1
            echo "$1 removed"
            # Create symlink for the config file
            ln -s $2 $1
            echo "Symlink: $1 created"
        fi
    fi
}

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

# Update .gitconfig
echo "Update .gitconfig? (y/n)"
read res
if [[ $res = "y" ]]; then
    check_and_replace_file $gitconfig_path $(pwd)/.gitconfig
fi

echo "Update .bashrc/.zshrc? (y/n)"

read res
if [[ $res = "y" ]]; then
    mybashrc_ref="source ~/.mybashrc"
    check_and_replace_file $mybashrc_path $(pwd)/.mybashrc
    if [[ -f $bashrc_path ]]; then
        if ! (cat $bashrc_path | grep -Fxq "$mybashrc_ref"); then
            echo $mybashrc_ref >> $bashrc_path
        fi
    fi

    if [[ -f $zshrc_path ]]; then
        if ! (cat $zshrc_path | grep -Fxq "$mybashrc_ref"); then
            echo $mybashrc_ref >> $zshrc_path
        fi
    fi
fi
