--          ╭─────────────────────────────────────────────────────────╮
--          │                   WORKSPACE SWITCHER                    │
--          ╰─────────────────────────────────────────────────────────╯

local M = {}
local wezterm = WEZTERM

WORKSPACE_SWITCHER = wezterm.plugin.require("https://github.com/MLFlexer/smart_workspace_switcher.wezterm")

wezterm.on("augment-command-palette", function()
	local workspace_state = RESURRECT.workspace_state
	return {
		{
			brief = "Window | Workspace: Switch Workspace",
			icon = "md_briefcase_arrow_up_down",
			action = WORKSPACE_SWITCHER.switch_workspace(),
		},
		{
			brief = "Window | Workspace: Rename Workspace",
			icon = "md_briefcase_edit",
			action = wezterm.action.PromptInputLine({
				description = "Enter new name for workspace",
				action = wezterm().action_callback(function(_, _, line)
					if line then
						wezterm.mux.rename_workspace(wezterm.mux.get_active_workspace(), line)
						RESURRECT.save_state(workspace_state.get_workspace_state())
					end
				end),
			}),
		},
	}
end)

return M
