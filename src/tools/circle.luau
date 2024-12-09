local Types = require(script.Parent.Parent.Types)
local options = require(script.Parent.Parent.options)
local createOption = require(script.Parent.Parent.utils.createOption)

local toolOptions: { Types.ToolOption } = {
	{
		name = "Radius Based Segments",
		description = "If the segments should change based on the radius of the circle given",
		option = createOption(options.boolean, true),
	},
}

type Options = {
	["Radius Based Segments"]: Types.OptionWithValue<boolean>,
}

return {
	name = "Circle",
	description = "Create a circle with two attachments",
	iconId = 108293982982972,
	options = toolOptions,
	createBeam = function(options: Options, attachments, beam)
		if #attachments > 2 then
			warn(
				"Circle tool only allows for only 2 attachments to be selected!"
			)
			return {}
		end

		local beams = {
			beam:Clone(),
			beam:Clone(),
		}

		local attachmentA, attachmentB = attachments[1], attachments[2]
		local radius = math.abs(
			(attachmentA.Position - attachmentB.Position).Magnitude
		) / 2
		local curve = radius * 4 / 3

		beams[1].Attachment0 = attachmentA
		beams[1].Attachment1 = attachmentB
		beams[1].CurveSize0 = -curve
		beams[1].CurveSize1 = curve
		beams[1].Parent = attachmentA

		beams[2].Attachment0 = attachmentB
		beams[2].Attachment1 = attachmentA
		beams[2].CurveSize0 = curve
		beams[2].CurveSize1 = -curve
		beams[2].Parent = attachmentA

		if options["Radius Based Segments"].value() then
			print("hi")
			beams[1].Segments = radius * 10
			beams[2].Segments = radius * 10
		end

		return beams
	end,
} :: Types.ToolDefinition
