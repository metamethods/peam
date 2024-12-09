local vide = require(script.Parent.Parent.Parent.packages.vide)

export type PaddingProps = { UDim }

local function Padding(padding: PaddingProps): UIPadding
	return vide.create("UIPadding")({
		PaddingTop = padding[1] or UDim.new(0, 8),
		PaddingRight = padding[2] or padding[1] or UDim.new(0, 8),
		PaddingBottom = padding[3] or padding[1] or UDim.new(0, 8),
		PaddingLeft = padding[4] or padding[2] or padding[1] or UDim.new(0, 8),
	})
end

return Padding
