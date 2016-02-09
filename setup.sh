#!/bin/bash

mkdir -p ~/.vim

mkdir -p ~/.vim/view
mkdir -p ~/.vim/undo
mkdir -p ~/.vim/bundle
# TODO get Vundle

# TODO get pwd

rm ~/.profile
rm ~/.bashrc
rm ~/.bash_logout
rm ~/.bash_aliases
rm ~/.screenrc
rm ~/.vimrc

ln ~/.profile .profile
ln ~/.bashrc .bashrc
ln ~/.bash_logout .bash_logout
ln ~/.bash_aliases .bash_aliases
ln ~/.screenrc .screenrc
ln ~/.vimrc .vimrc
