local Padding = require(script.Parent.Padding)
local Types = require(script.Parent.Parent.Parent.Types)
local vide = require(script.Parent.Parent.Parent.packages.vide)
local studioTheme = require(script.Parent.Parent.Parent.studioTheme)
local theme = require(script.Parent.Parent.Parent.theme)
local Round = require(script.Parent.Round)

export type ButtonProps = {
	text: Types.SourcedAs<string>?,
	disabled: vide.Source<boolean>?,
	active: vide.Source<boolean>?,
	onClick: () -> ()?,
	layout: vide.vTextButton?,
	children: Types.Components?,
}

local function Button(props: ButtonProps): TextButton
	local hovering = vide.source(false)
	local pressed = vide.source(false)
	local disabled = props.disabled or vide.source(false)
	local active = props.active or vide.source(false)

	local backgroundColor = function()
		if disabled() then
			return theme(
				Enum.StudioStyleGuideColor.Button,
				Enum.StudioStyleGuideModifier.Disabled
			)()
		end

		if active() then
			return theme(
				Enum.StudioStyleGuideColor.Button,
				Enum.StudioStyleGuideModifier.Selected
			)()
		end

		if hovering() and not pressed() then
			return theme(
				Enum.StudioStyleGuideColor.Button,
				Enum.StudioStyleGuideModifier.Hover
			)()
		end

		if pressed() then
			return theme(
				Enum.StudioStyleGuideColor.Button,
				Enum.StudioStyleGuideModifier.Pressed
			)()
		end

		return theme(Enum.StudioStyleGuideColor.Button)()
	end

	local textColor = function()
		if disabled() then
			return theme(
				Enum.StudioStyleGuideColor.ButtonText,
				Enum.StudioStyleGuideModifier.Disabled
			)()
		end

		if active() then
			return theme(
				Enum.StudioStyleGuideColor.ButtonText,
				Enum.StudioStyleGuideModifier.Selected
			)()
		end

		return theme(
			Enum.StudioStyleGuideColor.ButtonText,
			Enum.StudioStyleGuideModifier.Default
		)()
	end

	return vide.create("TextButton")({
		Name = "Button",
		BackgroundColor3 = vide.spring(backgroundColor, 0.1),
		AutomaticSize = Enum.AutomaticSize.XY,

		Text = props.text,
		TextColor3 = vide.spring(textColor, 0.1),
		TextSize = 16,
		FontFace = Font.fromName("Montserrat", Enum.FontWeight.Medium),

		vide.create("UIStroke")({
			Color = function()
				return studioTheme().Name == "Light"
						and theme(Enum.StudioStyleGuideColor.ButtonBorder)()
					or Color3.new()
			end,
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
			Transparency = function()
				return studioTheme().Name == "Dark" and 1 or 0
			end,
		}),

		MouseEnter = function()
			hovering(true)
		end,

		MouseLeave = function()
			hovering(false)
			pressed(false)
		end,

		MouseButton1Down = function()
			pressed(true)
		end,

		MouseButton1Up = function()
			pressed(false)
		end,

		Activated = function()
			if not disabled() and props.onClick then
				props.onClick()
			end
		end,

		Padding({ UDim.new(0, 8) }),
		Round({}),

		props.layout,
		props.children,
	})
end

return Button
