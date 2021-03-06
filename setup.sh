#!/bin/bash
#----------------------------------------------------------------------------#
# function                                                                   #
#----------------------------------------------------------------------------#
function echo_error() { echo -e "\e[2;31m$*\e[m"; }
function echo_success() { echo -e "\e[2;32m$*\e[m"; }
function echo_blue() { echo -e "\e[2;34m$*\e[m"; }

#----------------------------------------------------------------------------#
# dotfiles                                                                   #
#----------------------------------------------------------------------------#
# git
echo_blue link: git
ln -s ~/dotfiles/git/gitconfig ~/.gitconfig
ln -s ~/dotfiles/git/gitignore ~/.gitignore
cp    ~/dotfiles/git/gitconfig.local ~/.gitconfig.local

# tmux
echo_blue link: tmux
ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
git clone git://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# zsh
echo_blue link: zsh
mkdir -p ~/.config/zsh
ln -s $(pwd)/zsh/* ~/.config/zsh/
ln -s ~/.config/zsh/zshrc.zsh ~/.zshrc
git clone git://github.com/zsh-users/zaw.git ~/.config/zsh/zaw
curl -fLo ~/.config/zsh/func/_docker https://raw.github.com/felixr/docker-zsh-completion/master/_docker

# emacs
echo_blue link: emacs
EMCONF="$HOME/.emacs.d"
mkdir -p $EMCONF/straight
for i in $(command ls emacs.d |grep -v versions); do echo $i; ln -s $(pwd)/emacs.d/$i $EMCONF/; done
ln -s $(pwd)/emacs.d/versions $EMCONF/straight

# peco
echo_blue link: peco
ln -s $(pwd)/peco ~/.peco

# other
ln -s $(pwd)/clang-format ~/.clang-format
ln -s $(pwd)/rtorrent.rc ~/.rtorrent.rc
mkdir ~/.config/python
ln -s $(pwd)/pythonstartup ~/.config/python/pythonstartup
ln -s $(pwd)/screenrc ~/.screenrc
ln -s $(pwd)/editorconfig ~/.editorconfig

if [ "$(uname)" == 'Darwin' ]; then
    KD=$HOME/.config/karabiner
    mkdir -p $KD
    ln -s ~/dotfiles/karabiner.json $KD
    ln -s ~/dotfiles/com.googlecode.iterm2.plist ~/Library/Preferences/com.googlecode.iterm2.plist
else
    TC=~/.config/terminator
    mkdir -p $TC
    ln -s ~/dotfiles/terminator/config $TC/
fi
echo_success success
