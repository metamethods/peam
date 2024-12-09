local Types = require(script.Parent.Parent.Types)
local vide = require(script.Parent.Parent.packages.vide)

local function createOption<T>(
	option: Types.Option<T>,
	default: T
): Types.OptionWithValue<T>
	return {
		value = vide.source(default),
		type = option.type,
		validator = option.validator,
	}
end

return createOption
