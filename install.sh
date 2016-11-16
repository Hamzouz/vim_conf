#!/bin/bash

pwd=$(pwd)

function go_install {
if [ ! -z $(which go) ]; then
	if [ -z $GOPATH ]; then
		mkdir -p $HOME/dev/go/{bin,src,pkg}
		export GOPATH=$HOME/go
	fi
	# goimports
	echo "Installing goimports"
	go get -u golang.org/x/tools/cmd/goimports

	# gocode
	echo "Installing gocode"
	go get -u github.com/nsf/gocode

	# godef
	echo "Installing godef"
	go get -u github.com/rogpeppe/godef

	# golint
	echo "Installing golint"
	go get -u github.com/golang/lint/golint

	# errcheck
	echo "Installing errcheck"
	go get -u github.com/kisielk/errcheck

	# oracle
	echo "Installing oracle"
	go get -u golang.org/x/tools/cmd/oracle
fi
}

function install_dotfile {
if [[ -e $HOME/$1 ]]; then
	echo "Backup $HOME/$1 to $HOME/$1.old"
	mv $HOME/$1 $HOME/$1.old
fi

printf "\033[32m> Installing \033[34m%s \033[32m\033[0m in $HOME...\n" "$1"

cd $HOME
ln -s $pwd/$1
cd $pwd
}

function install_config_directory {
if [[ -e $HOME/.config/$1 ]]; then
	echo "Backup $HOME/.config/$1 to $HOME/.config/$1.old"
	mv $HOME/.config/$1 $HOME/.config/$1.old
fi

printf "\033[32m> Installing \033[34m%s \033[32m\033[0m in $HOME/.config...\n" "$1"

mkdir -p $HOME/.config
cd $HOME/.config
ln -s $pwd/.config/$1
cd $pwd
}

dotfiles=" .vim .vimrc .zshrc .xinitrc .Xresources "
config_directories=" nvim i3 "

for arg in $@ ; do
	if [[ $arg == "all" ]]; then
		for dotfile in $dotfiles ; do
			install_dotfile $dotfile
		done
		for dir in $config_directories ; do
			install_config_directory $dir
		done
	elif [[ $arg == "vim" ]]; then
		install_dotfile .vim
		install_dotfile .vimrc
	elif [[ $dotfiles =~ " $arg " ]]; then
		install_dotfile $arg
	elif [[ $config_directories =~ " $arg " ]]; then
		install_config_directory $arg
	else
		echo "Invalid argument: $arg"
	fi
done
