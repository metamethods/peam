local vide = require(script.Parent.Parent.Parent.packages.vide)

export type RoundProps = {
	radius: UDim?,
	layout: vide.vUICorner?,
}

local function Round(props: RoundProps): UICorner
	return vide.create("UICorner")({
		CornerRadius = props.radius or UDim.new(0, 8),
		props.layout,
	})
end

return Round
