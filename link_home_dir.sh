#!/bin/bash

set -e

checkAndRemove() {
    if [[ -z $(ls -A /home/$USER/$1) ]]; then
        echo "Warning: $1 not empty. Continue? (y/n)"
        read res
        if [[ $res = "y" ]]; then
            rm -rf /home/$USER/$1
            echo "/home/USER/$1 removed"

            ln -s /mnt/data/$1 /home/${user}/$1
        else
            echo "Doing nothing"
        fi
    fi
}

mountDir=$1

echo "/dev/sdb1 ${mountDir} ntfs-3g defaults 0 0" >> /etc/fstab

checkAndRemove Documents
checkAndRemove Music
checkAndRemove Pictures

ln -s /mnt/data/Music /home/${user}/Music
ln -s /mnt/data/Pictures /home/${user}/Pictures
ln -s /mnt/data/Github /home/${user}/Github
ln -s /mnt/data/Anime /home/${user}/Videos/Anime
ln -s /mnt/data/Movies /home/${user}/Videos/Movies
