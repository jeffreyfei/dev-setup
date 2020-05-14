#!/bin/bash

gitconfig_path=$HOME/.gitconfig
git_email=jeffreyfei@msn.com
bashrc_path=$HOME/.bashrc
zshrc_path=$HOME/.zshrc
mybashrc_path=$HOME/.mybashrc
vimrc_path=$HOME/.vimrc
terminator_config_path=$HOME/.config/terminator

# Check the existence of the file and prompt the user
# yes - replace file with link; no -do nothing
# $1 = target file path
# $2 = source file path
check_and_link_file() {
    if [[ -f $1 ]]; then
        echo "Warning: $1 already exists. Replace with symlink? (y/n)"
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

# Check the existence of the file and prompt the user
# yes - replace dir with link; no -do nothing
# $1 = target dir path
# $2 = source dir path
check_and_link_dir() {
    if [[ -d $1 ]]; then
        echo "Warning: $1 already exists. Replace with symlink? (y/n)"
        read res
        if [[ $res = "y" ]]; then
            rm -rf $1
            echo "$1 removed"
            # Create symlink for the config file
            ln -s $2 $1
            echo "Symlink: $1 created"
        fi
    fi
}

# Check the existence of the file and prompt the user
# yes - replace file; no -do nothing
# $1 = target file path
# $2 = source file path
check_and_replace_file() {
    if [[ -f $1 ]]; then
        echo "Warning: $1 already exists. Replace and continue? (y/n)"
        read res
        if [[ $res = "y" ]]; then
            rm $1
            echo "$1 removed"
            # Replace config file
            cp $2 $1
            echo "Symlink: $1 created"
        fi
    fi
}

