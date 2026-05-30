local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.font = wezterm.font("UbuntuMono Nerd Font Mono")

config.font_size = 13
config.initial_cols = 240
config.initial_rows = 80
config.enable_tab_bar = false
config.window_decorations = "RESIZE"
config.color_scheme = "nord"

config.wsl_domains = {
	{
		name = "WSL:NixOS",
		distribution = "NixOS",
		username = "aundre",
		default_cwd = "~",
	},
}

config.default_domain = "WSL:NixOS"

config.window_close_confirmation = "NeverPrompt"

-- ==============================================================================
-- GLYPH ALIGNMENT & TMUX BLEEDING FIXES
-- ==============================================================================
-- Prevents custom Nerd Font icons from overflowing their cell boxes
config.unidatacompliant_shape = false

-- Forces ambiguous width symbols (like chevrons) to respect standard cell columns
config.treat_east_asian_ambiguous_width_as_wide = false

-- Micro-adjust character spacing to prevent pixel bleeding past splits if needed
config.cell_width = 1.0

return config
-- example code for using wezterm as a multiplexer
-- config.leader = { key = "b", mods = "CTRL", timeout_milliseconds = 1000 }
--
-- config.keys = {
-- 	{
-- 		key = "%",
-- 		mods = "LEADER|SHIFT",
-- 		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
-- 	},
-- }
