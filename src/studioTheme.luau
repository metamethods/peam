local vide = require(script.Parent.packages.vide)

local studio = settings():GetService("Studio")

local currentTheme = vide.source(studio.Theme)

studio.ThemeChanged:Connect(function()
	currentTheme(studio.Theme)
end)

return currentTheme
