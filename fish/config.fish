function start-up
    starship init fish | source
    enable_transience
    fastfetch
end

function starship_transient_prompt_func
    starship module character
end
function fish_title
end
set -gx LANG en_US.UTF-8
set -gx LC_CTYPE en_US.UTF-8
set -gx LC_ALL en_US.UTF-8

set -gx TERM tmux-256color

set -U fish_ambiguous_width single
set -U fish_emoji_width 1

fish_vi_key_bindings

bind -M insert \co accept-autosuggestion

set -gx EDITOR nvim

# Example: bind 'yy' in vi-mode to system clipboard copy
bind -M default yy fish_clipboard_copy
# Example: bind 'p' in vi-mode to system clipboard paste

bind -M default p fish_clipboard_paste

alias reloadfish="source ~/.config/fish/config.fish"
alias reloadtmux="tmux source-file ~/.tmux.conf"
alias tree="eza --tree"
alias dev-nix-rebuild-dev-wsl="sudo nixos-rebuild switch --flake path:nix-flakes\"\#dev-wsl\" --override-input aundre-dotfiles path:dotfiles"

function yazi-nvim
    nvim (yazi --chooser-file=/dev/stdout)
end
function fzf-nvim
    set -l files (fzf --multi)
    if test -n "$files"
        nvim -p $files
    end
end
# tmux config
alias tmux-pane-size="tmux display -p '#{pane_width}x#{pane_height}'"
alias end-dev="tmux kill-session -t dev-environment"

function start-dev -d "tmux session starting"
    set session_name dev-environment

    tmux has-session -t $session_name 2>/dev/null

    if test $status != 0
        # setup bottom row
        tmux -u new-session -d -s $session_name -x "$COLUMNS" -y "$LINES"
        tmux -u send-keys -t $session_name clear Enter

        # split pane
        tmux -u split-window -v -l 16 -t $session_name
        tmux -u send-keys -t $session_name clear Enter

        tmux -u select-pane -t $session_name:1.2
        tmux -u split-window -h -l 160 -t $session_name
        tmux -u send-keys -t $session_name clear Enter

        #setup top row
        tmux -u select-pane -t $session_name:1.1
        tmux -u split-window -h -l 75 -t $session_name

        #select first pane and open neovim
        tmux -u select-pane -t $session_name:1.1
        tmux -u send-keys -t $session_name nvim Enter
    end

    tmux attach-session -t $session_name
end

start-up
