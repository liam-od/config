-- WezTerm Configuration

local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.initial_cols = 120
config.initial_rows = 60

config.font_size = 12
config.font = wezterm.font("Hack Nerd Font")
-- config.font = wezterm.font('JetBrains Mono')
-- config.font = wezterm.font('Monaspace Neon Frozen')

config.color_scheme = "Catppuccin Macchiato"
config.window_background_opacity = 1.0
config.window_decorations = "RESIZE"
config.hide_tab_bar_if_only_one_tab = true
config.window_padding = {
	left = 1,
	right = 1,
	top = 1,
	bottom = 1,
}

config.audible_bell = "Disabled"

config.max_fps = 144
config.animation_fps = 144
config.front_end = "WebGpu"
config.use_ime = false

if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
  config.default_domain = 'WSL:Ubuntu'
end

return config
