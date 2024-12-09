local Types = require(script.Parent.Types)

local boolean: Types.Option<boolean> = {
	type = "boolean",
	validator = function()
		return true
	end,
}

return {
	boolean = boolean,
}
