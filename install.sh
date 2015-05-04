#! /bin/bash

if [ -f ~/.vimrc ] || [ -f ~/.profile ] || [ -f ~/.zprofile ]; then
	echo "One or more dotfiles in $HOME would be overwritten during installation." >&2
	echo "Delete the files manually if you wish to replace them." &>2
	echo "I am not going to proceed with the installation." &>2
fi

cd ~
ln -s ~/projects/dotfiles/.vimrc .vimrc
ln -s ~/projects/dotfiles/.profile .profile
ln -s ~/projects/dotfiles/.zprofile .zprofile
