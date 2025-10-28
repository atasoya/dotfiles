set -g fish_greeting

if status is-interactive
    # Commands to run in interactive sessions can go here
end

starship init fish | source
fastfetch
set -gx PATH /Users/atasoyata/.local/share/nvm/v22.21.0/bin /Users/atasoyata/go/bin $PATH
set -gx NODE_ENV development

