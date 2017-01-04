#!/bin/bash

cd "$(dirname "$0")"

mkdir -p ~/.vim
mkdir -p ~/.vim/view
mkdir -p ~/.vim/undo

# TODO check if exists
# leave to vim
#curl -sfLo ~/.vim/autoload/plug.vim --create-dirs 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

rm -f ~/.vim/UltiSnips
ln -s `readlink -e UltiSnips` ~/.vim/UltiSnips

link() {
  echo $1
  rm -fi ~/.$1
  ln $1 ~/.$1
}

cd files
for f in *
do
    link $f
done

