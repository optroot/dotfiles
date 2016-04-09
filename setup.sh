#!/bin/bash

cd "$(dirname "$0")"

mkdir -p ~/.vim
mkdir -p ~/.vim/view
mkdir -p ~/.vim/undo
curl -sfLo ~/.vim/autoload/plug.vim --create-dirs 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
rm -f ~/.vim/UltiSnips
ln -s UltiSnips ~/.vim/UltiSnips

link() {
  rm -f ~/.$1
  ln $1 ~/.$1
}

cd files
for f in *
do
  link $f
done

