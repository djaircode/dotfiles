-- ~/.config/wezterm/lua/transparency.lua
-- Configuração de transparência com blur de fundo
-- - Janela em foco: 85% opacidade (15% transparente para blur)
-- - Janela sem foco: 75% opacidade (25% transparente - mais blur visível)

local wezterm = require 'wezterm'
local M = {}

-- Opacidades (1.0 = 100% opaco, 0.0 = 100% transparente)
-- Valores mais baixos = mais transparência = mais blur visível
M.ACTIVE_OPACITY = 0.85    -- 85% em foco (permite blur visível)
M.INACTIVE_OPACITY = 0.75  -- 75% sem foco (mais transparente para destacar blur)

-- Aplica a opacidade inicial e configura eventos de foco
function M.apply(config)
  -- Opacidade padrão do background da janela
  config.window_background_opacity = M.ACTIVE_OPACITY

  -- Evento: quando a janela ganha foco
  wezterm.on('window-focus-changed', function(window, pane)
    local overrides = window:get_config_overrides() or {}
    overrides.window_background_opacity = M.ACTIVE_OPACITY
    window:set_config_overrides(overrides)
  end)
end

return M
