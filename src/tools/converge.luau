local Types = require(script.Parent.Parent.Types)
-- local options = require(script.Parent.Parent.options)
-- local createOption = require(script.Parent.Parent.utils.createOption)

local toolOptions: { Types.ToolOption } = {}

return {
	name = "Converge",
	description = "Make beams converge to one point",
	iconId = 118294987325180,
	options = toolOptions,
	createBeam = function(_, attachments, beam)
		local beams = {}

		for i = 2, #attachments do
			local newBeam = beam:Clone()
			newBeam.Attachment0 = attachments[1]
			newBeam.Attachment1 = attachments[i]
			newBeam.Parent = attachments[1]
			table.insert(beams, newBeam)
		end

		return beams
	end,
} :: Types.ToolDefinition
