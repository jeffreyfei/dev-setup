#!/bin/bash

echo "Configuring thinkpad keymap"
xmodmap -e 'keycode 164 = XF86AudioStop' && \
    xmodmap -e 'keycode 162 = XF86AudioPlay' && \
    xmodmap -e 'keycode 164 = XF86AudioStop' && \
    xmodmap -e 'keycode 153 = XF86AudioNext'
echo "Done"
