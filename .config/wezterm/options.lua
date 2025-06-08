--          ╭─────────────────────────────────────────────────────────╮
--          │                         CONFIG                          │
--          ╰─────────────────────────────────────────────────────────╯

local opts = {}

-- Function to merge tables into opts
local function merge_into_opts(mod)
	for k, v in pairs(require("config." .. mod)) do
		opts[k] = v
	end
end

-- List of default config modules to merge
local modules = {
	"colors",
	"keys",
}

-- Merge all default modules into opts
for _, mod in ipairs(modules) do
	merge_into_opts(mod)
end

-- Return config options table
return opts
