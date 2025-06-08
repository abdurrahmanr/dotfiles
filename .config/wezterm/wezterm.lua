WEZTERM = require("wezterm")
CONFIG = WEZTERM.config_builder()

-- Load Options
local opts = require("options")

-- Apply config
for k, v in pairs(opts) do
	CONFIG[k] = v
end

-- Load plugins
require("plugins")

-- Load Menus
CONFIG.launch_menu = require("menus")

-- config.keys = merge.all(config.keys, resurrect.keys)

return CONFIG
