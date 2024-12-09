-- TODO: Path preview

local Selecton = game:GetService("Selection")
local ChangeHistoryService = game:GetService("ChangeHistoryService")

local Types = require(script.Parent.Types)
local vide = require(script.Parent.packages.vide)
local theme = require(script.Parent.theme)
local Button = require(script.components.Button)
local Fragment = require(script.components.Fragment)
local Padding = require(script.components.Padding)
local ScrollingFrame = require(script.components.ScrollingFrame)
local Seperator = require(script.components.Seperator)
local Text = require(script.components.Text)
local Toggle = require(script.components.Toggle)

local function App(tool: vide.Source<Types.ToolDefinition>): ScrollingFrame
	local selection: vide.Source<{ Attachment }> = vide.source({})
	local beamTemplate: vide.Source<Beam?> = vide.source()

	local disabled = function()
		return #selection() <= 1
	end

	local toolOptions = function()
		return tool().options
	end

	local options = function()
		local options = {}

		for _, toolOption in toolOptions() do
			options[toolOption.name] = toolOption.option
		end

		return options
	end

	local updateSelection = function(instances: { Instance })
		if #instances >= 10_000 then
			warn(
				"It seems like youve selected over 10k instances or more, Peam wont process this huge selection to prevent studio from crashing!"
			)
			return
		end

		beamTemplate(nil)

		local attachments = {}

		for _, instance in ipairs(instances) do
			if instance:IsA("Attachment") then
				table.insert(attachments, instance)
			elseif instance:IsA("Beam") then
				beamTemplate(instance)
			end
		end

		selection(attachments)
	end

	updateSelection(Selecton:Get())
	vide.cleanup(Selecton.SelectionChanged:Connect(function()
		updateSelection(Selecton:Get())
	end))

	return ScrollingFrame {
		Fragment {
			Text {
				text = function()
					return `Currently selected tool <b>{tool().name}</b>`
				end,
				textSize = 20,
			},
			Text {
				text = function()
					return tool().description
				end,
				color = theme(Enum.StudioStyleGuideColor.SubText),
			},
		} {
			padding = UDim.new(0, 4),
		},
		Seperator {},

		Fragment {
			Text {
				text = function()
					return `Selected attachments <b>{#selection()}</b>`
				end,
				color = theme(Enum.StudioStyleGuideColor.SubText),
			},
			Text {
				text = function()
					local beamTemplate = beamTemplate()
					return `Selected beam <b>{if beamTemplate
						then beamTemplate:GetFullName()
						else "None"}</b>`
				end,
				color = theme(Enum.StudioStyleGuideColor.SubText),
			},
		} {
			padding = UDim.new(0, 4),
		},
		Seperator {},

		Button {
			text = "Insert Beams",
			disabled = disabled,
			onClick = function()
				tool().createBeam(
					options(),
					selection(),
					beamTemplate() or Instance.new("Beam")
				)
				ChangeHistoryService:SetWaypoint("Inserted Beams")
			end,
		},
		Seperator {},

		vide.indexes(toolOptions, function(option)
			return Fragment {
				Fragment {
					Text {
						text = function()
							return option().name
						end,
						textSize = 20,
					},
					Text {
						text = function()
							return option().description
						end,
						color = theme(Enum.StudioStyleGuideColor.SubText),
					},
				} {
					padding = UDim.new(0, 4),
				},
				vide.switch(function()
					return option().option.type
				end)({
					boolean = function()
						return Toggle(option().option.value)
					end,
				}),
			} {}
		end),

		Padding {},
	} {}
end

return App
