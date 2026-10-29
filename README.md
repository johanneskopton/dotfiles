# Dotfiles
My dotfiles for a Fedora-based Linux setup with fish as the primary shell.
The bash configuration is kept and installed alongside it.

## Contents

* `fish/`: fish configuration (`~/.config/fish/config.fish`)
* `bash/`: bash configuration (`.bashrc`, `.bash_aliases`)
* `vim/`: Vim configuration (`.vimrc`)
* `nvim/`: Neovim configuration (`~/.config/nvim/init.vim`)
* `mutt/`: mutt configuration (`.muttrc`, `.mailcap`, `.mutt`)

## Installing

### Packages

On Fedora, install the required packages with:

```sh
./install_packages.sh
```

Or manually:

```sh
sudo dnf install git stow neovim vim-enhanced fish thefuck direnv
```

### Dotfiles

* Clone the repo in your home directory `~/`.
* Run `./install.sh`
    * Existing `.bashrc`, `.bash_aliases` and `~/.config/fish/config.fish` are moved to `*_old` first.
    * Alternatively use [GNU Stow](https://www.gnu.org/software/stow) manually to create symlinks to the target destination.
        * `stow vim` e.g. puts .vimrc directly in the right place (`../`)
        * `stow fish` puts `config.fish` at `~/.config/fish/config.fish`
        * use `stow example -t /example/path` to install something somewhere else
* Optionally make fish your login shell:

    ```sh
    chsh -s /usr/bin/fish
    ```

## Bash

The bash setup is kept for bash sessions and Debian-based systems. `install.sh`
installs it by default; if you only want fish, skip changing your login shell
and bash will remain available as before.
