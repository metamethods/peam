local vide = require(script.Parent.packages.vide)
local studioTheme = require(script.Parent.studioTheme)

local function theme(
	color: Enum.StudioStyleGuideColor,
	modifier: Enum.StudioStyleGuideModifier?
): vide.Source<Color3>
	return function()
		return studioTheme():GetColor(color, modifier)
	end
end

return theme
