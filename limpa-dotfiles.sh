#!/bin/bash
# ============================================
# LIMPA-DOTFILES — remove segredos, corrige
# Kvantum, amend + push, com verificação final
# Execute: bash limpa-dotfiles.sh
# ============================================

REPO="$HOME/dotfiles"
ORIG="$HOME/.config/fish/config.fish"
OK=1

echo "============================================"
echo " PASSO 1 — Caçando segredos no repo"
echo "============================================"
# Procura padrões comuns de chaves/tokens no repo
PADROES='AIza|sk-[A-Za-z0-9]|ghp_|gho_|glpat-|api[_-]?key|API[_-]?KEY|secret|SECRET|token|TOKEN|password|senha'

echo "--- Ocorrências encontradas (arquivo:linha):"
grep -rEn "$PADROES" "$REPO" --exclude-dir=.git | grep -v '.gitignore'
echo "---"

# Remove LINHAS INTEIRAS que contenham chave GCP (AIza...) de todos os arquivos do repo
echo ">>> Removendo linhas com chaves AIza... dos arquivos do repo"
grep -rlE "AIza[A-Za-z0-9_-]{20,}" "$REPO" --exclude-dir=.git | while read -r f; do
    echo "    limpando: $f"
    sed -i '/AIza[A-Za-z0-9_-]\{20,\}/d' "$f"
done

# Remove o .bak do repo (suspeito clássico de guardar segredo)
if [ -f "$REPO/fish/config.fish.bak" ]; then
    echo ">>> Removendo fish/config.fish.bak do repo"
    rm -f "$REPO/fish/config.fish.bak"
    grep -q 'config.fish.bak' "$REPO/.gitignore" || echo 'config.fish.bak' >> "$REPO/.gitignore"
fi

echo ""
echo "============================================"
echo " PASSO 2 — Verificação de segredos (PROVA)"
echo "============================================"
if grep -rEn "AIza[A-Za-z0-9_-]{20,}" "$REPO" --exclude-dir=.git > /dev/null; then
    echo "❌ AINDA TEM CHAVE GCP no repo — abortando antes do push!"
    grep -rEn "AIza[A-Za-z0-9_-]{20,}" "$REPO" --exclude-dir=.git
    OK=0
else
    echo "✅ Repo limpo de chaves GCP"
fi

echo ""
echo "============================================"
echo " PASSO 3 — Corrigindo QT_STYLE_OVERRIDE=Kvantum"
echo "============================================"
for f in "$ORIG" "$REPO/fish/config.fish"; do
    if grep -q 'QT_STYLE_OVERRIDE kvantum' "$f" 2>/dev/null; then
        sed -i 's/QT_STYLE_OVERRIDE kvantum/QT_STYLE_OVERRIDE Kvantum/' "$f"
        echo "    corrigido em: $f"
    else
        echo "    já ok (ou sem a variável): $f"
    fi
done

if [ "$OK" -eq 0 ]; then
    echo ""
    echo "🚨 ABORTADO — corrija os segredos acima e rode de novo."
    exit 1
fi

echo ""
echo "============================================"
echo " PASSO 4 — Amend + Push"
echo "============================================"
cd "$REPO" || exit 1
git add -A
git commit --amend --no-edit
git push -u origin main --force
PUSH_STATUS=$?

echo ""
echo "============================================"
echo " PASSO 5 — VERIFICAÇÃO FINAL"
echo "============================================"
if [ $PUSH_STATUS -eq 0 ]; then
    echo "✅ PUSH OK — dotfiles no GitHub!"
else
    echo "❌ Push falhou — veja o erro acima"
fi

echo ""
echo "--- Status do repo:"
git log --oneline -3
echo ""
echo "--- Kvantum nos arquivos:"
grep -H "QT_STYLE_OVERRIDE" "$ORIG" "$REPO/fish/config.fish" 2>/dev/null
echo ""
echo "--- Segredos restantes no repo (não pode aparecer nada):"
grep -rEn "AIza[A-Za-z0-9_-]{20,}" "$REPO" --exclude-dir=.git || echo "✅ NENHUM SEGREDO"
echo ""
echo "🏁 FIM"
