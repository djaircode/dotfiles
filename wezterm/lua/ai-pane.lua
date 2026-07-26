-- ~/.config/wezterm/lua/ai-pane.lua
-- Lógica de painéis de IA e eventos customizados

local wezterm = require 'wezterm'
local M = {}

-- Evento customizado para abrir painel de IA
function M.register_events()
  -- Evento para enviar output do shell para gemini
  wezterm.on('ai-explain-last-command', function(window, pane)
    pane:send_text 'gemini -p "Explique o último comando executado e seu output"\n'
  end)

  -- Evento para toggle de painel de gemini
  wezterm.on('ai-toggle-pane', function(window, pane)
    -- Verificar se já existe um pane com gemini
    for _, p in ipairs(window:panes()) do
      local title = p:get_title()
      if title and title:match('gemini') then
        window:perform_action(wezterm.action.ActivatePane(p:pane_id()), pane)
        return
      end
    end

    -- Se não existir, criar um novo
    window:perform_action(
      wezterm.action.SplitHorizontal {
        domain = 'CurrentPaneDomain',
        args = { 'env', 'TERM=xterm-256color', 'gemini' },
      },
      pane
    )
  end)
end

-- Função helper para criar atalhos de IA
function M.setup_ai_keys(config, act)
  config.keys = config.keys or {}

  -- Explicar último comando com gemini (Ctrl+Shift+L)
  table.insert(config.keys, {
    key = 'l',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.EmitEvent 'ai-explain-last-command',
  })

  -- Toggle painel gemini (Ctrl+Shift+Alt+T)
  table.insert(config.keys, {
    key = 't',
    mods = 'CTRL|SHIFT|ALT',
    action = wezterm.action.EmitEvent 'ai-toggle-pane',
  })
end

return M
