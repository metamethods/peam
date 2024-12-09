local app = require(script.app)
local vide = require(script.packages.vide)
local Toolbar = require(script.studio.Toolbar)
local ToolbarButton = require(script.studio.ToolbarButton)
local Widget = require(script.studio.Widget)
local tools = require(script.tools)
local mount = require(script.utils.mount)

local selectedTool = vide.source(tools.path)

local toolbar = Toolbar {
	name = "Peam",
	plugin = plugin,
}

local widget = Widget {
	id = "Peam",
	title = "Peam",
	dockState = Enum.InitialDockState.Float,
	enabled = false,
	floatSize = Vector2.new(300, 400),
	minSize = Vector2.new(300, 400),
	zIndexBehavior = Enum.ZIndexBehavior.Sibling,
	plugin = plugin,
}

for _, tool in pairs(tools) do
	ToolbarButton {
		text = tool.name,
		tooltip = tool.description,
		icon = `rbxassetid://{tool.iconId}`,
		id = tool.name,
		onClick = function()
			-- this is a REALLLY scuffed workaround, bc vide's reactivity system kinda sucks lol
			local options = tool.options
			tool.options = {}
			selectedTool(tool)
			tool.options = options
			selectedTool(tool)
			widget.Enabled = true
		end,
		toolbar = toolbar,
	}
end

mount(app, widget, selectedTool)
