local module = {
	force_reverse_video_cursor = true,
	colors = {
		foreground = "#24262D",
		background = "#f2f1ef",

		cursor_bg = "#f2f1ef",
		cursor_fg = "#24262D",
		cursor_border = "#24262D",

		selection_fg = "#24262D",
		selection_bg = "#dddddb",

		scrollbar_thumb = "#dddddb",
		split = "#dddddb",

		ansi = {
			"#f2f1ef",
			"#c84053",
			"#6e915f",
			"#77713f",
			"#b5cbd2",
			"#b35b79",
			"#597b75",
			"#e2e1df",
		},
		brights = {
			"#e2e1df",
			"#E46876",
			"#87A987",
			"#E6C384",
			"#7FB4CA",
			"#938AA9",
			"#7AA89F",
			"#24262D",
		},
	},
}

function module.apply_to_config(config)
	config.colors = module.colors
end

return module
