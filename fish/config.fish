source /usr/share/cachyos-fish-config/cachyos-config.fish

# overwrite greeting
# potentially disabling fastfetch
#function fish_greeting
#    # smth smth
#end

set -gx PATH "/home/djota/.pixi/bin" $PATH

/home/djota/.local/bin/mise activate fish | source # added by https://mise.run/fish


# Added by Antigravity CLI installer
set -gx PATH "/home/djota/.local/bin" $PATH

# ─── AI Tools Integration (WezTerm) ───


# ─── Terminal padrão: WezTerm ───
set -gx TERM "xterm-256color"
set -gx COLORTERM "truecolor"
set -gx TERMINAL "wezterm"
set -gx TERM_PROGRAM "WezTerm"
set -gx XDG_TERMINAL "wezterm"

# Aliases para IA
alias ai "aichat"
alias ask "aichat -e"
alias code "aichat --role coder"
alias shell "aichat --role shell"
alias explain "aichat --role explainer"

# Force Qt applications to use Kvantum (for transparency and blur)
set -gx QT_STYLE_OVERRIDE Kvantum

alias roku "/home/djota/.gemini/antigravity/scratch/roku-remote-web/start-app.sh"
alias oc "opencode"


# kimi-code
fish_add_path -g "/home/djota/.kimi-code/bin"
