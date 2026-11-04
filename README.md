# Dotfiles
My dotfiles for a Fedora-based Linux setup with fish as the primary shell.
The bash configuration is kept and installed alongside it.

## Contents

* `fish/`: fish configuration (`config.fish`, the prompt and vi-mode override, and the fisher `fish_plugins` list)
* `bash/`: bash configuration (`.bashrc`, `.bash_aliases`)
* `vim/`: Vim configuration (`.vimrc`)
* `nvim/`: Neovim configuration (`~/.config/nvim/init.vim`)
* `opencode/`: OpenCode configuration (`~/.config/opencode/opencode.jsonc`)
* `zed/`: Zed configuration (`~/.config/zed/keymap.json`, `~/.config/zed/settings.json`)
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
    * Existing configuration files that would conflict with the stow packages are moved to `*_old` first.
    * Alternatively use [GNU Stow](https://www.gnu.org/software/stow) manually. Every package mirrors the home directory, so no target directory is needed:
        * `stow bash` puts `.bashrc` and `.bash_aliases` in `~/`
        * `stow fish` puts `config.fish`, `fish_plugins`, `fish_prompt.fish` and `fish_mode_prompt.fish` under `~/.config/fish/`
        * `stow vim` puts `.vimrc` in `~/`
        * `stow mutt` puts `.muttrc`, `.mailcap` and `.mutt/` in `~/`
        * `stow nvim` puts `init.vim` at `~/.config/nvim/init.vim`
        * `stow opencode` puts `opencode.jsonc` at `~/.config/opencode/opencode.jsonc`
        * `stow zed` puts `keymap.json` and `settings.json` at `~/.config/zed/`
* Optionally make fish your login shell:

    ```sh
    chsh -s /usr/bin/fish
    ```

## Fish

The custom prompt shows the current directory, the git branch and dirty state,
and the last command's exit status. `user@host` is only shown for SSH and root
shells, so no hostname is hardcoded; override this with
`set -U fish_prompt_show_user_host 1` (always show) or `0` (never show).

The [fisher](https://github.com/jorgebucaran/fisher) plugins are listed in
`fish_plugins`. After installing fisher, run `fisher update` to install them.

## Bash

The bash setup is kept for bash sessions and Debian-based systems. `install.sh`
installs it by default; if you only want fish, skip changing your login shell
and bash will remain available as before.

## OpenCode

`opencode/` provides the global OpenCode configuration. The Semantic Scholar MCP
server reads its API key from the `SEMANTIC_SCHOLAR_API_KEY` environment
variable, so no secret is stored in this repository.

[direnv](https://direnv.net/) loads the key from
`~/Documents/hortibonn-zettel/.env` while you work anywhere inside that vault
(see the `.envrc` there). To set it up on a new machine:

```sh
printf 'SEMANTIC_SCHOLAR_API_KEY=%s\n' 'your-key' > ~/Documents/hortibonn-zettel/.env
chmod 600 ~/Documents/hortibonn-zettel/.env
direnv allow ~/Documents/hortibonn-zettel
```

Start OpenCode from inside the vault so it inherits the variable. If the
background service is already running, restart it from there.
