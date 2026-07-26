# =============================================================================
# WezTerm + IA Integration - Aliases e Funções
# =============================================================================

# Aliases para gemini-cli
alias gem='gemini'
alias gq='gemini -p'           # Quick ask (one-shot)
alias gc='gemini -p'           # Coding quick ask

# Aliases para opencode (CLI nativo)
alias oc='opencode'
alias ocr='opencode run'       # Run não-interativo
alias ocq='opencode run'       # Quick ask

# Função para perguntar ao gemini sobre o último comando
function gexplain() {
    local last_cmd=$(fc -ln -1)
    gemini -p "Explique este comando shell: $last_cmd"
}

# Função para enviar arquivo para gemini analisar
function greview() {
    if [ -z "$1" ]; then
        echo "Uso: greview <arquivo>"
        return 1
    fi
    gemini -p "Analise este código: @$1"
}

# Função para perguntar ao opencode
function oexplain() {
    local last_cmd=$(fc -ln -1)
    opencode run "Explique este comando: $last_cmd"
}

# Função para gerar commit message com IA
function aicommit() {
    local diff=$(git diff --cached)
    if [ -z "$diff" ]; then
        echo "Nenhum staged changes encontrado"
        return 1
    fi
    local msg=$(gemini -p "Gere uma mensagem de commit concisa em português para: $diff")
    echo "Mensagem sugerida: $msg"
    git commit -m "$msg"
}

# (Mensagem de boas-vindas movida para ~/.zshrc antes do p10k instant prompt)

# Alias para mostrar atalhos do WezTerm
alias wkeys='/home/djota/.local/bin/wkeys'
