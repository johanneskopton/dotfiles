git clone https://github.com/johanneskopton/dotfiles.git
mv .bashrc .bashrc_old
cd dotfiles
stow bash
stow vim
mkdir ~/.config/nvim
stow nvim -t ~/.config/nvim
cd ..
source .bashrc
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim -c "PluginInstall"
