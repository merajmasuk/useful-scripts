#!/bin/bash

# check root priviledges
if [ "$EUID" -ne 0 ]; then
        echo "Please run this script as root or with sudo."
        exit
fi

# disable kbd
internal_keyboard_name="Virtual core XTEST keyboard"
xinput disable "$internal_keyboard_name"
