local vide = require(script.Parent.Parent.packages.vide)

local function mount<A...>(
	component: (A...) -> Instance?,
	parent: Instance,
	...: A...
)
	local arguments = table.pack(...)
	return vide.mount(function()
		return component(table.unpack(arguments))
	end, parent)
end

return mount
