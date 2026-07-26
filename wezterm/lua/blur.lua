-- ~/.config/wezterm/lua/blur.lua
-- Configuração de blur de fundo estilo macOS
-- O blur é aplicado pelo compositor (KDE/KWin no Wayland)

local wezterm = require 'wezterm'
local M = {}

-- Intensidade do blur (quanto maior, mais desfocado o fundo)
M.BLUR_RADIUS = 30  -- 0-100, padrão macOS é ~20-40

-- Raio de vibrancy/saturação (para efeito glassmorphism)
M.VIBRANCY = 0.0  -- 0.0 = sem saturação, 1.0 = saturação total

function M.apply(config)
  -- ============================================
  -- BLUR DE FUNDO
  -- ============================================

  -- macOS: blur nativo via Cocoa
  if wezterm.target_os == 'macos' then
    config.macos_window_background_blur = M.BLUR_RADIUS
  end

  -- Linux/Windows: usa transparência para permitir blur do compositor
  -- O KDE/KWayland aplica blur automaticamente em janelas com transparência
  config.window_background_opacity = 0.85  -- Mais transparente para blur visível

  -- ============================================
  -- GLASSMORPHISM (efeito vidro)
  -- ============================================
  -- Para um efeito mais estilo macOS Sonoma, podemos usar cores
  -- semi-transparentes no background

  -- O background é definido no theme.lua, mas podemos ajustar aqui
  -- para um efeito mais translúcido
end

return M
