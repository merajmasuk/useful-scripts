#!/bin/bash

##########################################################
# Author:	Meraj al Maksud
# Platform:	GNU/Linux
# Usage:	Place it in /usr/local/bin directory
# Assemble and Execute assembly language codes in one line
##########################################################

# escape codes
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'
BOLD='\033[1m'
ITALIC='\033[3m'

param=$1

if command -v nasm &> /dev/null
then
	echo "Please install nasm"
	echo "Try: sudo apt install nasm"
	exit
elif command -v ld &> /dev/null
then
	echo "Please install gcc"
	echo "Try: sudo apt install gcc"
	exit
elif [ -z "$param" ]
then
	echo "asm: missing file operand"
	echo -e "Usage: asm <file>\t\t${BOLD}Filename must end with .asm${NC}"
	exit
fi

src=$param
name=${src:0:-4}
object=$name.o
exe=$name.out

nasm -f elf64 "$src"
ld "$object" -o "$exe"
./"$exe"
