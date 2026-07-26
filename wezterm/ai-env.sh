# =============================================================================
# AI Tools Environment - Adicione suas API keys aqui
# =============================================================================

# Google Gemini
export GEMINI_API_KEY="SUA_GEMINI_API_KEY_AQUI"

# OpenCode
export OPENCODE_API_KEY="SUA_OPENCODE_API_KEY_AQUI"

# Carregar aliases e funções de IA
if [ -f ~/.config/wezterm/ai-aliases.sh ]; then
    source ~/.config/wezterm/ai-aliases.sh
fi
