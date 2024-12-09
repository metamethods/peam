local Types = require(script.Parent.Parent.Parent.Types)
local vide = require(script.Parent.Parent.Parent.packages.vide)

type FragmentProps = {
	padding: Types.SourcedAs<UDim>?,
	frameProps: vide.vFrame?,
}

local function Fragment(
	children: Types.Components
): (props: FragmentProps) -> Frame
	return function(props)
		return vide.create "Frame" {
			Name = "Fragment",
			Size = UDim2.fromScale(1, 0),
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundTransparency = 1,

			children,
			props.frameProps,

			vide.create "UIListLayout" {
				Padding = props.padding or UDim.new(0, 8),
			},
		}
	end
end

return Fragment
