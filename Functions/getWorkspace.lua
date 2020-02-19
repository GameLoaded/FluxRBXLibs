--[[
	getWorkspace.lua
	--------------------
	Author(s): AdministratorGnar
--]]
local CollectionService = game:GetService("CollectionService")

return function(folder)
    return CollectionService:GetTagged(string.format("Workspace_%s", folder))[1]
end