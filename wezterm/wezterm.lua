local wezterm = require 'wezterm'
local act = wezterm.action
local config = wezterm.config_builder()

-- ✅ Selecionar tudo + copiar: Ctrl+Shift+A (não conflita com nada)
config.keys = {
  {
    key = 'a',
    mods = 'CTRL|SHIFT',
    action = act.Multiple {
      act.CopyTo 'ClipboardAndPrimarySelection',
      act.ClearSelection,
    },
  },
  -- ✅ Colar com Ctrl+V estilo Windows (cuidado: conflita com programas TUI)
  {
    key = 'v',
    mods = 'CTRL|SHIFT',
    action = act.PasteFrom 'Clipboard',
  },
}

-- 🖱️ Mouse estilo Windows Terminal
config.mouse_bindings = {
  -- Direito = colar
  {
    event = { Down = { streak = 1, button = 'Right' } },
    mods = 'NONE',
    action = act.PasteFrom 'Clipboard',
  },
  -- Selecionou = copiou automático
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'NONE',
    action = act.CompleteSelection 'ClipboardAndPrimarySelection',
  },
}

return config
