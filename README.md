# Dotfiles
My dotfiles for Debian.

## Installing

* Clone the repo in your home directory `~/`.
* Use [gnu stow](https://www.gnu.org/software/stow) to create symlinks to the target destination.
  * `stow vim` e.g. puts .vimrc directly in the right place (`../`)
  * use `stow example -t /example/path` to install something somewhere else
