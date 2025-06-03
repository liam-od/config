-- WezTerm Configuration

local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.initial_cols = 240
config.initial_rows = 120

config.font_size = 12
font = wezterm.font('JetBrains Mono')

config.color_scheme = 'Catppuccin Mocha'
config.window_background_opacity = 1.0
config.window_decorations = 'RESIZE'
config.hide_tab_bar_if_only_one_tab = true
config.window_padding = {
  left = 1,
  right = 1,
  top = 1,
  bottom = 1,
}

config.audible_bell = "Disabled"
config.max_fps = 144
config.front_end = "OpenGL"

return config
