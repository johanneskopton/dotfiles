#!/usr/bin/env bash

cd "$(dirname "$0")" || exit 1

# Move existing configs out of the way so stow can create the symlinks.
for file in "$HOME/.bashrc" "$HOME/.bash_aliases" "$HOME/.config/fish/config.fish" "$HOME/.config/opencode/opencode.jsonc"; do
    if [ -e "$file" ]; then
        mv "$file" "${file}_old"
    fi
done

stow bash
stow fish
stow vim
stow mutt
stow nvim
stow opencode

source "$HOME/.bashrc"

if [ ! -d "$HOME/.vim/bundle/Vundle.vim" ]; then
    git clone https://github.com/VundleVim/Vundle.vim.git "$HOME/.vim/bundle/Vundle.vim"
fi
vim -c "PluginInstall"
