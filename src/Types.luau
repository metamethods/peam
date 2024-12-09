local vide = require(script.Parent.packages.vide)

export type SourcedAs<T> = T | vide.Source<T>
export type Components = SourcedAs<{ Instance }>
export type Component = SourcedAs<Instance>

export type ToolDefinition = {
	name: string,
	description: string,
	iconId: number,
	options: { ToolOption },
	createBeam: (
		options: { [string]: OptionWithValue },
		attachments: { Attachment },
		beam: Beam
	) -> { Beam },
}

export type ToolOption = {
	name: string,
	description: string,
	option: OptionWithValue,
}

export type Option<T> = {
	type: string,
	validator: (T) -> boolean,
}

export type OptionWithValue<T = any> = {
	value: vide.Source<T>,
} & Option<T>

return nil
