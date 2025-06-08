local wezterm = WEZTERM
local act = wezterm.action

-- Set up some reference values
local Chord = "SHIFT|CTRL"
local LeaderChord = "LEADER|SHIFT|CTRL"
local LeaderShift = "LEADER|SHIFT"
local LeaderCtrl = "LEADER|CTRL"

local FuzzyLaunch = "FUZZY|TABS|DOMAINS|WORKSPACES|COMMANDS|LAUNCH_MENU_ITEMS|KEY_ASSIGNMENTS"

local resurrect = wezterm.plugin.require("https://github.com/MLFlexer/resurrect.wezterm")

wezterm.on("get-pane-domain", function(window, pane)
	local domain = pane:get_domain_name()
	window:toast_notification("WezTerm", "Current Pane Domain: " .. domain, nil, 3000)
end)

wezterm.on("toggle-opacity", function(window, pane)
	local overrides = window:get_config_overrides() or {}
	if not overrides.window_background_opacity then
		overrides.window_background_opacity = 1
	else
		overrides.window_background_opacity = nil
	end
	window:set_config_overrides(overrides)
end)

local opts = {
	-- leader = { key = " ", mods = "CTRL", timeout_milliseconds = 1500 },
	keys = {
		{ key = ";", mods = "CTRL", action = act.ActivateCommandPalette },
		{ -- Quick launch
			key = "x",
			mods = LeaderCtrl,
			action = act.ShowLauncherArgs({
				title = "Quick Launch",
				flags = FuzzyLaunch,
			}),
		},
		-- Toggle transparency
		{
			key = "b",
			mods = "CTRL|SHIFT|ALT",
			action = wezterm.action.EmitEvent("toggle-opacity"),
		},
		-- Panes
		{
			key = "Enter",
			mods = "CTRL|SHIFT|ALT",
			action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
		},
		{
			key = "Enter",
			mods = "CTRL|SHIFT",
			action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
		},
		{
			key = "w",
			mods = "CTRL|SHIFT",
			action = wezterm.action.CloseCurrentPane({ confirm = true }),
		},
		{
			key = "LeftArrow",
			mods = "CTRL|SHIFT",
			action = wezterm.action.AdjustPaneSize({ "Left", 1 }),
		},
		{
			key = "RightArrow",
			mods = "CTRL|SHIFT",
			action = wezterm.action.AdjustPaneSize({ "Right", 1 }),
		},
		{
			key = "UpArrow",
			mods = "CTRL|SHIFT",
			action = wezterm.action.AdjustPaneSize({ "Up", 1 }),
		},
		{
			key = "DownArrow",
			mods = "CTRL|SHIFT",
			action = wezterm.action.AdjustPaneSize({ "Down", 1 }),
		},
		{
			key = "j",
			mods = "CTRL|SHIFT",
			action = wezterm.action.ActivatePaneDirection("Down"),
		},
		{
			key = "k",
			mods = "CTRL|SHIFT",
			action = wezterm.action.ActivatePaneDirection("Up"),
		},
		{
			key = "h",
			mods = "CTRL|SHIFT",
			action = wezterm.action.ActivatePaneDirection("Left"),
		},
		{
			key = "l",
			mods = "CTRL|SHIFT",
			action = wezterm.action.ActivatePaneDirection("Right"),
		},
		{
			key = "z",
			mods = "CTRL|SHIFT",
			action = wezterm.action.TogglePaneZoomState,
		},
		{
			key = "r",
			mods = "CTRL|SHIFT",
			action = wezterm.action.PaneSelect({ mode = "SwapWithActiveKeepFocus" }),
		},
		-- Cycle to the next pane
		{
			key = "}",
			mods = "CTRL|SHIFT",
			action = wezterm.action({ ActivatePaneDirection = "Next" }),
		},

		-- Cycle to the previous pane
		{
			key = "{",
			mods = "CTRL|SHIFT",
			action = wezterm.action({ ActivatePaneDirection = "Prev" }),
		},

		-- Rotate panes
		{
			key = "b",
			mods = "CTRL|SHIFT",
			action = wezterm.action.RotatePanes("CounterClockwise"),
		},
		{ key = "n", mods = "CTRL|SHIFT", action = wezterm.action.RotatePanes("Clockwise") },

		-- Quick Select
		{
			key = "Space",
			mods = "CTRL|SHIFT",
			action = wezterm.action.QuickSelect,
		},
		-- Activate copy mode
		{
			key = "x",
			mods = "CTRL|SHIFT",
			action = wezterm.action.ActivateCopyMode,
		},
		-- Clipboard
		{
			key = "c",
			mods = "CTRL|SHIFT",
			action = wezterm.action.CopyTo("Clipboard"),
		},
		{
			key = "v",
			mods = "CTRL|SHIFT",
			action = wezterm.action.PasteFrom("Clipboard"),
		},
		-- Font size
		{
			key = "-",
			mods = "CTRL",
			action = wezterm.action.DecreaseFontSize,
		},
		{
			key = "+",
			mods = "CTRL|SHIFT",
			action = wezterm.action.IncreaseFontSize,
		},
		{
			key = "0",
			mods = "CTRL",
			action = wezterm.action.ResetFontSize,
		},
		-- Tabs
		{
			key = "t",
			mods = "CTRL|SHIFT",
			action = wezterm.action.SpawnTab("CurrentPaneDomain"),
		},
		{
			key = "t",
			mods = "CTRL|SHIFT|ALT",
			action = wezterm.action.PromptInputLine({
				description = "Enter a new title for the current tab",
				action = wezterm.action_callback(function(window, _, line)
					if line then
						window:active_tab():set_title(line)
					end
				end),
			}),
		},
		{
			key = "Tab",
			mods = "CTRL",
			action = wezterm.action.ActivateTabRelative(1),
		},
		{
			key = "Tab",
			mods = "CTRL|SHIFT",
			action = wezterm.action.ActivateTabRelative(-1),
		},
		{
			key = "1",
			mods = "CTRL",
			action = wezterm.action.ActivateTab(0),
		},
		{
			key = "2",
			mods = "CTRL",
			action = wezterm.action.ActivateTab(1),
		},
		{
			key = "3",
			mods = "CTRL",
			action = wezterm.action.ActivateTab(2),
		},
		{
			key = "4",
			mods = "CTRL",
			action = wezterm.action.ActivateTab(3),
		},
		{
			key = "5",
			mods = "CTRL",
			action = wezterm.action.ActivateTab(4),
		},
		{
			key = "6",
			mods = "CTRL",
			action = wezterm.action.ActivateTab(5),
		},
		{
			key = "7",
			mods = "CTRL",
			action = wezterm.action.ActivateTab(6),
		},
		{
			key = "8",
			mods = "CTRL",
			action = wezterm.action.ActivateTab(7),
		},
		{
			key = "9",
			mods = "CTRL",
			action = wezterm.action.ActivateTab(8),
		},
		-- Search
		{
			key = "f",
			mods = "CTRL|SHIFT",
			action = wezterm.action.Search({ CaseSensitiveString = "" }),
		},
		-- Scrollback
		{
			key = "PageUp",
			mods = "CTRL|SHIFT",
			action = wezterm.action.ScrollByPage(-1),
		},
		{
			key = "PageDown",
			mods = "CTRL|SHIFT",
			action = wezterm.action.ScrollByPage(1),
		},
		{
			key = "Home",
			mods = "CTRL|SHIFT",
			action = wezterm.action.ClearScrollback("ScrollbackOnly"),
		},
		{ key = "L", mods = "CTRL", action = wezterm.action.ShowDebugOverlay },
		-- Command palette
		{
			key = "w",
			mods = "ALT",
			action = wezterm.action_callback(function(win, pane)
				resurrect.state_manager.save_state(resurrect.workspace_state.get_workspace_state())
			end),
		},
		{ -- Rename [W]orkspace
			key = "w",
			mods = LeaderCtrl,
			action = act.PromptInputLine({
				description = "Enter new name for the workspace:",
				action = wezterm.action_callback(function(window, _, line)
					if line then
						wezterm.mux.rename_workspace(wezterm.mux.get_active_workspace(), line)
					end
				end),
			}),
		},
		{
			key = "W",
			mods = "ALT",
			action = resurrect.window_state.save_window_action(),
		},
		{
			key = "s",
			mods = "ALT",
			action = wezterm.action_callback(function(win, pane)
				resurrect.state_manager.save_state(resurrect.workspace_state.get_workspace_state())
				resurrect.window_state.save_window_action()
			end),
		},
		{
			key = "T",
			mods = "ALT",
			action = resurrect.tab_state.save_tab_action(),
		},
		{
			key = "d",
			mods = "ALT",
			action = wezterm.action_callback(function(win, pane)
				resurrect.fuzzy_loader.fuzzy_load(win, pane, function(id)
					resurrect.state_manager.delete_state(id)
				end, {
					title = "Delete State",
					description = "Select State to Delete and press Enter = accept, Esc = cancel, / = filter",
					fuzzy_description = "Search State to Delete: ",
					is_fuzzy = true,
				})
			end),
		},
		{
			key = "r",
			mods = "ALT",
			action = wezterm.action_callback(function(win, pane)
				resurrect.fuzzy_loader.fuzzy_load(win, pane, function(id, label)
					local type = string.match(id, "^([^/]+)") -- match before '/'
					id = string.match(id, "([^/]+)$") -- match after '/'
					id = string.match(id, "(.+)%..+$") -- remove file extention
					local opts = {
						relative = true,
						restore_text = true,
						on_pane_restore = resurrect.tab_state.default_on_pane_restore,
					}
					if type == "workspace" then
						local state = resurrect.state_manager.load_state(id, "workspace")
						resurrect.workspace_state.restore_workspace(state, opts)
					elseif type == "window" then
						local state = resurrect.state_manager.load_state(id, "window")
						resurrect.window_state.restore_window(pane:window(), state, opts)
					elseif type == "tab" then
						local state = resurrect.state_manager.load_state(id, "tab")
						resurrect.tab_state.restore_tab(pane:tab(), state, opts)
					end
				end)
			end),
		},
	},
}

return opts
