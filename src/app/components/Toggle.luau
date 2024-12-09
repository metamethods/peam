local Button = require(script.Parent.Button)
local vide = require(script.Parent.Parent.Parent.packages.vide)

local function Boolean(value: vide.Source<boolean>): TextButton
	return Button {
		text = function()
			return if value() then "Enabled" else "Disabled"
		end,
		onClick = function()
			value(not value())
		end,
	}
end

return Boolean
