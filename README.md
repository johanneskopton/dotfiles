# Dotfiles
My dotfiles for Linux (tested on Debian and Fedora).

## Installing

* Clone the repo in your home directory `~/`.
* Run `install.sh`
    * Alternatively use [gnu stow](https://www.gnu.org/software/stow) manually to create symlinks to the target destination.
        * `stow vim` e.g. puts .vimrc directly in the right place (`../`)
        * use `stow example -t /example/path` to install something somewhere else
