local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.initial_cols = 120
config.initial_rows = 60

config.font_size = 12
config.font = wezterm.font("Hack Nerd Font")

config.color_scheme = "Catppuccin Macchiato"
config.window_background_opacity = 1.0
config.window_decorations = "RESIZE"
config.enable_tab_bar = false

config.audible_bell = "Disabled"
config.max_fps = 240
config.enable_wayland = false

return config
