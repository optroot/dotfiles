#!/bin/bash

cd "$(dirname "$0")"

mkdir -p ~/.vim
mkdir -p ~/.vim/view
mkdir -p ~/.vim/undo
curl -sfLo ~/.vim/autoload/plug.vim --create-dirs 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

link() {
  rm -f ~/.$1
  ln $1 ~/.$1
}

link bash_aliases
link bash_logout
link bashrc
link dircolors
link gitconfig
link profile
link screenrc
link selected_editor
link tmux.conf
link vimrc

