function fish_prompt
    set -l exit_status $status

    set -l color_cwd (set_color df8e1d)
    set -l color_user (set_color 179299)
    set -l color_host (set_color 1e66f5)
    set -l color_normal (set_color normal)
    set -l color_branch (set_color 8839ef)
    set -l color_dirty (set_color fe640b)
    set -l color_ok (set_color 40a02b)
    set -l color_fail (set_color d20f39)

    if test -n "$VIRTUAL_ENV"
        echo -n "$color_ok("(basename "$VIRTUAL_ENV")")$color_normal "
    end

    # Show user@host only where the extra context matters: remote (SSH) and
    # root shells. This avoids hardcoding a "default" hostname. Override it
    # with a universal variable if needed:
    #   set -U fish_prompt_show_user_host 1   # always show
    #   set -U fish_prompt_show_user_host 0   # never show
    set -l show_user_host 0
    if set -q SSH_CONNECTION; or set -q SSH_CLIENT; or set -q SSH_TTY; or test "$USER" = root
        set show_user_host 1
    end
    if set -q fish_prompt_show_user_host
        if test "$fish_prompt_show_user_host" = 0
            set show_user_host 0
        else
            set show_user_host 1
        end
    end

    if test "$show_user_host" = 1
        echo -n "$color_user$USER$color_host@$color_host"(prompt_hostname)" "
    end

    echo -n $color_cwd(prompt_pwd)$color_normal

    set -l git_branch
    set -l git_dirty

    if command -q git
        set -l git_dir (git rev-parse --git-dir 2>/dev/null)
        if test -n "$git_dir"
            set git_branch (git rev-parse --abbrev-ref HEAD 2>/dev/null)
            if test "$git_branch" = "HEAD"
                set git_branch 'detached*'
            end
            set -l git_status (git status --porcelain 2>/dev/null)
            if test -n "$git_status"
                set git_dirty '*'
            end
        end
    end

    if test -n "$git_branch"
        echo -n " $color_branch($git_branch)$color_normal"
        if test -n "$git_dirty"
            echo -n "$color_dirty$git_dirty$color_normal"
        end
    end

    if test $exit_status -eq 0
        echo -n " $color_ok✓$color_normal"
    else
        echo -n " $color_fail X$color_normal"
    end

    echo -n ' '
end
