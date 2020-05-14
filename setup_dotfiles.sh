#!/bin/bash

set -e

# Load constants and functions
source constants.sh

# Update .gitconfig
echo "Update .gitconfig? (y/n)"
read res
if [[ $res = "y" ]]; then
    if type git >> /dev/null; then
        check_and_link_file $gitconfig_path $(pwd)/.gitconfig
    else
        echo "Git not installed. Please install git first."
    fi
fi

echo "Update .bashrc/.zshrc? (y/n)"
read res
if [[ $res = "y" ]]; then
    mybashrc_ref="source ~/.mybashrc"
    check_and_link_file $mybashrc_path $(pwd)/.mybashrc
    check_and_link_file $bashrc_path $(pwd)/.bashrc
    check_and_link_file $zshrc_path $(pwd)/.zshrc
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

echo "Are you using Terminator? (y/n)"
read res
if [[ $res = "y" ]]; then
    if type terminator >> /dev/null; then
        check_and_link_dir $terminator_config_path config/terminator
    else
        echo "Terminator not installed. Please install terminator first."
    fi
fi
