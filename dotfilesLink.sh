#!/bin/zsh
ln -sf ~/Dropbox/dotfiles/.vimrc ~/.vimrc
ln -sf ~/Dropbox/dotfiles/.zshrc ~/.zshrc
ln -sf ~/Dropbox/dotfiles/keymap ~/.w3m/keymap
ln -sf ~/Dropbox/dotfiles/bookmark.html ~/.w3m/bookmark.html
ln -sf ~/Dropbox/dotfiles/urls ~/.newsbeuter/urls
ln -sf ~/Dropbox/dotfiles/urimethodmap ~/.w3m/urimethodmap
ln -sf ~/Dropbox/dotfiles/newsbeutconf ~/.newsbeuter/config
ln -sf ~/Dropbox/dotfiles/.emacs ~
ln -sf ~/Dropbox/dotfiles/.xsessionrc ~
ln -sf ~/Dropbox/dotfiles/.Xdefaults ~
ln -sf ~/Dropbox/dotfiles/mailcap ~/.w3m/
ln -sf ~/Dropbox/dotfiles/.xmobarrc ~/.xmobarrc
ln -sf ~/Dropbox/dotfiles/.stalonetrayrc ~/.stalonetrayrc
mkdir -p ~/.xmonad/ 2>/dev/null
ln -sf ~/Dropbox/dotfiles/xmonad.hs ~/.xmonad/xmonad.hs
ln -sf ~/Dropbox/dotfiles/init.vim ~/.config/nvim/init.vim
source ~/.zshrc
