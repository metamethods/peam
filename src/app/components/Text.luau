local Types = require(script.Parent.Parent.Parent.Types)
local vide = require(script.Parent.Parent.Parent.packages.vide)
local theme = require(script.Parent.Parent.Parent.theme)

export type TextProps = {
	text: Types.SourcedAs<string>,
	textSize: Types.SourcedAs<number>?,
	color: Types.SourcedAs<Color3>?,
	layout: vide.vTextLabel?,
}

local function Text(props: TextProps): TextLabel
	return vide.create("TextLabel")({
		Name = "Text",
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.XY,

		Text = props.text,
		RichText = true,
		TextColor3 = props.color or theme(Enum.StudioStyleGuideColor.MainText),
		TextSize = props.textSize or 16,
		FontFace = Font.fromName("Montserrat", Enum.FontWeight.Medium),
		TextXAlignment = Enum.TextXAlignment.Left,
		TextWrapped = true,

		props.layout,
	})
end

return Text
