#!/bin/bash

${XDG_CONFIG_HOME:=$HOME/.config}
echo "Backing up existing neovim config"
today=`date +%Y%m%d`
nvim="${XDG_CONFIG_HOME}/nvim"
[ -e $nvim ] && [ ! -L $nvim ] && mv $nvim $nvim.$today

echo "Creating symlink"
ln -s $PWD $nvim

echo "Installing plugins"
curl -fLo ${nvim}/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

nvim -u init.vim +PlugInstall +qall
nvim -u init.vim +UpdateRemotePlugins +qall
