starship init fish | source
alias code="code --enable-features=UseOzonePlatform,WaylandWindowDecorations --ozone-platform-hint=auto"
fzf --fish | source
zoxide init --cmd cd fish | source

alias v="nvim"
alias p="paru"
alias y="yazi"

set -Ux ANDROID_HOME $HOME/Android/Sdk
set -Ua PATH $ANDROID_HOME/emulator
set -Ua PATH $ANDROID_HOME/tools
set -Ua PATH $ANDROID_HOME/tools/bin
set -Ua PATH $ANDROID_HOME/platform-tools
set -Ux EDITOR nvim
set -g fish_greeting
set -gx PATH ~/flutter/bin $PATH
set -Ux STARSHIP_CONFIG ~/.config/starship/starship.toml

function tkdir
    mkdir -pv $argv
    cd $argv
end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
