#!/bin/bash

user=$1
mountDir="/mnt/data"

"/dev/sdb1 ${mountDir} ntfs-3g defaults 0 0" >>> /etc/fstab

rm -rf /home/${user}/Documents
rm -rf /home/${user}/Music
rm -rf /home/${user}/Pictures

ln -s /mnt/data/Documents /home/${user}/Documents
ln -s /mnt/data/Music /home/${user}/Music
ln -s /mnt/data/Pictures /home/${user}/Pictures
ln -s /mnt/data/Github /home/${user}/Github
ln -s /mnt/data/Anime /home/${user}/Videos/Anime
ln -s /mnt/data/Movies /home/${user}/Videos/Movies
