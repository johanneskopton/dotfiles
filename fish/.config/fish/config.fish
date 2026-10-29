if status is-interactive
    set -gx EDITOR /usr/bin/nvim
    set -gx WINEPREFIX $HOME/.wine32
    set -gx PODMAN_COMPOSE_PROVIDER podman-compose
    set -gx PODMAN_COMPOSE_WARNING_LOGS false
    set -gx PATH /usr/local/texlive/2025/bin/x86_64-linux $PATH
    set -gx PATH $HOME/.local/bin $PATH

    stty -ixon

    set -gx VIRTUAL_ENV_DISABLE_PROMPT true
    fish_config theme choose catppuccin-mocha --color-theme=light 2>/dev/null
    fish_vi_key_bindings

    alias cd..='cd ..'
    alias apti='sudo apt-get install'
    alias fucking='sudo'
    alias gc='git commit'
    alias ga='git add'
    alias glog='git log --graph --all --decorate --perl-regexp --author="^((?!dependabot).)*\$"'
    alias gst='git status'
    alias gdc='git diff --cached'
    alias vim='nvim'
    alias oldvim='vim'
    alias ll='ls -alF'
    alias la='ls -A'
    alias l='ls -CF'
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'

    if command -q direnv
        direnv hook fish | source
    end

    if command -q thefuck
        thefuck --alias | source
    end

    ssh-add $HOME/.ssh/github1 2>/dev/null
    ssh-add $HOME/.ssh/github_hortibonn_new 2>/dev/null

end
