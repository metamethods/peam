local Fragment = require(script.Parent.Fragment)
local Types = require(script.Parent.Parent.Parent.Types)
local vide = require(script.Parent.Parent.Parent.packages.vide)

type ScrollingFrameProps = {
	size: Types.SourcedAs<UDim2>?,
	layout: vide.vScrollingFrame?,
}

local function ScrollingPage(
	children: Types.Components
): (props: ScrollingFrameProps) -> ScrollingFrame
	return function(props)
		return vide.create("ScrollingFrame") {
			Name = "ScrollingFrame",
			BackgroundTransparency = 1,
			Size = props.size or UDim2.fromScale(1, 1),
			CanvasSize = UDim2.fromScale(0, 0),
			AutomaticCanvasSize = Enum.AutomaticSize.Y,
			ScrollBarThickness = 0,

			props.layout,

			Fragment(children) {},
		}
	end
end

return ScrollingPage
