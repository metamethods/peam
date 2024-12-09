export type ToolbarButtonProps = {
	toolbar: PluginToolbar,
	id: string,
	text: string?,
	tooltip: string,
	icon: string,
	onClick: () -> ()?,
}

local function ToolbarButton(props: ToolbarButtonProps): PluginToolbarButton
	local button = props.toolbar:CreateButton(
		props.id,
		props.tooltip,
		props.icon,
		props.text
	)

	button.Click:Connect(function()
		button:SetActive(true)
		button:SetActive(false)
		if props.onClick then
			props.onClick()
		end
	end)

	return button
end

return ToolbarButton
