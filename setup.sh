#!/bin/bash

${XDG_CONFIG_HOME:=$HOME/.config}
echo "Backing up existing neovim config"
today=`date +%Y%m%d`
nvim="${XDG_CONFIG_HOME}/nvim"
[ -e $nvim ] && [ ! -L $nvim ] && mv $nvim $nvim.$today

echo "Creating symlinks"
lnif() {
  if [ ! -e $2 ] ; then
    ln -s $1 $2
  fi
  if [ -L $2 ] ; then
    ln -sf $1 $2
  fi
}
lnif $PWD $nvim

echo "Installing vim-plug"
curl -fLo ${nvim}/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

nvim -u . +PlugInstall +qall
