-- ~/.config/wezterm/lua/theme.lua
-- Tema Tokyo Night com transparência para blur

local M = {}

function M.apply(config)
  config.color_scheme = 'Tokyo Night'

  -- Cores customizadas (Tokyo Night Storm)
  -- Background semi-transparente para permitir blur do compositor
  config.colors = {
    foreground = '#c0caf5',
    -- Transparência controlada via window_background_opacity no wezterm.lua
    background = '#1f2335',  -- Cor sólida (opacidade via window_background_opacity)
    cursor_bg = '#c0caf5',
    cursor_fg = '#1f2335',
    cursor_border = '#c0caf5',

    ansi = {
      '#15161e', -- black
      '#f7768e', -- red
      '#9ece6a', -- green
      '#e0af68', -- yellow
      '#7aa2f7', -- blue
      '#bb9af7', -- magenta
      '#7dcfff', -- cyan
      '#a9b1d6', -- white
    },

    brights = {
      '#414868', -- bright black
      '#f7768e', -- bright red
      '#9ece6a', -- bright green
      '#e0af68', -- bright yellow
      '#7aa2f7', -- bright blue
      '#bb9af7', -- bright magenta
      '#7dcfff', -- bright cyan
      '#c0caf5', -- bright white
    },

    tab_bar = {
      background = '#1f2335',
      active_tab = {
        bg_color = '#7aa2f7',
        fg_color = '#1f2335',
      },
      inactive_tab = {
        bg_color = '#24283b',
        fg_color = '#565f89',
      },
    },

    split = '#1f2335',
  }
end

return M
