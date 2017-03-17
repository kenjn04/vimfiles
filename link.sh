#!/bin/bash

[ "${OSTYPE}" == "cygwin" ] && export CYGWIN="winsymlinks"

ln -s `pwd`/vim ~/.vim
ln -s `pwd`/vimrc ~/.vimrc
