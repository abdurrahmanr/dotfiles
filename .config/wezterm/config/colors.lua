--          ╭─────────────────────────────────────────────────────────╮
--          │                         COLORS                          │
--          ╰─────────────────────────────────────────────────────────╯
-- Load WezTerm module
local wezterm = WEZTERM

local opts = {
	color_scheme = "kanso-zen",
	adjust_window_size_when_changing_font_size = false,
	force_reverse_video_cursor = true,
	window_background_opacity = 0.75,
	kde_window_background_blur = true,
	window_decorations = "NONE",
	font = wezterm.font("MonoLisa Nerd Font"),
	font_size = 12,
	max_fps = 120,
	default_cursor_style = "BlinkingBlock",
}

return opts
