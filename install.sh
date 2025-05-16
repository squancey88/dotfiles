#!/bin/bash

mkdir -p ~/.config/nvim

cd vim && brew bundle && cd -

ln -sf "$(pwd)/vim/vimrc" ~/.vimrc
ln -sf "$(pwd)/vim/init.vim" ~/.config/nvim/init.vim
