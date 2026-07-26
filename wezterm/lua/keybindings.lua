-- ~/.config/wezterm/lua/keybindings.lua
-- Lista completa de atalhos do WezTerm + função de exibição

local wezterm = require 'wezterm'
local M = {}

M.bindings = {
  -- SPLITS
  { category = "SPLITS", key = "Ctrl+Shift+D", desc = "Split vertical (lado a lado)" },
  { category = "SPLITS", key = "Ctrl+Shift+E", desc = "Split horizontal (acima/abaixo)" },
  { category = "SPLITS", key = "Ctrl+Shift+W", desc = "Fechar pane atual" },

  -- NAVEGAÇÃO
  { category = "NAVEGAÇÃO", key = "Alt+←", desc = "Pane à esquerda" },
  { category = "NAVEGAÇÃO", key = "Alt+→", desc = "Pane à direita" },
  { category = "NAVEGAÇÃO", key = "Alt+↑", desc = "Pane acima" },
  { category = "NAVEGAÇÃO", key = "Alt+↓", desc = "Pane abaixo" },

  -- REDIMENSIONAR
  { category = "REDIMENSIONAR", key = "Alt+Shift+←", desc = "Diminuir largura" },
  { category = "REDIMENSIONAR", key = "Alt+Shift+→", desc = "Aumentar largura" },
  { category = "REDIMENSIONAR", key = "Alt+Shift+↑", desc = "Diminuir altura" },
  { category = "REDIMENSIONAR", key = "Alt+Shift+↓", desc = "Aumentar altura" },

  -- TABS
  { category = "TABS", key = "Ctrl+Shift+T", desc = "Nova tab" },
  { category = "TABS", key = "Ctrl+Tab", desc = "Próxima tab" },
  { category = "TABS", key = "Ctrl+Shift+Tab", desc = "Tab anterior" },
  { category = "TABS", key = "Ctrl+1 a 9", desc = "Ir para tab N" },

  -- JANELA
  { category = "JANELA", key = "Alt+Enter", desc = "Maximizar/restaurar (fullscreen)" },
  { category = "JANELA", key = "Ctrl+Shift+Alt+T", desc = "Toggle painel IA (gemini)" },

  -- ZOOM
  { category = "ZOOM", key = "Ctrl+Shift+Z", desc = "Zoom no pane atual" },
  { category = "ZOOM", key = "Ctrl+Shift+R", desc = "Limpar scrollback" },

  -- FONTE
  { category = "FONTE", key = "Ctrl++", desc = "Aumentar fonte" },
  { category = "FONTE", key = "Ctrl+=", desc = "Aumentar fonte (alias)" },
  { category = "FONTE", key = "Ctrl+-", desc = "Diminuir fonte" },
  { category = "FONTE", key = "Ctrl+0", desc = "Resetar tamanho da fonte" },

  -- IA-GEMINI
  { category = "IA-GEMINI", key = "Ctrl+Shift+G", desc = "Abrir gemini-cli em split H" },
  { category = "IA-GEMINI", key = "Ctrl+Shift+I", desc = "Abrir gemini em split V" },
  { category = "IA-GEMINI", key = "Ctrl+Shift+Q", desc = "Quick ask → gemini (popup)" },
  { category = "IA-GEMINI", key = "Ctrl+Shift+L", desc = "Explicar último comando" },

  -- IA-OPENCODE
  { category = "IA-OPENCODE", key = "Ctrl+Shift+Alt+O", desc = "Quick ask → opencode" },

  -- CÓPIA
  { category = "CÓPIA", key = "Ctrl+Shift+C", desc = "Copiar seleção" },
  { category = "CÓPIA", key = "Ctrl+Shift+V", desc = "Colar" },
  { category = "CÓPIA", key = "Ctrl+Insert", desc = "Copiar (alternativo)" },
  { category = "CÓPIA", key = "Shift+Insert", desc = "Colar (alternativo)" },

  -- SCROLL
  { category = "SCROLL", key = "Shift+PageUp", desc = "Scroll 1 página acima" },
  { category = "SCROLL", key = "Shift+PageDown", desc = "Scroll 1 página abaixo" },
  { category = "SCROLL", key = "Ctrl+Shift+Space", desc = "Modo scrollback / cópia" },

  -- BUSCA
  { category = "BUSCA", key = "Ctrl+Shift+F", desc = "Buscar texto no scrollback" },

  -- AJUDA
  { category = "AJUDA", key = "Ctrl+Shift+K", desc = "Mostrar esta lista de atalhos" },
  { category = "AJUDA", key = "Ctrl+Shift+?", desc = "Command Palette" },
  { category = "AJUDA", key = "wkeys (terminal)", desc = "Mostrar lista de atalhos (CLI)" },
}

-- Função para gerar texto formatado da lista
function M.get_formatted_text()
  local lines = {}
  local categories = {}

  for _, b in ipairs(M.bindings) do
    if not categories[b.category] then
      categories[b.category] = {}
    end
    table.insert(categories[b.category], b)
  end

  local sorted_cats = {}
  for cat, _ in pairs(categories) do
    table.insert(sorted_cats, cat)
  end
  table.sort(sorted_cats)

  table.insert(lines, "╔══════════════════════════════════════════════════════════════╗")
  table.insert(lines, "║         WEZTERM - ATALHOS DE TECLADO                          ║")
  table.insert(lines, "╚══════════════════════════════════════════════════════════════╝")
  table.insert(lines, "")

  for _, cat in ipairs(sorted_cats) do
    table.insert(lines, "─── " .. cat .. " " .. string.rep("─", 60 - #cat))
    for _, b in ipairs(categories[cat]) do
      local line = string.format("  %-30s %s", b.key, b.desc)
      table.insert(lines, line)
    end
    table.insert(lines, "")
  end

  table.insert(lines, "──────────────────────────────────────────────────────────────")
  table.insert(lines, "💡 Pressione Ctrl+Shift+? para a Command Palette")
  table.insert(lines, "💡 Digite 'wkeys' no terminal para esta lista")
  table.insert(lines, "")

  return table.concat(lines, "\n")
end

-- Função para mostrar a lista em uma nova tab
function M.show_in_tab(window, pane)
  local text = M.get_formatted_text()
  -- Abrir nova tab com less para visualizar
  window:perform_action(
    wezterm.action.SpawnCommandInNewTab {
      args = { 'sh', '-c', 'echo "' .. text:gsub('"', '\\"') .. '" | less -R' },
    },
    pane
  )
end

return M
