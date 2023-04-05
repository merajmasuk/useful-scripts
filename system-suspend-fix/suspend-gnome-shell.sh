#!/bin/bash

# https://bbs.archlinux.org/viewtopic.php?id=277713

case "$1" in
        suspend)
            killall -STOP gnome-shell
            ;;
            resume)
            killall -CONT gnome-shell
            ;;
esac
