#!/bin/bash
set -x # echo on


echo "Installing dotfiles"

cd ~

echo "Install all required programs"

echo "Installing tmux"
sudo apt-get update -yqqu
sudo apt-get install -yqqu python-software-properties software-properties-common
sudo add-apt-repository -yu ppa:pi-rho/dev
sudo apt-get update -yqqu
sudo apt-get install -yqqu tmux

echo "Install other programs: "
sudo apt-get install vim-gnome git zsh wget xclip build-essential cmake python-dev python3-dev

git clone https://github.com/robbyrussell/oh-my-zsh.git .oh-my-zsh
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
git clone https://github.com/clvv/fasd.git
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/vundle
cd ~/fasd
make install
cd ~


# Install powerline font
mkdir -p ~/.fonts/
wget https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf -P ~/.fonts
fc-cache -vf ~/.fonts
mkdir -p ~/.config/fontconfig/conf.d/
wget https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf -P ~/.config/fontconfig/conf.d/


# Install vim plugins - now manually
# Install hub: https://github.com/github/hub/releases

echo "Initializing submodule(s)"
git submodule update --init --recursive

source install/link.sh

echo "Configuring zsh as default shell"
chsh -s $(which zsh)

echo "Done."
