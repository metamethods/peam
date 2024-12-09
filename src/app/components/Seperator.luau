local Types = require(script.Parent.Parent.Parent.Types)
local vide = require(script.Parent.Parent.Parent.packages.vide)
local theme = require(script.Parent.Parent.Parent.theme)

type SeperatorProps = {
	color: Types.SourcedAs<Color3>?,
}

local function Seperator(props: SeperatorProps): Frame
	return vide.create "Frame" {
		Name = "Seperator",
		Size = UDim2.new(1, 0, 0, 1),
		BackgroundColor3 = props.color
			or theme(Enum.StudioStyleGuideColor.Light),
	}
end

return Seperator
