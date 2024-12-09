local Types = require(script.Parent.Parent.Types)
local options = require(script.Parent.Parent.options)
local createOption = require(script.Parent.Parent.utils.createOption)

local toolOptions: { Types.ToolOption } = {
	{
		name = "Curve",
		description = "If the path should curve",
		option = createOption(options.boolean, false),
	},
}

type Options = {
	Curve: Types.OptionWithValue<boolean>,
}

return {
	name = "Path",
	description = "Draw a path of beams",
	iconId = 129376718560246,
	options = toolOptions,
	createBeam = function(options: Options, attachments, beam)
		local beams = {}

		for i = 1, #attachments - 1 do
			local newBeam = beam:Clone()
			newBeam.Attachment0 = attachments[i]
			newBeam.Attachment1 = attachments[i + 1]
			newBeam.Parent = attachments[i]

			if options.Curve.value() then
				print "hi"
				local distance = (
					attachments[i].Position - attachments[i + 1].Position
				).Magnitude / 2 * 4 / 3
				newBeam.CurveSize0 = -distance
				newBeam.CurveSize1 = -distance
				newBeam.Segments = distance * 10
			end

			table.insert(beams, newBeam)
		end

		return beams
	end,
} :: Types.ToolDefinition
