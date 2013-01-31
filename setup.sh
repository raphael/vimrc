#!/bin/bash

echo "Backing up existing vim config"
today=`date +%Y%m%d`
for i in $HOME/.vim $HOME/.vimrc $HOME/.vimrc.bundles; do [ -e $i ] && [ ! -L $i ] && mv $i $i.$today; done

echo "Creating symlinks"
lnif() {
  if [ ! -e $2 ] ; then
    ln -s $1 $2
  fi
  if [ -L $2 ] ; then
    ln -sf $1 $2
  fi
}
lnif $PWD/vimrc $HOME/.vimrc
lnif $PWD/vimrc.bundles $HOME/.vimrc.bundles

echo "Installing Vundle and bundles"
if [ ! -e $HOME/.vim/bundle/vundle ]; then
  mkdir -p $HOME/.vim/bundle
  git clone http://github.com/gmarik/vundle.git $HOME/.vim/bundle/vundle
else
  cd $HOME/.vim/bundle/vundle && git pull
fi
hell=$SHELL
export SHELL="/bin/sh"
vim -u $HOME/.vimrc.bundles +BundleInstall! +BundleClean +qall
export SHELL=$hell

echo "Note: Powerline requires additional setup: https://github.com/Lokaltog/powerline"
echo "Note: gocode requires additional setup: https://github.com/nsf/gocode"
