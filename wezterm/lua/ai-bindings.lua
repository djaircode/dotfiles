-- ~/.config/wezterm/lua/ai-bindings.lua
-- Keybindings para integração com IA (opencode + gemini)

local wezterm = require 'wezterm'
local M = {}

function M.apply(config, act)
  -- Inicializar config.keys se necessário
  config.keys = config.keys or {}

  -- ============================================
  -- KEYBINDINGS PARA IA
  -- ============================================

  -- Abrir gemini-cli em REPL no split horizontal (Ctrl+Shift+G)
  table.insert(config.keys, {
    key = 'g',
    mods = 'CTRL|SHIFT',
    action = act.SplitHorizontal {
      domain = 'CurrentPaneDomain',
      args = { 'env', 'TERM=xterm-256color', 'gemini' },
    },
  })

  -- Abrir gemini em split vertical (Ctrl+Shift+I)
  table.insert(config.keys, {
    key = 'i',
    mods = 'CTRL|SHIFT',
    action = act.SplitVertical {
      domain = 'CurrentPaneDomain',
      args = { 'env', 'TERM=xterm-256color', 'gemini' },
    },
  })

  -- Quick ask via gemini-cli (Ctrl+Shift+Q) - pergunta rápida
  table.insert(config.keys, {
    key = 'q',
    mods = 'CTRL|SHIFT',
    action = act.PromptInputLine {
      description = wezterm.format {
        { Foreground = { Color = '#bb9af7' } },
        { Text = ' Pergunte ao Gemini: ' },
      },
      action = wezterm.action_callback(function(window, pane, line)
        if line then
          pane:send_text('gemini -p "' .. line:gsub('"', '\\"') .. '"\n')
        end
      end),
    },
  })

  -- Quick ask via opencode (Ctrl+Shift+Alt+O) - pergunta rápida com opencode
  table.insert(config.keys, {
    key = 'o',
    mods = 'CTRL|SHIFT|ALT',
    action = act.PromptInputLine {
      description = wezterm.format {
        { Foreground = { Color = '#7aa2f7' } },
        { Text = ' Pergunte ao OpenCode: ' },
      },
      action = wezterm.action_callback(function(window, pane, line)
        if line then
          pane:send_text('opencode run "' .. line:gsub('"', '\\"') .. '"\n')
        end
      end),
    },
  })
end

return M
