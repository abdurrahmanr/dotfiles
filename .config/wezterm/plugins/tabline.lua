local wezterm = WEZTERM
local config = CONFIG
local tabline = WEZTERM.plugin.require("https://github.com/michaelbrusegard/tabline.wez")

local tab_config = {
	options = {
		icons_enabled = true,
		tabs_enabled = true,
		theme_overrides = {
			normal_mode = {
				a = { bg = "#C5C9C7", fg = "#090E13" },
				b = { bg = "#090E13", fg = "#C5C9C7" },
				c = { bg = "#090E13", fg = "#C5C9C7" },
			},
			tab = {
				active = { fg = "#090E13", bg = "#C5C9C7" },
				inactive = { fg = "#C5C9C7", bg = "#090E13" },
				inactive_hover = { fg = "", bg = "#313244" },
			},
		},
		section_separators = {
			left = wezterm.nerdfonts.ple_left_half_circle_thick,
			right = wezterm.nerdfonts.ple_left_half_circle_thick,
		},
		component_separators = {
			left = wezterm.nerdfonts.ple_right_half_circle_thin,
			right = wezterm.nerdfonts.ple_left_half_circle_thin,
		},
		tab_separators = {
			left = wezterm.nerdfonts.ple_right_half_circle_thick,
			right = wezterm.nerdfonts.ple_left_half_circle_thick,
		},
	},
	sections = {
		tabline_a = {},
		tabline_b = {},
		tabline_c = {},
		tab_active = {
			"index",
			{ "parent", padding = 0 },
			"/",
			{ "cwd", padding = { left = 0, right = 1 } },
			{ "zoomed", padding = 0 },
		},
		tab_inactive = { "index", { "process", padding = { left = 0, right = 1 } } },
		tabline_x = { "ram", "cpu" },
		tabline_y = { "battery" },
	},
	extensions = {},
}

tabline.setup(tab_config)

local function apply_tabline_config(conf)
	conf.use_fancy_tab_bar = false
	conf.show_new_tab_button_in_tab_bar = false
	conf.tab_bar_at_bottom = false
	conf.tab_max_width = 64
	conf.enable_tab_bar = false
	conf.window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	}
	local colors = require("tabline.config").theme
	local normbg = colors.normal_mode.b.bg
	conf.colors = {
		tab_bar = {
			background = normbg,
			inactive_tab_edge = normbg,
		},
	}
	conf.status_update_interval = 500
end

apply_tabline_config(config)
